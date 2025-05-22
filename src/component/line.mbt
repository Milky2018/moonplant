///|
struct HLine {
  length : Int
}

///|
pub fn h_line(length : Int) -> HLine {
  { length, }
}

///|
pub impl Component for HLine with draw(self, canvas, x, y) {
  let line = "-".repeat(self.length)
  canvas.write_string(line, x, y)
}

///|
pub impl Component for HLine with size(self) {
  Vector2::new(self.length, 1)
}

///|
struct VLine {
  length : Int
}

///|
pub fn v_line(length : Int) -> VLine {
  { length, }
}

///|
pub impl Component for VLine with draw(self, canvas, x, y) {
  for i in 0..<self.length {
    canvas.write_char('|', x, y + i)
  }
}

///|
pub impl Component for VLine with size(self) {
  Vector2::new(1, self.length)
}

///|
test "HLine" {
  let pic = h_line(5) |> paint
  let expected = "\n-----\n"
  assert_eq!(pic, expected)
}

///|
test "VLine" {
  let pic = v_line(5) |> paint
  let expected =
    #|
    #||
    #||
    #||
    #||
    #||
    #|
  assert_eq!(pic, expected)
}
