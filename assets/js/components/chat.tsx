import React from "react"
import ChatMessage from "~/components/chat"
interface ChatProps {
    messages: Array<Message>
}

const Chat: React.FC<ChatProps> = ({ messages = [] }) =>
    <div>
        <ul className="divide-y divide-gray-200">
            {messages.map(message =>
                <li className="py-4">
                    {/* <ChatMessage {...message} /> */}
                </li>
            )}
        </ul>
    </div>

export default Chat