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
    console.log(me);
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
    { firstName, lastName, email, password, passwordConfirmation }
  ) {
    return apolloClient
      .mutate({
        mutation: CREATE_USER,
        variables: {
          input: {
            firstName,
            lastName,
            authProvider: {
              credentials: {
                email,
                password,
              },
              passwordConfirmation,
            },
          },
        },
        update: (cache, { data: { createUser } }) => {
          if (createUser.__typename !== "CreateUserPayload") {
            return;
          }

          cache.modify({
            fields: {
              me(existingMe = {}, { toReference }) {
                return toReference(createUser.user);
              },
            },
          });
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
        update: (cache, { data: { loginUser } }) => {
          if (loginUser.__typename !== "LoginUserPayload") {
            return;
          }

          cache.modify({
            fields: {
              me(existingMe = {}, { toReference }) {
                return toReference(loginUser.user);
              },
            },
          });
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
