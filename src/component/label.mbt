///|
pub(all) enum Position {
  Top
  Bottom
  Left
  Right
}

///|
pub fn label(
  component : &Component,
  caption : String,
  position : Position
) -> &Component {
  let text_label = text(caption)
  match position {
    Left => {
      h_box([text_label, component]) as &Component
    }
    Right => h_box([component, text_label])
    Bottom => v_box([component, text_label])
    Top => v_box([text_label, component])
  }
}
