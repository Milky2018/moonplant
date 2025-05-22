///|
struct Abs {
  component : &Component
  x : Int
  y : Int
}

///|
pub fn abs(component : &Component, x : Int, y : Int) -> Abs {
  { component, x, y }
}

///|
pub impl Component for Abs with draw(self, canvas, _x, _y) {
  self.component.draw(canvas, self.x, self.y)
}

pub impl Component for Abs with size(_self) {
  Vector2::new(0, 0)
}

///|
test "Abs" {
  let pic = v_box([text("Alice"), abs(text("Bob"), 3, 2), text("Carol")]) |> paint
  let expected =
    #|
    #|Alice
    #|Carol
    #|   Bob
    #|
  assert_eq!(pic, expected)
}
