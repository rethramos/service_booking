import gql from "graphql-tag";

export const CREATE_USER = gql`
  mutation CreateUser($input: CreateUserInput!) {
    createUser(input: $input) {
      __typename
      ... on CreateUserPayload {
        user {
          id
          firstName
          lastName
          email
          admin
          timezone
        }
      }

      ... on ValidationFailed {
        errors {
          attribute
          message
        }
      }
    }
  }
`;
