///|
struct Layers {
  layers : Array[&Component]
}

///|
pub fn layers(layers : Array[&Component]) -> Layers {
  Layers::{ layers, }
}

///|
pub impl Component for Layers with draw(self, canvas, x, y) {
  for layer in self.layers {
    layer.draw(canvas, x, y)
  } 
}

pub impl Component for Layers with size(self) {
  let mut max_width = 0
  let mut max_height = 0
  for layer in self.layers {
    let v = layer.size()
    if max_height < v.y {
      max_height = v.y
    }
    if max_width < v.x {
      max_width = v.x
    }
  }
  Vector::new(max_width, max_height)
}

test "Layers" {
  let canvas = Canvas::new()
  let layer1 = text("Hello")
  let layer2 = v_box([text("1"), text("2")])
  let layers = layers([layer1, layer2])
  layers.draw(canvas, 0, 0) |> ignore
  let expected =
    #|
    #|1ello
    #|2
    #|
  assert_eq!(canvas.to_string(), expected)
}