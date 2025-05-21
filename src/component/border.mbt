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
  let child_size = self.component.size()
  self.component.draw(canvas, x + 1, y + 1)
  let width = child_size.x + 2
  let height = child_size.y + 2
  canvas.write_char('+', x, y)
  canvas.write_char('+', x + width - 1, y)
  canvas.write_char('+', x, y + height - 1)
  canvas.write_char('+', x + width - 1, y + height - 1)
  h_line(width - 2).draw(canvas, x + 1, y) |> ignore
  h_line(width - 2).draw(canvas, x + 1, y + height - 1) |> ignore
  v_line(height - 2).draw(canvas, x, y + 1) |> ignore
  v_line(height - 2).draw(canvas, x + width - 1, y + 1) |> ignore
}

impl Component for Border with size(self) {
  let v = self.component.size()
  Vector::new(v.x + 2, v.y + 2)
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
