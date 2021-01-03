import React from "react"
import Layout from '~/shared/layout'
import Form from '~/components/form'
import {
	Link
} from "react-router-dom"
import LOGIN_MUTATION from '~/mutations/login.gql'
import { useMutation } from '@apollo/client'

export default () => {
	const [login, { data }] = useMutation(LOGIN_MUTATION)
	const [email, setEmail] = React.useState<string>("")
	const [password, setPassword] = React.useState<string>("")
	const [passwordConfirmation, setPasswordConfirmation] = React.useState<string>("")

	const handleSubmit = event => {
		event.preventDefault()
		login({ variables: { email, password } })
	}

	return <Layout>
		<div className="flex flex-col justify-center py-12 sm:px-6 lg:px-8">
			<div className="sm:mx-auto sm:w-full sm:max-w-md">
				<h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
					Sign in to your account
    			</h2>
				<p className="mt-2 text-center text-sm text-gray-600 max-w">
					Or <Link to="/signup" className="font-medium text-indigo-600 hover:text-indigo-500">
						create a new one right here
					</Link>
				</p>
			</div>

			<div className="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
				<div className="bg-gray-50 py-8 px-4 shadow sm:rounded-lg sm:px-10">
					<Form action="/sessions/new" method="post" submit={handleSubmit}>
						<div>
							<label htmlFor="email" className="block text-sm font-medium text-gray-700">
								Email address
        					</label>
							<div className="mt-1">
								<input
									onChange={event => setEmail(event.target.value)}
									id="email"
									name="email"
									type="email"
									autoComplete="email"
									required
									className="appearance-none ßblock w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" />
							</div>
						</div>

						<div>
							<label htmlFor="password" className="block text-sm font-medium text-gray-700">
								Password
        					</label>
							<div className="mt-1">
								<input
									onChange={event => setPassword(event.target.value)}
									id="password"
									name="password"
									type="password"
									autoComplete="current-password"
									required
									className="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" />
							</div>
						</div>

						<div className="flex items-center justify-between">
							<div className="flex items-center">
								<input
									id="remember_me"
									name="remember_me"
									type="checkbox"
									className="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded" />
								<label htmlFor="remember_me" className="ml-2 block text-sm text-gray-900">
									Remember me
            					</label>
							</div>
							<div className="text-sm">
								<a href="#" className="font-medium text-indigo-600 hover:text-indigo-500">
									Forgot your password?
            					</a>
							</div>
						</div>

						<div>
							<button type="submit" className="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
								Sign in
        					</button>
						</div>
					</Form>

				</div>
			</div>
		</div>
	</Layout >
}