import React from "react"
import {
	Link
} from "react-router-dom"
import { useApolloClient } from "@apollo/client"
import { useHistory } from 'react-router-dom'
import { layout, useAppDispatch } from "~/store"

interface NavbarProps {
	user?: User
}

const Navbar: React.FC<NavbarProps> = (props) => {
	const client = useApolloClient()
	const history = useHistory()
	const dispatch = useAppDispatch()

	const handleLogout = () => {
		localStorage.removeItem("auth-token")
		client.resetStore()
		history.push("/")
		dispatch(layout.actions.setUser())
	}

	return <nav className="flex-shrink-0 bg-indigo-600">
		<div className="max-w-7xl mx-auto px-2 sm:px-4 lg:px-8">
			<div className="relative flex items-center justify-between h-16">
				<div className="flex items-center px-2 lg:px-0 xl:w-64">
					<div className="flex-shrink-0">
						<div className="h-8 w-auto">
							<h4 className="text-white">
								Chat
							</h4>
						</div>
					</div>
				</div>
				<div className="hidden lg:block lg:w-80">
					<div className="flex items-center justify-end">
						<div className="flex">
							<Link className="px-3 py-2 rounded-md text-sm font-medium text-indigo-200 hover:text-white" to="/">
								Home
							</Link>
							{!props.user ? <>
								<Link className="px-3 py-2 rounded-md text-sm font-medium text-indigo-200 hover:text-white" to="/login">
									Log in
								</Link>

								<Link className="px-3 py-2 rounded-md text-sm font-medium text-indigo-200 hover:text-white" to="/sign-up">
									Sign up
								</Link>
							</> : <>
									<a
										href="#"
										onClick={handleLogout}
										className="px-3 py-2 rounded-md text-sm font-medium text-indigo-200 hover:text-white">Exit</a>
								</>}
						</div>
					</div>
				</div>
			</div>
		</div>

		<div className="hidden lg:hidden">
			<div className="px-2 pt-2 pb-3">
				<Link className="block px-3 py-2 rounded-md text-base font-medium text-white bg-indigo-800" to="/" />
				<a href="#" className="mt-1 block px-3 py-2 rounded-md text-base font-medium text-indigo-200 hover:text-indigo-100 hover:bg-indigo-600">Support</a>
			</div>
			<div className="pt-4 pb-3 border-t border-indigo-800">
				<div className="px-2">
					<a href="#" className="block px-3 py-2 rounded-md text-base font-medium text-indigo-200 hover:text-indigo-100 hover:bg-indigo-600">Your Profile</a>
					<a href="#" className="mt-1 block px-3 py-2 rounded-md text-base font-medium text-indigo-200 hover:text-indigo-100 hover:bg-indigo-600">Settings</a>
					<a href="#" className="mt-1 block px-3 py-2 rounded-md text-base font-medium text-indigo-200 hover:text-indigo-100 hover:bg-indigo-600">Sign out</a>
				</div>
			</div>
		</div>
	</nav>
}

export default Navbar