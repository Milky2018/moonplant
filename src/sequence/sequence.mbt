///|
struct Sequence {
  participants : Array[Participant]
  messages : Array[Message]
}

///|
pub fn Sequence::new(participants : Array[Participant]) -> Sequence {
  { participants, messages: [] }
}

///|
pub fn Sequence::add_message(self : Sequence, message : Message) -> Unit {
  self.messages.push(message)
}

///|
pub fn Sequence::to_component(self : Sequence) -> &@c.Component {
  @c.h_box(self.participants.map(fn(p) { @c.border(@c.text(p.name)) }))
}

test "Simple sequence" {
  let canvas = @c.Canvas::new()
  let p1 = Participant::new("Alice")
  let p2 = Participant::new("Bob")
  let sequence = Sequence::new([p1, p2])
  sequence.add_message(Message::new(p1, p2, "Hello"))
  sequence.add_message(Message::new(p2, p1, "Hi"))
  canvas.paint(sequence.to_component())
  let expected =
    #|
    #|+-----++---+
    #||Alice||Bob|
    #|+-----++---+
    #|
  assert_eq!(canvas.to_string(), expected)
}