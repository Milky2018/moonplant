///|
struct Hook {
  callback : (Canvas, Int, Int) -> Unit
  component : &Component
}

///|
pub fn hook(
  component : &Component,
  callback : (Canvas, Int, Int) -> Unit
) -> Hook {
  { callback, component }
}

///|
pub impl Component for Hook with draw(self, canvas, x, y) {
  (self.callback)(canvas, x, y)
  self.component.draw(canvas, x, y)
}

///|
pub impl Component for Hook with size(self) {
  self.component.size()
}

///|
test "Hook" {
  let pos = Vector2::new(0, 0)
  let callback = fn(_canvas, x, y) {
    pos.x = x
    pos.y = y
  }
  let pic = v_box([text("Hello"), hook(text("World"), callback)]) |> paint
  let expected =
    #|
    #|Hello
    #|World
    #|
  assert_eq!(pic, expected)
  assert_eq!(pos, Vector2::new(0, 1))
}
