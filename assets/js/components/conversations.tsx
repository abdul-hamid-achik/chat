import React, { useEffect, useRef, useState } from 'react'
import { useSelector } from 'react-redux'
import { useQuery, useMutation } from '@apollo/client'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faComments, faPlus } from '@fortawesome/free-solid-svg-icons'
import { useForm, useField } from 'react-final-form-hooks'
import { Drawer, Button, Sidenav, Nav, SelectPicker } from 'rsuite'
import GET_CONVERSATIONS from '~/api/queries/conversations.gql'
import CREATE_CONVERSATION from '~/api/mutations/create_conversation.gql'
import { layout, useAppDispatch, RootState } from '~/store'

interface ConversationsProps {
  user?: User
}

interface ConversationsQuery {
  conversations: Array<Conversation>
}

interface ConversationMutation {
  createConversation: Conversation
}
interface ValidationErrors {
  title?: "Required" | "Please add a more descriptive title"
}

const Conversations: React.FC<ConversationsProps> = props => {
  const [creating, setCreating] = useState<boolean>(false)
  const dispatch = useAppDispatch()
  const inputRef = useRef<HTMLInputElement>(null)
  const selectedConversation = useSelector((store: RootState) => store.layout.conversation)
  const query = useQuery<ConversationsQuery>(GET_CONVERSATIONS)
  const [create] = useMutation<ConversationMutation>(CREATE_CONVERSATION)
  const onSubmit = ({ title: conversationName }) => {
    create({ variables: { title: conversationName } })
    setCreating(false)
  }
  const validate = ({ title: conversationName }: Conversation) => {
    const errors: ValidationErrors = {}
    if (!conversationName) {
      errors.title = "Required"
    }

    if (conversationName && conversationName.length < 10) {
      errors.title = "Please add a more descriptive title"
    }
    return errors
  }
  const { form, handleSubmit } = useForm({
    onSubmit,
    validate
  })

  const title = useField('title', form)


  useEffect(() => {
    if (query.data) dispatch(layout.actions.setConversations(query.data.conversations))
  }, [query.data])

  return props.user ? <div style={{ width: 250 }}>
    <Drawer show={creating} onHide={() => setCreating(false)}>
      <Drawer.Body>
        <form onSubmit={handleSubmit}>
          <input
            {...title.input}
            className="p-2 w-full text-black"
            placeholder="title" />
          {title.meta.touched && title.meta.error && <p className="text-red-400 p-2 bg-red-50">{title.meta.error}</p>}
          <Button
            type="submit">
            <FontAwesomeIcon icon={faPlus} />
                Create
              </Button>
        </form>
      </Drawer.Body>
    </Drawer>
    <Sidenav>
      <Sidenav.Header>
        <Button onClick={() => setCreating(true)}>
          <FontAwesomeIcon icon={faComments} /> Create Conversation
        </Button>
      </Sidenav.Header>
      <Sidenav.Body>
        <Nav>
          <Nav.Item
            eventKey="conversations">
            <SelectPicker
              placeholder="Select Conversation"
              onChange={conversation => dispatch(layout.actions.setConversation(conversation))} data={(query.data?.conversations || []).map((conversation) => ({
                label: conversation.title,
                value: conversation,
                role: "conversations"
              }))} />
          </Nav.Item>
        </Nav>
      </Sidenav.Body>
    </Sidenav>
  </div> : <></>
}

export default Conversations
