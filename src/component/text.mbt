///|
struct Text {
  content : String
  align : HAlign
}

///|
pub fn text(content : String, align~ : HAlign = Left) -> Text {
  return Text::{ content, align }
}

///|
impl Component for Text with draw(self, canvas, x, y) {
  let lines = self.content.split("\n")
  let max_width = self.size().x
  let mut offset = 0
  for line in lines {
    let len = line.length()
    let alignment = align_horizontal(self.align, len, max_width)
    canvas.write_string(line.to_string(), x + alignment, y + offset)
    offset += 1
  }
}

///|
impl Component for Text with size(self) {
  let lines = self.content.split("\n")
  let mut max_width = 0
  let mut max_height = 0
  for line in lines {
    let line_length = line.length()
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
  let expected = "\nHello\n"
  assert_eq!(canvas.to_string(), expected)
}

///|
test "Multi-line text" {
  let canvas = Canvas::new()
  text("Hello\nWorld").draw(canvas, 0, 0)
  let expected =
    #|
    #|Hello
    #|World
    #|
  assert_eq!(canvas.to_string(), expected)
}
