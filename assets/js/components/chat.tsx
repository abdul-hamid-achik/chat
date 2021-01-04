import React from "react"
import { useQuery, useMutation } from '@apollo/client'
import ReactTimeAgo from 'react-time-ago'
import Error from '~/components/error'
import Loading from '~/components/loading'
import CREATE_MESSAGE_MUTATION from '~/mutations/create_message.gql'
import GET_MESSAGES from '~/queries/messages.gql'

interface ChatProps {
    conversation: Conversation
}

const ChatMessage: React.FC<Message> = props =>
    <div className="flex space-x-3">
        <img className="h-6 w-6 rounded-full" src="" alt="" />
        <div className="flex-1 space-y-1">
            <div className="flex items-center justify-between">
                {props.user ?
                    <h3 className="text-sm font-medium">{props.user.email}</h3> :
                    <h3 className="text-sm font-medium">{props.user_id}</h3>
                }
                <p className="text-sm text-gray-500">
                    <ReactTimeAgo date={props.insertedAt} locale="en-US" />
                </p>
            </div>
            <p className="text-sm text-gray-500">{props.content}</p>
        </div>
    </div>

const Chat: React.FC<ChatProps> = (props) => {
    console.log(props)
    const { loading: loadingMessages, error: errorMessages, data } = useQuery(GET_MESSAGES, { variables: { conversation_id: props.conversation.id } })
    const [content, setContent] = React.useState<string>("")
    const [send_message, { error, loading }] = useMutation(CREATE_MESSAGE_MUTATION)
    const handleSend = () => {
        setContent("")
        send_message({ variables: { content, conversation_id: props.conversation.id } })
    }

    return <div>
        <Error error={error} />
        <Error error={errorMessages} />
        <Loading message="Sending" loading={loading} />
        <Loading message="Loading" loading={loadingMessages} />
        <ul className="divide-y divide-gray-200">
            {(data && data.messages || []).map(message => <li key={message.id} className="py-4">
                <ChatMessage {...message} />
            </li>)}
        </ul>
        <div className="mt-1">
            <textarea
                onChange={event => setContent(event.target.value)}
                id="content"
                name="content"
                rows={3}
                className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 mt-1 block w-full sm:text-sm border-gray-300 rounded-md"
                placeholder="Write down a message!">
            </textarea>
        </div>
        <div className="px-4 py-3 bg-gray-50 text-right sm:px-6">
            <button
                onClick={handleSend}
                className="bg-indigo-600 border border-transparent rounded-md shadow-sm py-2 px-4 inline-flex justify-center text-sm font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                Send
          </button>
        </div>
    </div>
}

export default Chat