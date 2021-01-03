import React from "react"

interface Props {
    action: string
    method: string
    submit: (event: React.FormEvent<HTMLFormElement>) => void
}

const Form: React.FC<Props> = props =>
    <form action={props.action} method={props.method} onSubmit={props.submit}>
        {props.children}
    </form>

export default Form