///|
struct Border {
  component : &Component
}

///|
pub fn border(component : &Component) -> Border {
  { component, }
}

///|
impl Component for Border with draw(self, canvas, x, y) {
  let v = self.component.draw(canvas, x + 1, y + 1)
  let width = v.x + 2
  let height = v.y + 2
  canvas.write_char('+', x, y)
  canvas.write_char('+', x + width - 1, y)
  canvas.write_char('+', x, y + height - 1)
  canvas.write_char('+', x + width - 1, y + height - 1)
  h_line(width - 2).draw(canvas, x + 1, y) |> ignore
  h_line(width - 2).draw(canvas, x + 1, y + height - 1) |> ignore
  v_line(height - 2).draw(canvas, x, y + 1) |> ignore
  v_line(height - 2).draw(canvas, x + width - 1, y + 1) |> ignore
  { x: width, y: height }
}

///|
test "Text border" {
  let canvas = Canvas::new()
  let bordered_text = border(text("Hello"))
  bordered_text.draw(canvas, 0, 0) |> ignore
  let expected =
    #|
    #|+-----+
    #||Hello|
    #|+-----+
    #|
  assert_eq!(canvas.to_string(), expected)
}
