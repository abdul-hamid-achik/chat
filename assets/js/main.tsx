import React from "react";
import {
  BrowserRouter as Router,
  Switch,
  Route,
} from "react-router-dom";
import Pages from "~/pages"
import { ApolloClient, InMemoryCache, ApolloProvider } from '@apollo/client'

const client = new ApolloClient({
  uri: '/graphql',
  cache: new InMemoryCache()
})

interface Props {

}

const App: React.FC<Props> = props =>
  <ApolloProvider client={client}>
    <Router>
      <Switch>
        <Route exact path="/">
          <Pages.Home />
        </Route>
        <Route path="/login">
          <Pages.LogIn />
        </Route>
        <Route path="/signup">
          <Pages.SignUp />
        </Route>
      </Switch>
    </Router>
  </ApolloProvider>

export default App