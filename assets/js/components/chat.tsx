import React, { useState, useRef, useEffect } from "react"
import { useQuery, useMutation, useSubscription } from '@apollo/client'
import ReactTimeAgo from 'react-time-ago'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faUser } from '@fortawesome/free-solid-svg-icons'
import moment from 'moment'
import 'moment-timezone'
import Error from '~/components/error'
import Loading from '~/components/loading'
import CREATE_MESSAGE_MUTATION from '~/mutations/create_message.gql'
import CONVERSATION_SUBSCRIPTION from '~/subscriptions/conversation.gql'
import GET_MESSAGES from '~/queries/messages.gql'

interface ChatProps {
    conversation: Conversation
}

const localizeDate = (date) => moment().tz(moment.tz.guess(true), date)

const ChatMessage: React.FC<Message> = props =>
    <div className="flex space-x-3 px-6">
        <FontAwesomeIcon icon={faUser} className="h-6 w-6 rounded-full" />
        <div className="flex-1 space-y-1">
            <div className="flex items-center justify-between">
                {props.user ?
                    <h3 className="text-sm font-medium">{props.user.email}</h3> :
                    <h3 className="text-sm font-medium">{props.user_id}</h3>
                }
                <p className="text-sm text-gray-500">
                    <ReactTimeAgo date={localizeDate(props.insertedAt)} locale="en-US" />
                </p>
            </div>
            <p className="text-sm text-gray-500">{props.content}</p>
        </div>
    </div>

const Chat: React.FC<ChatProps> = (props) => {
    const {
        loading: loadingMessages,
        error: errorMessages,
        data
    } = useQuery(GET_MESSAGES, {
        variables: {
            conversation_id: props.conversation.id,
            pollInterval: 200
        }
    })
    const [content, setContent] = useState<string>("")
    const textAreaRef = useRef<HTMLTextAreaElement>(null)
    const [send_message, { error, loading }] = useMutation(CREATE_MESSAGE_MUTATION)
    const {
        data: conversationSubscription,
        loading: isConversationUpdating
    } = useSubscription(CONVERSATION_SUBSCRIPTION, {
        variables: { conversationId: props.conversation.id }
    })
    const handleSend = () => {
        setContent("")
        send_message({ variables: { content, conversation_id: props.conversation.id } })
        if (textAreaRef.current) textAreaRef.current.value = ""
    }

    useEffect(() => {
        console.log(conversationSubscription)
    }, [isConversationUpdating, conversationSubscription])


    return <div className="flex flex-col">
        <div className="flex-auto">
            <Error error={error} />
            <Error error={errorMessages} />
            <Loading message="Sending" loading={loading} />
            <Loading message="Loading" loading={loadingMessages} />
        </div>
        <div className="flex-auto overflow-y-scroll" style={{ maxHeight: "calc(100vh - 13.75rem)" }}>
            <ul className="divide-y divide-gray-200" style={{ minHeight: "calc(100vh - 13.75rem)" }}>
                {(data && data.messages || []).map(message => <li key={message.id} className="py-4">
                    <ChatMessage {...message} />
                </li>)}
            </ul>
        </div>

        <div className="mt-1 flex-auto">
            <textarea
                ref={textAreaRef}
                onChange={event => setContent(event.target.value)}
                id="content"
                name="content"
                rows={3}
                className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 mt-1 block w-full sm:text-sm border-gray-300 rounded-md"
                placeholder="Write down a message!">
            </textarea>
        </div>
        <div className="px-4 py-3 bg-gray-50 text-right sm:px-6 flex-auto">
            <button
                onClick={handleSend}
                className="bg-indigo-600 border border-transparent rounded-md shadow-sm py-2 px-4 inline-flex justify-center text-sm font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                Send
          </button>
        </div>
    </div>
}

export default Chat