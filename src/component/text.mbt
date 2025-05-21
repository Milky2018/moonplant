///|
struct Text {
  content : String
}

///|
pub fn text(content : String) -> Text {
  return Text::{ content, }
}

///|
impl Component for Text with draw(self, canvas, x, y) {
  let lines = self.content.split("\n")
  let mut max_width = 0
  let mut max_height = 0
  for line in lines {
    let line_length = line.length()
    canvas.write_string(line.to_string(), x, y + max_height)
    if max_width < line_length {
      max_width = line_length
    }
    max_height += 1
  }
  return Vector::new(max_width, max_height)
}

///|
test "Text" {
  let canvas = Canvas::new()
  text("Hello").draw(canvas, 0, 0) |> ignore
  let expected = "Hello\n"
  assert_eq!(canvas.to_string(), expected)
}

///|
test "Multi-line text" {
  let canvas = Canvas::new()
  let rect = text("Hello\nWorld").draw(canvas, 0, 0)
  let expected =
    #|Hello
    #|World
    #|
  assert_eq!(canvas.to_string(), expected)
  assert_eq!(rect, { x: 5, y: 2 })
}
