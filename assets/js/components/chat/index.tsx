import React from "react"
import { Container, Header, Content, Footer } from "rsuite"
import Message from "./message"
import Attachment from "./attachment"
import Timeline from "./timeline"
import Uploads from "./uploads"
import Form from "./form"

interface Props {
  conversation: Conversation
}

const Chat: React.FC<Props> = ({ conversation }) => <Container>
  <Header>
  </Header>
  <Content>
    <Timeline conversation={conversation}></Timeline>
  </Content>
  <Footer>
    <Form conversation={conversation}></Form>
  </Footer>
</Container>

export default Chat
export {
  Message,
  Timeline,
  Uploads,
  Attachment,
  Form
}