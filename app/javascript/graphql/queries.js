import gql from "graphql-tag";

export const ME = gql`
  query {
    me {
      __typename
      ... on Unauthenticated {
        message
      }
      ... on User {
        id
        email
        firstName
        lastName
        admin
        timezone
        createdAt
        updatedAt
      }
    }
  }
`;

export const LOGOUT_USER = gql`
  query {
    logoutUser
  }
`;
