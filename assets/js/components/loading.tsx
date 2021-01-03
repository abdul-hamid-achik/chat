import React from "react"
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faSpinner } from '@fortawesome/free-solid-svg-icons'

interface LoadingProps {
    message?: string
    loading: boolean
}

const Loading: React.FC<LoadingProps> = (props) =>
    props.loading ? <FontAwesomeIcon icon={faSpinner} spin={true} className="text-lg" /> : <></>
export default Loading