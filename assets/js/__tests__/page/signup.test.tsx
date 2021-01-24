import React from "react"
import { shallow, ShallowWrapper } from "enzyme"
import { MockedProvider } from '@apollo/client/testing'
import SignUp from "~/pages/signup"
const mocks = []
let wrapper: ShallowWrapper | undefined
beforeEach(() => {
    wrapper = shallow(
        <MockedProvider mocks={mocks} addTypename={false}>
            <SignUp />
        </MockedProvider>
    )
})

describe("`<SignUp />`", () => {
    it("renders correctly and matches snapshot", () => {
        expect(wrapper).toMatchSnapshot()
    })
})