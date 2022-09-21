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

export const SERVICE_SEARCH = gql`
  query ServiceSearch {
    serviceSearch {
      totalCount
      nodes {
        id
        name
        description
        image
        business {
          id
          name
        }
        serviceCategory {
          id
          name
          image
        }
      }
    }
  }
`;
