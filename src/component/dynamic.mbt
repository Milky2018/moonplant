///|
struct DynamicAbs {
  callfront : (Canvas, Int, Int) -> (&Component, Int, Int)
}

///|
pub fn dynamic_abs(
  callfront : (Canvas, Int, Int) -> (&Component, Int, Int)
) -> DynamicAbs {
  { callfront, }
}

///|
pub impl Component for DynamicAbs with draw(self, canvas, x, y) {
  let (component, new_x, new_y) = (self.callfront)(canvas, x, y)
  component.draw(canvas, new_x, new_y)
}

///|
pub impl Component for DynamicAbs with size(_self) {
  Vector2::new(0, 0)
}

///|
test "Dynamic" {
  let callfront = fn(_canvas, x, y) {
    (v_box([text("Hello"), text("World")]) as &Component, x + 1, y + 1)
  }
  let pic = dynamic_abs(callfront) |> paint
  let expected =
    #|
    #|
    #| Hello
    #| World
    #|
  assert_eq!(pic, expected)
}
