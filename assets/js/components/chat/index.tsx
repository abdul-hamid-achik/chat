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

const Chat: React.FC<Props> = ({ conversation }) =>
  // @ts-ignore
  !console.log(conversation) && <Container>
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

// import React, { useState, useRef, useEffect, useCallback } from 'react'
// import { useQuery, useMutation, useSubscription } from '@apollo/client'
// import ReactTimeAgo from 'react-time-ago'
// import { useDropzone } from 'react-dropzone'
// import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
// import { faUser, faPaperclip, faTimes, faUpload, faFileArchive } from '@fortawesome/free-solid-svg-icons'
// import moment from 'moment'
// import 'moment-timezone'
// import Error from '~/components/error'
// import Loading from '~/components/loading'
// import CREATE_MESSAGE_MUTATION from '~/api/mutations/create_message.gql'
// import CREATE_ATTACHMENT_MUTATION from '~/api/mutations/create_attachment.gql'
// import CONVERSATION_SUBSCRIPTION from '~/api/subscriptions/conversation.gql'
// import GET_MESSAGES from '~/api/queries/messages.gql'

// interface ChatProps {
//     conversation: Conversation
// }

// interface ChatMessageProps {
//     message: Message,
//     newest: Boolean
// }

// interface ChatAttachmentUploadProps {
//     files?: Array<File>,
//     conversation: Conversation,
//     removeFile: (file: File, index: number) => void
// }

// interface ChatAttachmentProps {
//     attachment: Attachment,
//     newest: Boolean
// }

// const timezone: string = moment.tz.guess()

// const ChatAttachment: React.FC<ChatAttachmentProps> = props => {
//     const ref = useRef<HTMLDivElement>(null)
//     useEffect(() => {
//         if (props.newest) ref.current?.scrollIntoView(true)
//     }, [props.newest])

//     const date = moment.utc(props.attachment.insertedAt).tz(timezone).toDate()
//     return <div className="flex space-x-3 px-6" ref={ref}>
//         <FontAwesomeIcon icon={faUser} className="h-6 w-6 rounded-full" />
//         <div className="flex-1 space-y-1">
//             <div className="flex items-center justify-between">
//                 {props.attachment.user ?
//                     <h3 className="text-sm font-medium">{props.attachment.user.email}</h3> :
//                     <h3 className="text-sm font-medium">{props.attachment.user_id}</h3>
//                 }
//                 <p className="text-sm text-gray-500">
//                     <ReactTimeAgo date={date} locale="en-US" />
//                 </p>
//             </div>
//             <p className="text-sm text-gray-500">
//                 {props.attachment.url}
//             </p>
//         </div>
//     </div>
// }

// const ChatAttachmentUpload: React.FC<ChatAttachmentUploadProps> = props => {
//     const [createAttachment, createAttachmentOptions] = useMutation(CREATE_ATTACHMENT_MUTATION)
//     const uploadAttachments = () => {
//         props.files?.forEach((file: File) => {
//             // TODO: maybe remove file from this component here `props.removeFile`
//             createAttachment({
//                 variables: {
//                     conversationId: props.conversation.id,
//                     attachment: file
//                 }
//             })
//         })
//     }

//     return <div className={`mt-1 flex-none justify-self-end ${props.files?.length === 0 && "hidden"}`}>
//         <div className="flex flex-row space-x-4">
//             {createAttachmentOptions.loading ?
//                 <Loading loading={true} />
//                 : props.files?.map((file: File, index: number) =>
//                     <div key={index} className="rounded-md p-4 border">
//                         <div className="flex">
//                             <div className="flex-shrink-0">
//                                 <FontAwesomeIcon icon={faFileArchive} className="h-5 w-5" />
//                             </div>
//                             <div className="ml-3">
//                                 <p className="text-sm font-medium text-black">
//                                     {file.name}
//                                 </p>
//                             </div>
//                             <div className="ml-auto pl-3">
//                                 <div className="-mx-1.5 -my-1.5">
//                                     <button onClick={() => props.removeFile(file, index)} className="inline-flex rounded-md p-1.5 text-black hover:bg-indigo-100 focus:outline-none focus:ring-2 focus:ring-offset-2">
//                                         <span className="sr-only">Dismiss</span>
//                                         <FontAwesomeIcon icon={faTimes} className="h-5 w-5" />
//                                     </button>
//                                 </div>
//                             </div>
//                         </div>
//                     </div>
//                 )}
//         </div>
//         <div className="px-4 py-3 bg-gray-50 sm:px-6 flex items-center justify-end">
//             <button className="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-base font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
//                 onClick={uploadAttachments}>
//                 Send <FontAwesomeIcon icon={faUpload} className="ml-3 -mr-1 h-5 w-5" />
//             </button>
//         </div>
//     </div>
// }

// const ChatMessage: React.FC<ChatMessageProps> = props => {
//     const ref = useRef<HTMLDivElement>(null)
//     useEffect(() => {
//         if (props.newest) ref.current?.scrollIntoView(true)
//     }, [props.newest])

//     const date = moment.utc(props.message.insertedAt).tz(timezone).toDate()
//     return <div className="flex space-x-3 px-6" ref={ref}>
//         <FontAwesomeIcon icon={faUser} className="h-6 w-6 rounded-full" />
//         <div className="flex-1 space-y-1">
//             <div className="flex items-center justify-between">
//                 {props.message.user ?
//                     <h3 className="text-sm font-medium">{props.message.user.email}</h3> :
//                     <h3 className="text-sm font-medium">{props.message.user_id}</h3>
//                 }
//                 <p className="text-sm text-gray-500">
//                     <ReactTimeAgo date={date} locale="en-US" />
//                 </p>
//             </div>
//             <p className="text-sm text-gray-500">{props.message.content}</p>
//         </div>
//     </div>
// }

// const Chat: React.FC<ChatProps> = (props) => {
//     const [messages, setMessages] = useState<Array<Message>>([])
//     const [files, setFiles] = useState<Array<File>>([])
//     const query = useQuery(GET_MESSAGES, {
//         variables: {
//             conversationId: props.conversation.id
//         }
//     })
//     const [content, setContent] = useState<string>("")
//     const textAreaRef = useRef<HTMLTextAreaElement>(null)
//     const [sendMessage, sendMessageOptions] = useMutation(CREATE_MESSAGE_MUTATION)
//     const subscription = useSubscription(CONVERSATION_SUBSCRIPTION, {
//         variables: { conversationId: props.conversation.id }
//     })
//     const onDrop = useCallback(files => setFiles(files), [])
//     const { getRootProps, getInputProps, isDragActive, open: openFileBrowser } = useDropzone({
//         onDrop,
//         noClick: true,
//         noKeyboard: true
//     })
//     const handleSend = () => {
//         setContent("")
//         sendMessage({ variables: { content, conversationId: props.conversation.id } })
//         if (textAreaRef.current) textAreaRef.current.value = ""
//     }

//     const removeFile = (_file: File, index: number) => {
//         setFiles(files.filter((_f, i) => i !== index))
//     }
//     useEffect(() => {
//         setMessages(query.data?.messages)
//     }, [query.data])

//     useEffect(() => {
//         setMessages(subscription.data?.conversationChange?.messages)
//     }, [subscription.data])

//     return <div className="flex flex-col items-stretch justify-between chat h-full">
//         <div className={`${subscription.error || query.error || query.loading ? "flex-auto" : "hidden"}`}>
//             <Error error={query.error} />
//             <Error error={subscription.error} />
//             <Loading message="Sending" loading={query.loading} />
//             {/* <Loading message="Loading" loading={subscription.loading} /> */}
//         </div>
//         <div className="overflow-y-scroll flex-grow">
//             <ul className="divide-y divide-gray-200 h-full">
//                 {messages?.map((message, index, array) => <li key={message.id} className="py-4">
//                     <ChatMessage message={message} newest={index === array.length - 1} />
//                 </li>)}
//             </ul>
//         </div>
//         <ChatAttachmentUpload files={files} conversation={props.conversation} removeFile={removeFile} />
//         <div className="flex-none justify-self-end">
//             <div className={`mt-1 flex-auto ${isDragActive && "border-dashed border-4 border-indigo-600"}`} {...getRootProps()}>
//                 {isDragActive && <p className="text-blue">Drop your files here</p>}
//                 <textarea
//                     ref={textAreaRef}
//                     onChange={event => setContent(event.target.value)}
//                     id="content"
//                     name="content"
//                     rows={3}
//                     className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 mt-1 block w-full sm:text-sm border-gray-300 rounded-md"
//                     placeholder="Write down a message!">
//                 </textarea>
//             </div>
//             <div className="px-4 py-3 bg-gray-50 sm:px-6 flex items-center justify-end space-x-4">
//                 <button onClick={openFileBrowser} className="inline-flex items-center p-2 border border-transparent rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
//                     <FontAwesomeIcon icon={faPaperclip} className="h-6 w-6" />
//                     <input className="hidden" {...getInputProps()} />
//                 </button>

//                 <button
//                     onClick={handleSend}
//                     className="bg-indigo-600 border border-transparent rounded-md shadow-sm py-2 px-4 inline-flex justify-center text-sm font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
//                     Send
//                 </button>
//             </div>
//         </div>
//     </div>
// }

// export default Chat