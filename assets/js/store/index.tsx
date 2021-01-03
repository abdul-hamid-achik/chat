import { configureStore } from "@reduxjs/toolkit"

import { createSlice } from "@reduxjs/toolkit"

export const messageSlice = createSlice({
    name: "messages",
    initialState: [],
    reducers: {
        addMessage: (state, action) => {
        },
        removeMessage: (state, action) => {
        }
    },
})

export default configureStore({
    reducer: {
        messages: messageSlice,
    },
})