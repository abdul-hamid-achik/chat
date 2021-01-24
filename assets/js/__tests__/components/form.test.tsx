import React from "react"
import { shallow, ShallowWrapper } from "enzyme"
import Form from "~/components/form"

let wrapper: ShallowWrapper | undefined
beforeEach(() => {
    const submitMock = jest.fn()
    wrapper = shallow(<Form action="/url" method="get" submit={submitMock} />)
})

describe("`<Form />`", () => {
    it("renders correctly and matches snapshot", () => {
        expect(wrapper).toMatchSnapshot()
    })
})