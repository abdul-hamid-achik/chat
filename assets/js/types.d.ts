interface User {
    avatar: string
    email: string
    username: string
    first_name: string
    last_name: string
}

interface Message {
    creator?: User
    creator_id: string
    content: string
    inserted_at: Date
    updated_at: Date
}

declare module '*.gql' {
    import { DocumentNode } from 'graphql'

    const value: DocumentNode
    export = value
}