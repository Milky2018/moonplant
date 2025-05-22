///|
pub(open) trait Component {
  draw(Self, Canvas, Int, Int) -> Unit
  size(Self) -> Vector2[Int]
}
