///|
struct Participant {
  name : String
} derive(Eq, Hash, Show)

///|
pub fn Participant::new(name : String) -> Participant {
  Participant::{ name, }
}
