struct Message {
  sender : Participant
  receiver : Participant
  content : String
}

pub fn Message::new(sender : Participant, receiver : Participant, content : String) -> Message {
  { sender, receiver, content }
}
