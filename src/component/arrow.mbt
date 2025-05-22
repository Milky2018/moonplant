///|
pub fn l_arrow(length : Int) -> HBox {
  h_box([text("<"), h_line(length - 1)])
}

///|
pub fn r_arrow(length : Int) -> HBox {
  h_box([h_line(length - 1), text(">")])
}

///|
pub fn u_arrow(length : Int) -> VBox {
  v_box([text("^"), v_line(length - 1)])
}

///|
pub fn d_arrow(length : Int) -> VBox {
  v_box([v_line(length - 1), text("v")])
}

///|
test "Arrows" {
  let pic = v_box([l_arrow(2), r_arrow(2), u_arrow(2), d_arrow(2)], align=Left)
    |> paint
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
