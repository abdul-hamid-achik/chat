import React, { useEffect } from 'react'
import { useQuery } from '@apollo/client';
import { useSelector } from 'react-redux'
import { layout, useAppDispatch, RootState } from '~/store'
import GET_ME from '~/api/queries/me.gql'
import Navigation from '~/shared/navigation'
import Conversations from '~/components/conversations'
import Error from '~/components/error'
import Loading from '~/components/loading'
import { Container, Header, Content, Footer, Sidebar } from 'rsuite'

interface MeQuery {
	me?: User
}

interface Props {
}

const Layout: React.FC<Props> = props => {
	const dispatch = useAppDispatch()
	const user = useSelector((store: RootState) => store.layout.user)
	const { error, loading, data } = useQuery<MeQuery>(GET_ME)
	useEffect(() => {
		if (data && data.me)
			dispatch(layout.actions.setUser(data.me))
	}, [data])

	return <>
		<Container className="min-h-screen">
			<Header>
				<Navigation user={user} />
			</Header>
			<Error error={error} />
			<Loading loading={loading} />
			{props.children}
		</Container>
	</>
}

export default Layout