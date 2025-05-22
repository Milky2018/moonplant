///|
struct Vector2[T] {
  mut x : T
  mut y : T
} derive(Show, Eq, Hash)

///|
fn Vector2::new[T](x : T, y : T) -> Vector2[T] {
  { x, y }
}
