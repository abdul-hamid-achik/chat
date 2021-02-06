interface User {
    id: string
    email: string
    avatar?: string
    username?: string
    first_name?: string
    last_name?: string
    password?: string
}

interface Message {
    id: string
    user?: User
    user_id: string
    conversation_id: string
    content: string
    insertedAt: Date
    updatedAt: Date
}

interface Attachment {
    id: string
    conversation: Conversation
    user: User
    conversation_id?: string
    user_id?: string
    url: string
    insertedAt: Date
    updatedAt: Date
}

interface Conversation {
    id: string
    title: string
    members?: User[]
    messages?: Message[]
    attachments?: Attachment[]
    owner?: User
}

type AuthToken = string

declare module '*.gql' {
    import { DocumentNode } from 'graphql'

    const value: DocumentNode
    export = value
}