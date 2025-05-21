///|
struct HBox {
  components : Array[&Component]
  align : VAlign
}

///|
pub fn h_box(components : Array[&Component], align~ : VAlign = Center) -> HBox {
  HBox::{ components, align }
}

///|
pub impl Component for HBox with draw(self, canvas, x, y) {
  let rect = self.size()
  let mut cursor = x
  for component in self.components {
    let component_size = component.size()
    let max_height = rect.y
    let offset = align_vertical(self.align, component_size.y, max_height)
    component.draw(canvas, cursor, y + offset)
    cursor += component_size.x
  }
}

///|
pub impl Component for HBox with size(self) {
  let mut width = 0
  let mut max_height = 0
  for component in self.components {
    let v = component.size()
    if max_height < v.y {
      max_height = v.y
    }
    width += v.x
  }
  Vector::new(width, max_height)
}

///|
struct VBox {
  components : Array[&Component]
  align : HAlign
}

///|
pub fn v_box(components : Array[&Component], align~ : HAlign = Center) -> VBox {
  VBox::{ components, align }
}

///|
pub impl Component for VBox with draw(self, canvas, x, y) {
  let rect = self.size()
  let mut cursor = y
  for component in self.components {
    let component_size = component.size()
    let max_width = rect.x
    let offset = align_horizontal(self.align, component_size.x, max_width)
    component.draw(canvas, x + offset, cursor)
    cursor += component_size.y
  }
}

///|
pub impl Component for VBox with size(self) {
  let mut max_width = 0
  let mut height = 0
  for component in self.components {
    let v = component.size()
    height += v.y
    if max_width < v.x {
      max_width = v.x
    }
  }
  Vector::new(max_width, height)
}

///|
test "HBox" {
  let canvas = Canvas::new()
  let box = h_box([h_line(5), v_line(3), h_line(5)])
  box.draw(canvas, 0, 0) |> ignore
  let expected =
    #|
    #|     |
    #|-----|-----
    #|     |
    #|
  assert_eq!(canvas.to_string(), expected)
}

///|
test "VBox" {
  let canvas = Canvas::new()
  let box = v_box([text("Alice\nBob", align=Center), text("Carol")])
  box.draw(canvas, 0, 0) |> ignore
  let expected =
    #|
    #|Alice
    #| Bob
    #|Carol
    #|
  assert_eq!(canvas.to_string(), expected)
}
