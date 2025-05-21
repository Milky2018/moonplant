///|
struct HBox {
  components : Array[&Component]
}

///|
pub fn h_box(components : Array[&Component]) -> HBox {
  HBox::{ components, }
}

///|
impl Component for HBox with draw(self, canvas, x, y) {
  let mut max_width = 0
  let mut max_height = 0
  let mut cursor = x
  for component in self.components {
    let v = component.draw(canvas, cursor, y)
    cursor += v.x
    if max_height < v.y {
      max_height = v.y
    }
    if max_width < v.x {
      max_width = v.x
    }
  }
  Vector::new(max_width, max_height)
}

///|
struct VBox {
  components : Array[&Component]
}

///|
pub fn v_box(components : Array[&Component]) -> VBox {
  VBox::{ components, }
}

///|
impl Component for VBox with draw(self, canvas, x, y) {
  let mut max_width = 0
  let mut max_height = 0
  for component in self.components {
    let v = component.draw(canvas, x, y + max_height)
    max_height += v.y
    if max_width < v.x {
      max_width = v.x
    }
  }
  Vector::new(max_width, max_height)
}

///|
test "HBox" {
  let canvas = Canvas::new()
  let box = h_box([h_line(5), v_line(3), h_line(5)])
  box.draw(canvas, 0, 0) |> ignore
  let expected =
    #|
    #|-----|-----
    #|     |
    #|     |
    #|
  assert_eq!(canvas.to_string(), expected)
}

///|
test "VBox" {
  let canvas = Canvas::new()
  let box = v_box([text("Alice\nBob"), text("Carol")])
  box.draw(canvas, 0, 0) |> ignore
  let expected =
    #|
    #|Alice
    #|Bob
    #|Carol
    #|
  assert_eq!(canvas.to_string(), expected)
}
