pub(all) enum HAlign {
  Left
  Center
  Right
}

fn align_horizontal(align : HAlign, width : Int, max_width : Int) -> Int {
  match align {
    Left => 0
    Center => (max_width - width) / 2
    Right => max_width - width
  }
}

pub(all) enum VAlign {
  Top
  Center
  Bottom
}

fn align_vertical(align : VAlign, height : Int, max_height : Int) -> Int {
  match align {
    Top => 0
    Center => (max_height - height) / 2
    Bottom => max_height - height
  }
}