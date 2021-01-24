import React from "react"
import { shallow, ShallowWrapper } from "enzyme"
import Home from "~/pages/home"

import { Provider } from 'react-redux'
import store from '~/store'
let wrapper: ShallowWrapper | undefined
beforeEach(() => {
    wrapper = shallow(<Provider store={store}>
        <Home />
    </Provider>)
})

describe("`<Home />`", () => {
    it("renders correctly and matches snapshot", () => {
        expect(wrapper).toMatchSnapshot()
    })
})