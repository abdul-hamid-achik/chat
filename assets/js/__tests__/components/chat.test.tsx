import React from "react"
import { MockedProvider } from '@apollo/client/testing'
import { shallow, ShallowWrapper } from "enzyme"
import Chat from "~/components/chat"

const conversation: Conversation = {
    id: "1",
    title: "Random conversation",
    messages: []
}
const mocks = []
let wrapper: ShallowWrapper | undefined

beforeEach(() => {
    wrapper = shallow(
        <MockedProvider mocks={mocks} addTypename={false}>
            <Chat conversation={conversation} />
        </MockedProvider>
    )
})

describe("`<Chat />`", () => {
    it("renders correctly and matches snapshot", () => {
        expect(wrapper).toMatchSnapshot()
    })
})