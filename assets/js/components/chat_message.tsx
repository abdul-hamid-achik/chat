import React from "react"
import { timeSince } from "~/helpers"

const ChatMessage: React.FC<Message> = props =>
    <div className="flex space-x-3">
        <img className="h-6 w-6 rounded-full" src="" alt="" />
        <div className="flex-1 space-y-1">
            <div className="flex items-center justify-between">
                {props.creator ?
                    <h3 className="text-sm font-medium">{props.creator.email}</h3> :
                    <h3 className="text-sm font-medium">{props.creator_id}</h3>
                }
                <p className="text-sm text-gray-500">{timeSince(props.inserted_at)}</p>
            </div>
            <p className="text-sm text-gray-500">{props.content}</p>
        </div>
    </div>

export default ChatMessage