import React from "react"
import { shallow, ShallowWrapper } from "enzyme"
import Alert from "~/components/alert"

let wrapper: ShallowWrapper | undefined

beforeEach(() => {
    wrapper = shallow(<Alert type="error" message="Random alert message" />)
})

describe("`<Alert />`", () => {
    it("renders correctly and matches snapshot", () => {
        expect(wrapper).toMatchSnapshot()
    })
})