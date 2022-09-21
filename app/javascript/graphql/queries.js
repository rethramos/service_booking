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
  query ServiceSearch($filter: ServiceSearchFilterInput) {
    serviceSearch(filter: $filter) {
      totalCount
      nodes {
        id
        name
        description
        image
        unitPrice
        currency
        appointments {
          id
          timeslot
          maxSlots
        }
        business {
          id
          name
        }
        serviceCategory {
          id
          name
        }
      }
    }
  }
`;

export const SERVICE = gql`
  query Service($id: ID!) {
    service(id: $id) {
      id
      name
      description
      image
      unitPrice
      currency
      appointments {
        id
        timeslot
        maxSlots
      }
      business {
        id
        name
      }
      serviceCategory {
        id
        name
      }
    }
  }
`;
