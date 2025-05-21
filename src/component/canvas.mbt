///|
struct Canvas {
  pixels : Array[Array[Char]]
}

///|
pub fn Canvas::new() -> Canvas {
  let pixels = []
  { pixels, }
}

///|
fn Canvas::write_char(self : Canvas, c : Char, x : Int, y : Int) -> Unit {
  if y >= self.pixels.length() {
    let new_rows = Array::makei(y - self.pixels.length() + 1, fn(_) { [] })
    self.pixels.append(new_rows)
  }
  let row = self.pixels[y]
  if x >= row.length() {
    let new_cols = Array::make(x - row.length() + 1, ' ')
    row.append(new_cols)
  }
  row[x] = c
}

///|
fn Canvas::write_string(self : Canvas, s : String, x : Int, y : Int) -> Unit {
  for i, c in s {
    self.write_char(c, x + i, y)
  }
}

pub fn Canvas::paint(self : Canvas, component : &Component) -> Unit {
  component.draw(self, 0, 0) |> ignore
}

///|
pub fn Canvas::to_string(self : Canvas) -> String {
  let result = StringBuilder::new()
  for line in self.pixels {
    result.write_char('\n')
    result.write_string(@string.from_array(line))
  }
  result.write_char('\n')
  result.to_string()
}

///|
test "Canvas" {
  let canvas = Canvas::new()
  canvas.write_string("Hello", 1, 0)
  canvas.write_string("World", 1, 1)
  let s = canvas.to_string()
  let expected =
    #|
    #| Hello
    #| World
    #|
  assert_eq!(s, expected)
}

///|
test "Canvas out of bounds" {
  let canvas = Canvas::new()
  canvas.write_char('B', 2, 1)
  let s = canvas.to_string()
  let expected =
    #|
    #|
    #|  B
    #|
  assert_eq!(s, expected)
}
