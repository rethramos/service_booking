import apolloClient from "../../apollo";
import { CREATE_USER, LOGIN_USER } from "../../graphql/mutations";
import { LOGOUT_USER, ME } from "../../graphql/queries";

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
  async fetchCurrentUser({ commit }) {
    const {
      data: { me },
    } = await apolloClient.query({
      query: ME,
    });
    switch (me.__typename) {
      case "User":
        commit("SET_CURRENT_USER", me);
        break;

      default:
        commit("SET_CURRENT_USER", null);
        break;
    }
    return me;
  },
  createUser(
    { commit },
    { firstName, lastName, timezone, email, password, passwordConfirmation }
  ) {
    return apolloClient
      .mutate({
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
      })
      .then(({ data: { createUser } }) => {
        if (createUser.__typename === "CreateUserPayload") {
          commit("SET_CURRENT_USER", createUser.user);
        }
        return createUser;
      });
  },
  loginUser({ commit }, { email, password }) {
    return apolloClient
      .mutate({
        mutation: LOGIN_USER,
        variables: {
          input: {
            credentials: {
              email,
              password,
            },
          },
        },
      })
      .then(({ data: { loginUser } }) => {
        if (loginUser.__typename === "LoginUserPayload") {
          commit("SET_CURRENT_USER", loginUser.user);
        }

        return loginUser;
      });
  },
  logoutUser({ commit }) {
    return apolloClient
      .query({
        query: LOGOUT_USER,
      })
      .then(({ data: { logoutUser } }) => {
        if (logoutUser) {
          commit("SET_CURRENT_USER", null);
        }
        return logoutUser;
      });
  },
};

export const getters = {
  isLoggedIn(state) {
    return !!state.currentUser;
  },
};
