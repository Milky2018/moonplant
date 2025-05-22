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
  let message_count = self.messages.length()
  let life = message_count * 2 + 1
  let start_y = Ref::new(0)
  let lifeline_xs = {}
  let calculate_message_start = fn(p) {
    fn(_canvas, x, y) {
      if y > start_y.val {
        start_y.val = y
      }
      lifeline_xs[p] = x
    }
  }
  @c.layers([
    @c.h_box(
      self.participants.map(fn(p) {
        @c.v_box([
          @c.border(@c.text(p.name)),
          @c.hook(@c.v_line(life), calculate_message_start(p)),
        ])
      }),
    ),
    @c.v_box(
      self.messages.mapi(fn(i, m) {
        @c.dynamic_abs(fn(_canvas, _x, _y) {
          let y = start_y.val + i * 2 + 1
          let sender_x = lifeline_xs.get(m.sender).unwrap()
          let receiver_x = lifeline_xs.get(m.receiver).unwrap()
          if sender_x < receiver_x {
            (@c.r_arrow(receiver_x - sender_x - 1), sender_x + 1, y)
          } else {
            (@c.l_arrow(sender_x - receiver_x - 1), receiver_x + 1, y)
          }
        })
      }),
    ),
  ])
}

///|
test "Simple sequence" {
  let p1 = Participant::new("Alice")
  let p2 = Participant::new("Bob")
  let sequence = Sequence::new([p1, p2])
  sequence.add_message(Message::new(p1, p2, "Hello"))
  sequence.add_message(Message::new(p2, p1, "Hi"))
  let pic = sequence.to_component() |> @c.paint
  let expected =
    #|
    #|+-----++---+
    #||Alice||Bob|
    #|+-----++---+
    #|   |     |
    #|   |---->|
    #|   |     |
    #|   |<----|
    #|   |     |
    #|
  assert_eq!(pic, expected)
}
