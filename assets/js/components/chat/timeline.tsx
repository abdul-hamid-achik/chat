import React, { useState, useEffect } from 'react'
import { useQuery, useSubscription } from '@apollo/client'
import Message from "./message"
import CONVERSATION_SUBSCRIPTION from '~/api/subscriptions/conversation.gql'
import GET_MESSAGES from '~/api/queries/messages.gql'

interface Props {
  conversation: Conversation
}

const Timeline: React.FC<Props> = (props) => {
  const [messages, setMessages] = useState<Array<Message>>([])
  const query = useQuery(GET_MESSAGES, {
    variables: {
      conversationId: props.conversation.id
    }
  })
  const subscription = useSubscription(CONVERSATION_SUBSCRIPTION, {
    variables: { conversationId: props.conversation.id }
  })
  useEffect(() => {
    setMessages(query.data?.messages)
  }, [query.data])

  useEffect(() => {
    setMessages(subscription.data?.conversationChange?.messages)
  }, [subscription.data])

  return <div className="overflow-y-scroll flex-grow">
    <ul className="divide-y divide-gray-200 h-full">
      {messages?.map((message, index, array) => <li key={message.id} className="py-4">
        <Message message={message} newest={index === array.length - 1} />
      </li>)}
    </ul>
  </div>
}

export default Timeline