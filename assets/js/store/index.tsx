import { configureStore, createSlice, combineReducers, PayloadAction } from "@reduxjs/toolkit"
import { useDispatch } from 'react-redux'

interface Layout {
    sidebar: boolean
    user?: User | undefined
    conversation?: Conversation | undefined
    conversations: Array<Conversation>
}

const layoutInitialState: Layout = { sidebar: true, conversations: [] }

export const layout = createSlice({
    name: "layout",
    initialState: layoutInitialState,
    reducers: {
        toggleSidebar: (state) => ({
            ...state, sidebar: !state.sidebar
        }),
        setUser: (state, action: PayloadAction<User | undefined>) => ({
            ...state,
            user: action.payload
        }),

        setConversation: (state, action: PayloadAction<Conversation>) => ({
            ...state,
            conversation: action.payload
        }),
        setConversations: (state, action: PayloadAction<Array<Conversation>>) => ({
            ...state,
            conversations: action.payload,
            conversation: action.payload[0]
        })
    },
})

export const rootReducer = combineReducers({
    layout: layout.reducer,
})

const store = configureStore({
    reducer: rootReducer,
})

export type AppDispatch = typeof store.dispatch
export type RootState = ReturnType<typeof rootReducer>
export const useAppDispatch = () => useDispatch<AppDispatch>()
export default store