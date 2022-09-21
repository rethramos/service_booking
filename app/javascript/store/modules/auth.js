import apolloClient from "../../apollo";
import { CREATE_USER } from "../../graphql/mutations";

export const namespaced = true;

export const state = {
  currentUser: null,
};

export const mutations = {
  SET_CURRENT_USER(state, currentUser) {
    state.currentUser = currentUser;
  },
};

export const actions = {
  createUser(
    { commit },
    { firstName, lastName, timezone, email, password, passwordConfirmation }
  ) {
    return apolloClient.mutate({
      mutation: CREATE_USER,
      variables: {
        input: {
          firstName,
          lastName,
          timezone,
          authProvider: {
            credentials: {
              email,
              password,
            },
            passwordConfirmation,
          },
        },
      },
    }).then(({ data: { createUser } }) => {
      console.log(createUser)
      return createUser
    })
  },
};

export const getters = {
  isLoggedIn(state) {
    return !!state.currentUser;
  },
};
