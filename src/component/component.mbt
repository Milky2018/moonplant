///|
trait Component {
  draw(Self, Canvas, Int, Int) -> Unit
  size(Self) -> Vector[Int]
}
