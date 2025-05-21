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
impl Component for Abs with draw(self, canvas, _x, _y) {
  self.component.draw(canvas, self.x, self.y) |> ignore
  Vector::new(0, 0)
}

///|
test "Abs" {
  let canvas = Canvas::new()
  v_box([text("Alice"), abs(text("Bob"), 3, 2), text("Carol")]).draw(
    canvas, 0, 0,
  )
  |> ignore
  let expected =
    #|
    #|Alice
    #|Carol
    #|   Bob
    #|
  assert_eq!(canvas.to_string(), expected)
}
