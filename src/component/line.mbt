///|
struct HLine {
  length : Int
}

///|
pub fn h_line(length : Int) -> HLine {
  { length, }
}

///|
impl Component for HLine with draw(self, canvas, x, y) {
  let line = "-".repeat(self.length)
  canvas.write_string(line, x, y)
}

///|
impl Component for HLine with size(self) {
  Vector::new(self.length, 1)
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
impl Component for VLine with draw(self, canvas, x, y) {
  for i in 0..<self.length {
    canvas.write_char('|', x, y + i)
  }
}

///|
impl Component for VLine with size(self) {
  Vector::new(1, self.length)
}

///|
test "HLine" {
  let canvas = Canvas::new()
  h_line(5).draw(canvas, 0, 0) |> ignore
  let expected = "\n-----\n"
  assert_eq!(canvas.to_string(), expected)
}

///|
test "VLine" {
  let canvas = Canvas::new()
  v_line(5).draw(canvas, 0, 0) |> ignore
  let expected =
    #|
    #||
    #||
    #||
    #||
    #||
    #|
  assert_eq!(canvas.to_string(), expected)
}
