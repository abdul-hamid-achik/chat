import React from "react"
import { useMutation } from '@apollo/client'
import CREATE_MESSAGE_MUTATION from '~/mutations/create_message.gql'
import ChatMessage from "~/components/chat_message"
import Error from '~/components/error'

interface ChatProps {
    messages: Array<Message>
}

const Chat: React.FC<ChatProps> = (props) => {
    const [content, setContent] = React.useState<string>("")
    const [send_message, { error, loading, data }] = useMutation(CREATE_MESSAGE_MUTATION)
    const handleSend = () => {
        send_message({ variables: { content } })
    }
    return <div>
        <Error error={error} />
        {loading && <h4 className="py-4">Sending Message</h4>}
        <ul className="divide-y divide-gray-200">
            {props.messages.map(message => <li className="py-4">
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