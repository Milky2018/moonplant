///|
struct Blank {
  width : Int
  height : Int
}

///|
pub fn blank(width : Int, height : Int) -> Blank {
  Blank::{ width, height }
}

///|
pub impl Component for Blank with draw(self, canvas, x, y) {
  for i in 0..<self.height {
    for j in 0..<self.width {
      canvas.write_char(' ', x + j, y + i)
    }
  }
}

///|
pub impl Component for Blank with size(self) {
  Vector2::new(self.width, self.height)
}

///|
test "Blank" {
  let pic = blank(5, 3) |> paint
  let expected =
    #|
    #|     
    #|     
    #|     
    #|
  assert_eq!(pic, expected)
}
