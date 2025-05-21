///|
struct Vector[T] {
  x : T
  y : T
} derive(Show, Eq, Hash)

///|
fn Vector::new[T](x : T, y : T) -> Vector[T] {
  { x, y }
}
