import React from 'react'
import { Sidebar, Content, Container } from 'rsuite'
import Layout from '~/shared/layout'
import Chat from '~/components/chat'
import Conversations from '~/components/conversations'
import { useSelector } from 'react-redux'
import { RootState } from '~/store'

export default () => {
	const conversation = useSelector((store: RootState) => store.layout.conversation)
	const user = useSelector((store: RootState) => store.layout.user)
	return <Layout>
		<Container>
			<Sidebar>
				{user && <Conversations user={user} />}
			</Sidebar>
			<Content>
				{user && conversation && conversation.id &&
					<Chat conversation={conversation} />}
			</Content>
		</Container>
	</Layout>
}