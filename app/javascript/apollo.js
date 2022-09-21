import {
  ApolloClient,
  ApolloLink,
  createHttpLink,
  from,
  InMemoryCache,
} from "@apollo/client/core";
import { onError } from "@apollo/client/link/error";

function getCsrfToken() {
  return document.querySelector("meta[name=csrf-token]").content;
}

const errorLink = onError(({ graphQLErrors, networkError }) => {
  if (graphQLErrors) {
    graphQLErrors.forEach(({ message, locations, path, extensions }) => {
      console.log(
        `[GraphQL Error]: Message: ${message}, Locations: ${locations}, Path: ${path}, Extensions: ${extensions}`
      );
    });
  }
  if (networkError) {
    console.error(`[Network error]: ${networkError}`);
  }
});

const httpLink = createHttpLink({
  uri: "http://localhost:3000/graphql", // TODO: change this later
  credentials: "same-origin",
  headers: {
    Accept: "application/json",
    "X-CSRF-Token": getCsrfToken(),
  },
});

const authMiddleware = new ApolloLink((operation, forward) => {
  operation.setContext(({ headers = {} }) => ({}));

  return forward(operation).map((result) => {
    return result;
  });
});

const cache = new InMemoryCache();

const apolloClient = new ApolloClient({
  cache,
  link: from([errorLink, authMiddleware, httpLink]),
});

export default apolloClient;
