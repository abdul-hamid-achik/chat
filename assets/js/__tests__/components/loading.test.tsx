import React from "react"
import { shallow, ShallowWrapper } from "enzyme"
import Loading from "~/components/loading"

let wrapper: ShallowWrapper | undefined

beforeEach(() => {
    wrapper = shallow(<Loading loading={true} message="Random alert message" />)
})

describe("`<Loading />`", () => {
    it("renders correctly and matches snapshot", () => {
        expect(wrapper).toMatchSnapshot()
    })
})