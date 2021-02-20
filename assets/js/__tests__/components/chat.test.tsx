import React from "react"
import { MockedProvider } from '@apollo/client/testing'
import CREATE_MESSAGE_MUTATION from "~/api/mutations/create_message.gql"
import Chat, { Form, Uploads } from "~/components/chat"

jest.useFakeTimers()

const conversation: Conversation = {
    id: "1",
    title: "Random conversation",
    messages: []
}
const mocks = [{
    request: {
        query: CREATE_MESSAGE_MUTATION,
        variables: {
            content: "New Message",
            conversationId: conversation.id
        }
    }
}]
let wrapper: ReactWrapper | undefined

beforeEach(() => {
    wrapper = mount(
        <MockedProvider mocks={[]} addTypename={false}>
            <Chat conversation={conversation} />
        </MockedProvider>
    )
})

describe("`<Chat />`", () => {
    it("renders correctly and matches snapshot", () => {
        expect(wrapper).toMatchSnapshot()
    })

    it("sends graphql mutation on submit", () => {
        wrapper = mount(
            <MockedProvider mocks={mocks} addTypename={false}>
                <Chat conversation={conversation} />
            </MockedProvider>
        )
        const textarea = wrapper?.find('textarea')
        textarea?.simulate('change', { target: { value: 'Hello' } })
        const submit = wrapper?.find('button[type="submit"]')
        submit?.simulate('click')
        expect(wrapper).toMatchSnapshot()
    })

    it("shows attachments above form when dropping them", () => {
        const file = new File([
            JSON.stringify({ ping: true })
        ], 'img.png', { type: 'image/png' })

        const mockedData = {
            dataTransfer: {
                files: [file],
                items: [{
                    kind: 'file',
                    type: file.type,
                    getAsFile: () => file
                }],
                types: ['Files']
            }
        }

        const form = wrapper?.find(Form)
        form?.simulate('drop', mockedData)
        expect(wrapper?.find(Uploads)).toBeTruthy()
    })
})