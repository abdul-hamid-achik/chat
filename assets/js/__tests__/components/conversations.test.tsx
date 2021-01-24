import React from "react"
import { MockedProvider } from '@apollo/client/testing'
import { shallow, ShallowWrapper } from "enzyme"
import Conversations from "~/components/conversations"

const user: User = {
    id: "1",
    email: "fakeemail@gmail.com"
}

const mocks = []
let wrapper: ShallowWrapper | undefined

beforeEach(() => {
    wrapper = shallow(
        <MockedProvider mocks={mocks} addTypename={false}>
            <Conversations user={user} />
        </MockedProvider>
    )
})

describe("`<Conversations />`", () => {
    it("renders correctly and matches snapshot", () => {
        expect(wrapper).toMatchSnapshot()
    })
})