import React from "react"
import { shallow, ShallowWrapper } from "enzyme"

import { MockedProvider } from '@apollo/client/testing'
import Login from "~/pages/login"
const mocks = []

let wrapper: ShallowWrapper | undefined

beforeEach(() => {
    wrapper = shallow(
        <MockedProvider mocks={mocks} addTypename={false}>
            <Login />
        </MockedProvider>
    )
})

describe("`<Login />`", () => {
    it("renders correctly and matches snapshot", () => {
        expect(wrapper).toMatchSnapshot()
    })
})