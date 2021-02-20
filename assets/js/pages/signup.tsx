import React from 'react'
import Layout from '~/shared/layout'
import {
	Link
} from 'react-router-dom'
import { useForm, useField } from 'react-final-form-hooks'
import SIGN_UP_MUTATION from '~/api/mutations/sign-up.gql'
import { useMutation } from '@apollo/client'
import { useHistory } from 'react-router-dom'
import Error from '~/components/error'
import Loading from '~/components/loading'


type RequiredField = "Required"
type InvalidField = "Invalid"
type PasswordsShouldMatch = "Passwords should match"

interface ValidationErrors {
	email?: RequiredField | InvalidField,
	password?: RequiredField,
	passwordConfirmation?: RequiredField | PasswordsShouldMatch
}

export default () => {
	const [sign_up, { error, loading, data }] = useMutation(SIGN_UP_MUTATION)
	const history = useHistory()
	const onSubmit = ({ email, password, passwordConfirmation }) => {
		sign_up({ variables: { email, password, passwordConfirmation } })
			.then(() => form.reset())
			.catch(error => console.error(error))
	}

	const validate = ({ email, password, passwordConfirmation }) => {
		const errors: ValidationErrors = {}
		const isEmailValid = new RegExp(/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/g)
		if (!isEmailValid.test(email)) {
			errors.email = "Invalid"
		}

		if (!email) {
			errors.email = "Required"
		}

		if (!password) {
			errors.password = "Required"
		}

		if (!passwordConfirmation) {
			errors.passwordConfirmation = "Required"
		}

		if (password != passwordConfirmation) {
			errors.passwordConfirmation = "Passwords should match"
		}

		return errors
	}

	const { form, handleSubmit, submitting } = useForm({
		onSubmit,
		validate
	})

	const email = useField('email', form)
	const password = useField('password', form)
	const passwordConfirmation = useField('passwordConfirmation', form)
	const rememberMe = useField('rememberMe', form)

	React.useEffect(() => {
		if (data && data.signUp) {
			localStorage.setItem("auth-token", data.signUp.token)
			history.push("/")
		}
	}, [data])


	return <Layout>
		<Error error={error} />
		<div className="flex flex-col justify-center py-12 sm:px-6 lg:px-8">
			<div className="sm:mx-auto sm:w-full sm:max-w-md">
				<h2 className="mt-6 text-center text-3xl font-extrabold text-white">
					Create a new Account
    			</h2>
				<p className="mt-2 text-center text-sm text-white max-w">
					Or <Link to="/login" className="font-medium text-indigo-200 hover:text-indigo-300">
						sign in to yours
					</Link>
				</p>
			</div>

			<div className="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
				<div className="bg-gray-50 py-8 px-4 shadow sm:rounded-lg sm:px-10">
					<form onSubmit={handleSubmit}>
						<div>
							<label htmlFor="email" className="block text-sm font-medium text-gray-700">
								Email address
							</label>
							<div className="mt-1">
								<input
									{...email.input}
									type="email"
									className={`${email.meta.touched && email.meta.error && "text-red-900 placeholder-red-300"} appearance-none block w-full text-black px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm`} />
								{email.meta.touched && email.meta.error && <p className="mt-2 text-sm text-red-600">{email.meta.error}</p>}
							</div>
						</div>

						<div>
							<label htmlFor="password" className="block text-sm font-medium text-gray-700">
								Password
							</label>
							<div className="mt-1">
								<input
									{...password.input}
									type="password"
									className={`${password.meta.touched && password.meta.error && "text-red-900 placeholder-red-300"} appearance-none block w-full text-black  px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm`} />
								{password.meta.touched && password.meta.error && <p className="mt-2 text-sm text-red-600">{password.meta.error}</p>}
							</div>
						</div>

						<div>
							<label htmlFor="password_confirmation" className="block text-sm font-medium text-gray-700">
								Confirm Password
							</label>
							<div className="mt-1">
								<input
									{...passwordConfirmation.input}
									type="password"
									className={`${passwordConfirmation.meta.touched && passwordConfirmation.meta.error && "text-red-900 placeholder-red-300"} appearance-none text-black block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm`} />
								{passwordConfirmation.meta.touched && passwordConfirmation.meta.error && <p className="mt-2 text-sm text-red-600">{passwordConfirmation.meta.error}</p>}
							</div>
						</div>

						<div className="flex items-center justify-between mt-2">
							<div className="flex items-center">
								<input {...rememberMe.input} type="checkbox" className="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded" />
								<label htmlFor="remember_me" className="ml-2 block text-sm text-gray-900">
									Remember me
								</label>
							</div>
						</div>

						<div className="mt-4">
							<button type="submit" disabled={submitting} className="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
								Sign Up <Loading loading={submitting} />
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</Layout >
}