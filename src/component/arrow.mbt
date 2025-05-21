///|
typealias LArrow = HBox

///|
typealias RArrow = HBox

///|
typealias UArrow = VBox

///|
typealias DArrow = VBox

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
  let canvas = Canvas::new()
  v_box([l_arrow(2), r_arrow(2), u_arrow(2), d_arrow(2)]).draw(canvas, 0, 0)
  |> ignore
  let expected =
    #|
    #|<-
    #|->
    #|^
    #||
    #||
    #|v
    #|
  assert_eq!(canvas.to_string(), expected)
}
