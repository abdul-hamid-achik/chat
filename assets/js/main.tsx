import React from "react";
import {
  BrowserRouter as Router,
  Switch,
  Route,
} from "react-router-dom";
import { ApolloProvider } from '@apollo/client'
import Pages from "~/pages"
import client from "~/client"

interface Props {

}

const App: React.FC<Props> = props =>
  // @ts-ignore
  <ApolloProvider client={client}>
    <Router>
      <Switch>
        <Route exact path="/" component={Pages.Home} />
        <Route path="/sign-up" component={Pages.SignUp} />
        <Route path="/login" component={Pages.LogIn} />
      </Switch>
    </Router>
  </ApolloProvider>

export default App