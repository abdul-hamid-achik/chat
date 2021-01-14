import React from "react"
import { shallow, ShallowWrapper } from "enzyme"
import App from "~/main"

let wrapper: ShallowWrapper | undefined

beforeEach(() => {
    wrapper = shallow(<App />)
})

describe("`<App />`", () => {
    it("renders correctly and matches snapshot", () => {
        expect(wrapper).toMatchSnapshot()
    })
})