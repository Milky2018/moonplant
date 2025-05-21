///|
pub(all) enum HAlign {
  Left
  Center
  Right
}

///|
fn align_horizontal(align : HAlign, width : Int, max_width : Int) -> Int {
  match align {
    Left => 0
    Center => (max_width - width) / 2
    Right => max_width - width
  }
}

///|
pub(all) enum VAlign {
  Top
  Center
  Bottom
}

///|
fn align_vertical(align : VAlign, height : Int, max_height : Int) -> Int {
  match align {
    Top => 0
    Center => (max_height - height) / 2
    Bottom => max_height - height
  }
}

///|
pub(all) enum Align {
  TopLeft
  TopCenter
  TopRight
  CenterLeft
  Center
  CenterRight
  BottomLeft
  BottomCenter
  BottomRight
}

///|
fn align(
  alignment : Align,
  width : Int,
  height : Int,
  max_width : Int,
  max_height : Int
) -> Vector[Int] {
  let (ha, va) = match alignment {
    Align::TopLeft => (HAlign::Left, VAlign::Top)
    Align::TopCenter => (HAlign::Center, VAlign::Top)
    Align::TopRight => (HAlign::Right, VAlign::Top)
    Align::CenterLeft => (HAlign::Left, VAlign::Center)
    Align::Center => (HAlign::Center, VAlign::Center)
    Align::CenterRight => (HAlign::Right, VAlign::Center)
    Align::BottomLeft => (HAlign::Left, VAlign::Bottom)
    Align::BottomCenter => (HAlign::Center, VAlign::Bottom)
    Align::BottomRight => (HAlign::Right, VAlign::Bottom)
  }
  let x = align_horizontal(ha, width, max_width)
  let y = align_vertical(va, height, max_height)
  Vector::new(x, y)
}
