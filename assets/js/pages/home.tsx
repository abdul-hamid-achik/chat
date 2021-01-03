import React from "react"
import Layout from "~/shared/layout"
import { useQuery } from '@apollo/client';
import GET_MESSAGES from '~/queries/messages.gql'
import Chat from '~/components/chat'

export default () => {
	const { loading, error, data } = useQuery(GET_MESSAGES)
	console.log(data)
	return <Layout>
		<Chat messages={data} />
	</Layout>
}