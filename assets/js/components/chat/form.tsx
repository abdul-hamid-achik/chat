import React, { useState, useRef, useCallback } from 'react'
import { useMutation } from '@apollo/client'
import { useDropzone } from 'react-dropzone'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faPaperclip } from '@fortawesome/free-solid-svg-icons'
import { useForm, useField } from 'react-final-form-hooks'
import Uploads from "./uploads"
import CREATE_MESSAGE_MUTATION from '~/api/mutations/create_message.gql'
interface Props {
  conversation: Conversation
}

const Form: React.FC<Props> = (props) => {
  const [files, setFiles] = useState<Array<File>>([])
  const [sendMessage] = useMutation(CREATE_MESSAGE_MUTATION)
  const onSubmit = ({ content }: Message) => {
    sendMessage({ variables: { content, conversationId: props.conversation.id } })
    form.reset()
  }

  const validate = ({ content }: Message) => {
    const errors = {}
    return errors
  }
  const { form, handleSubmit } = useForm({
    onSubmit,
    validate
  })
  const content = useField('content', form)

  const onDrop = useCallback(files => setFiles(files), [])
  const { getRootProps, getInputProps, isDragActive, open: openFileBrowser } = useDropzone({
    onDrop,
    noClick: true,
    noKeyboard: true
  })

  const removeFile = (_file: File, index: number) => {
    setFiles(files.filter((_f, i) => i !== index))
  }


  return <>
    <Uploads files={files} conversation={props.conversation} removeFile={removeFile} />
    <form className="flex-none justify-self-end" onSubmit={handleSubmit}>
      <div className={`mt-1 flex-auto ${isDragActive && "border-dashed border-4 border-indigo-600"}`} {...getRootProps()}>
        {isDragActive && <p className="text-blue">Drop your files here</p>}
        <textarea
          {...content.input}
          rows={3}
          className="bg-black shadow-sm mt-1 block w-full sm:text-sm"
          placeholder="Write down a message!">
        </textarea>
      </div>
      <div className="px-4 py-3 bg-black sm:px-6 flex items-center justify-end space-x-4">
        <button onClick={openFileBrowser} className="inline-flex items-center p-2 border border-transparent rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          <FontAwesomeIcon icon={faPaperclip} className="h-6 w-6" />
          <input className="hidden" {...getInputProps()} />
        </button>

        <button
          type="submit"
          className="bg-indigo-600 border border-transparent rounded-md shadow-sm py-2 px-4 inline-flex justify-center text-sm font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          Send
        </button>
      </div>
    </form>
  </>
}

export default Form