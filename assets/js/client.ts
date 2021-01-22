import { ApolloClient } from "apollo-client"
import { ApolloLink } from "apollo-link"
import { InMemoryCache } from "apollo-cache-inmemory"
import { createHttpLink } from "apollo-link-http"
import { setContext } from "apollo-link-context"
import { hasSubscription } from "@jumpn/utils-graphql"
import * as AbsintheSocket from "@absinthe/socket"
import { createAbsintheSocketLink } from "@absinthe/socket-apollo-link"
import { createLink } from "apollo-absinthe-upload-link"
import { Socket as PhoenixSocket } from "phoenix"

const HTTP_ENDPOINT = "/api/graphql"
const WS_ENDPOINT = "/socket"

const httpLink = createHttpLink({
  uri: HTTP_ENDPOINT
})

const uploadLink: ApolloLink = createLink({
  uri: HTTP_ENDPOINT
})

const socketLink = createAbsintheSocketLink(
  AbsintheSocket.create(new PhoenixSocket(WS_ENDPOINT))
)

const authLink = setContext((_, { headers }) => {
  const token = localStorage.getItem("auth-token")
  return {
    headers: {
      ...headers,
      authorization: token ? `Bearer ${token}` : ""
    }
  }
})

const link = ApolloLink.split(
  operation => hasSubscription(operation.query),
  socketLink,
  authLink.concat(uploadLink.concat(httpLink)),
)

const client = new ApolloClient({
  link: link,
  cache: new InMemoryCache()
})

export default client
