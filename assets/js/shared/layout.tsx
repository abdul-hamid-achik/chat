import React from "react"
import { useQuery } from '@apollo/client';
import { useSelector } from 'react-redux'
import { layout, useAppDispatch } from "~/store"
import GET_ME from '~/queries/me.gql'
import Navbar from "~/shared/navbar"
import Conversations from "~/components/conversations"
import Error from "~/components/error"
import Loading from "~/components/loading"

interface MeQuery {
	me?: User
}

interface Props {
}

const Layout: React.FC<Props> = props => {
	const dispatch = useAppDispatch()
	const user = useSelector<User>(store => store.layout.user)
	const { error, loading, data } = useQuery<MeQuery>(GET_ME)
	React.useEffect(() => {
		if (data && data.me)
			dispatch(layout.actions.setUser(data.me))
	}, [data])

	return <>
		<div className="fixed top-0 left-0 w-1/2 h-full bg-white" aria-hidden="true"></div>
		<div className="fixed top-0 right-0 w-1/2 h-full bg-gray-50" aria-hidden="true"></div>
		<div className="relative min-h-screen flex flex-col">
			{data && <Navbar user={user} />}
			<div className="flex-grow w-full max-w-7xl mx-auto xl:px-8 lg:flex">
				<div className="flex-1 min-w-0 bg-white xl:flex">
					<div className="hidden border-b border-gray-200 xl:border-b-0 xl:flex-shrink-0 xl:w-64 xl:border-r xl:border-gray-200 bg-white">
						<div className="h-full pl-4 pr-6 py-6 sm:pl-6 lg:pl-8 xl:pl-0">
							<div className="h-full relative" >
								<div className="absolute inset-0 border-4 border-gray-200 border-dashed rounded-lg"></div>
							</div>
						</div>
					</div>

					<div className="bg-white lg:min-w-0 lg:flex-1 overflow-y-scroll flex-auto">
						<div className="h-full py-6 px-4 sm:px-6 lg:px-8">
							<div className="relative h-full" >
								<Error error={error} />
								<Loading loading={loading} />
								{props.children}
							</div>
						</div>
					</div>
				</div>

				<div className="bg-gray-50 pr-4 sm:pr-6 lg:pr-8 lg:flex-shrink-0 lg:border-l lg:border-gray-200 xl:pr-0">
					<div className="h-full pl-6 lg:w-80">
						<div className="h-full relative" >
							{user && data && <Conversations user={user} />}
						</div>
					</div>
				</div>
			</div>
		</div>
	</>
}

export default Layout