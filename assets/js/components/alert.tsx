import React from "react"
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faTimes, faCheck, faExclamation, faInfo } from '@fortawesome/free-solid-svg-icons'

type AlertType = "info" | "success" | "error" | "warning"
interface AlertProps {
    type: AlertType
    message: string
}

const getAlertColor = (type: AlertType) => {
    switch (type) {
        case "success":
            return "green"
        case "warning":
            return "yellow"
        case "error":
            return "red"
        default:
            return "blue"
    }
}

const Icon: React.FC<{ type: AlertType }> = ({ type }) => {
    let icon
    switch (type) {
        case "success":
            icon = faCheck
            break
        case "warning":
            icon = faExclamation
            break
        case "error":
            icon = faTimes
            break
        default:
            icon = faInfo
            break
    }
    return <FontAwesomeIcon icon={icon} className={`h-5 w-5 text-${getAlertColor(type)}-400`} />
}

// @ts-ignore
const Alert: React.FC<AlertProps> = ({ type, message }) => {
    return <div className="rounded-md bg-green-50 p-4">
        <div className="flex">
            <div className="flex-shrink-0">
                <Icon type={type} />
            </div>
            <div className="ml-3">
                <p className={`text-sm font-medium text-${getAlertColor(type)}-800`}>
                    {message}
                </p>
            </div>
            <div className="ml-auto pl-3">
                <div className="-mx-1.5 -my-1.5">
                    <button className="inline-flex bg-green-50 rounded-md p-1.5 text-green-500 hover:bg-green-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-green-50 focus:ring-green-600">
                        <span className="sr-only">Dismiss</span>
                        <FontAwesomeIcon icon={faTimes} className="h-5 w-5" />
                    </button>
                </div>
            </div>
        </div>
    </div>
}

export default Error
