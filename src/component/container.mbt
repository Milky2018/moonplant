struct Container {
  width : Int
  height : Int
  children : Array[(&Component, Align)]
}

pub fn container(width : Int, height : Int, children : Array[(&Component, Align)]) -> Container {
  Container::{ width, height, children }
}

pub impl Component for Container with size(self) {
  Vector2::new(self.width, self.height)
}

pub impl Component for Container with draw(self, canvas, x, y) {
  for i in 0..<self.height {
    for j in 0..<self.width {
      canvas.write_char(' ', x + j, y + i)
    }
  }
  for child in self.children {
    let (component, alignment) = child
    let component_size = component.size()
    let max_width = self.width
    let max_height = self.height
    let offset = align(alignment, component_size.x, component_size.y, max_width, max_height)
    component.draw(canvas, x + offset.x, y + offset.y)
  }
}

test "Container" {
  let pic = container(10, 10, [
    (border(text("Hello")), TopRight),
    (border(text("World")), BottomLeft),
  ]) |> paint
  let expected =
    #|
    #|   +-----+
    #|   |Hello|
    #|   +-----+
    #|          
    #|          
    #|          
    #|          
    #|+-----+   
    #||World|   
    #|+-----+   
    #|
  assert_eq!(pic, expected)
}
