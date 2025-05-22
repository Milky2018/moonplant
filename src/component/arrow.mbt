///|
type LArrow HBox

pub impl Component for LArrow with draw(self, canvas, x, y) {
  self._.draw(canvas, x, y)
}

pub impl Component for LArrow with size(self) {
  self._.size()
}

///|
type RArrow HBox

pub impl Component for RArrow with draw(self, canvas, x, y) {
  self._.draw(canvas, x, y)
}

pub impl Component for RArrow with size(self) {
  self._.size()
}

///|
type UArrow VBox

pub impl Component for UArrow with draw(self, canvas, x, y) {
  self._.draw(canvas, x, y)
}

pub impl Component for UArrow with size(self) {
  self._.size()
}

///|
type DArrow VBox

pub impl Component for DArrow with draw(self, canvas, x, y) {
  self._.draw(canvas, x, y)
}

pub impl Component for DArrow with size(self) {
  self._.size()
}

///|
pub fn l_arrow(length : Int) -> LArrow {
  h_box([text("<"), h_line(length - 1)])
}

///|
pub fn r_arrow(length : Int) -> RArrow {
  h_box([h_line(length - 1), text(">")])
}

///|
pub fn u_arrow(length : Int) -> UArrow {
  v_box([text("^"), v_line(length - 1)])
}

///|
pub fn d_arrow(length : Int) -> DArrow {
  v_box([v_line(length - 1), text("v")])
}

///|
test "Arrows" {
  let pic = v_box([l_arrow(2), r_arrow(2), u_arrow(2), d_arrow(2)], align=Left) |> paint
  let expected =
    #|
    #|<-
    #|->
    #|^
    #||
    #||
    #|v
    #|
  assert_eq!(pic, expected)
}
