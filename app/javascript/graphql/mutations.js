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

export const LOGIN_USER = gql`
  mutation LoginUser($input: LoginUserInput!) {
    loginUser(input: $input) {
      __typename
      ... on LoginUserPayload {
        user {
          id
          email
          firstName
          lastName
          admin
          timezone
        }
      }

      ... on InvalidCredentials {
        message
      }
    }
  }
`;

export const ADD_TO_CART = gql`
  mutation ($input: AddToCartInput!) {
    addToCart(input: $input) {
      __typename
      ... on CartItem {
        id
        addon
        appointment {
          id
        }
        service {
          id
        }
        slots
      }
      ... on Unauthenticated {
        message
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
