import React from "react";
import {
  BrowserRouter as Router,
  Switch,
  Route,
} from "react-router-dom";
import { ApolloProvider } from '@apollo/client'
import Pages from "~/pages"
import client from "~/client"
import store from "~/store"
import { Provider } from "react-redux"

interface Props {

}

const App: React.FC<Props> = () =>
  <Provider store={store}>
    <ApolloProvider // @ts-ignore 
      client={client}>
      <Router>
        <Switch>
          <Route exact path="/" component={Pages.Home} />
          <Route path="/sign-up" component={Pages.SignUp} />
          <Route path="/login" component={Pages.LogIn} />
        </Switch>
      </Router >
    </ApolloProvider >
  </Provider >

export default App