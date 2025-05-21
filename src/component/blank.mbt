struct Blank {
  width : Int 
  height : Int 
}

pub fn blank(width : Int, height : Int) -> Blank {
  Blank::{ width, height }
}

impl Component for Blank with draw(self, canvas, x, y) {
  for i in 0..<self.height {
    for j in 0..<self.width {
      canvas.write_char(' ', x + j, y + i)
    }
  }
}

impl Component for Blank with size(self) {
  Vector::new(self.width, self.height)
}

test "Blank" {
  let canvas = Canvas::new()
  blank(5, 3).draw(canvas, 0, 0)
  let expected =
    #|
    #|     
    #|     
    #|     
    #|
  assert_eq!(canvas.to_string(), expected)
}