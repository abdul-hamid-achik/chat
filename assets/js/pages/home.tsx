import React from "react"
import Layout from "~/shared/layout"
import { useQuery } from '@apollo/client';
import GET_MESSAGES from '~/queries/messages.gql'
import Chat from '~/components/chat'
import Error from '~/components/error'


export default () => {
	const { loading, error, data } = useQuery(GET_MESSAGES)
	return <Layout>
		<Error error={error} />
		{!loading ? <Chat messages={data.messages} /> : <h4 className="py-4">Loading...</h4>}
	</Layout>
}