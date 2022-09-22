import gql from "graphql-tag";

export const ME = gql`
  query Me {
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
        cart {
          id
          cartItems {
            id
            addon
            appointment {
              id
              timeslot
            }
            service {
              id
              name
              business {
                id
                name
              }
              unitPrice
              currency
            }
            slots
          }
        }
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

export const PAYMENT_OPTIONS = gql`
  query {
    paymentOptions {
      id
      name
    }
  }
`;

export const RECEIPT = gql`
  query Receipt($id: ID!) {
    receipt(id: $id) {
      id
      firstName
      lastName
      contactNumber
      email
      paymentOption {
        id
        name
      }
      address {
        lineOne
        lineTwo
        city
        province
        country
        postalCode
      }
      bookings {
        id
        addon
        serviceName
        serviceAppointment
        serviceCurrency
        serviceUnitPrice
        slots
        bookingStatus {
          id
          name
        }
        service {
          id
          business {
            id
            name
          }
        }
      }
    }
  }
`;
