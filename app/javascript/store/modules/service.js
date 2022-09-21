import apolloClient from "../../apollo";
import { SERVICE, SERVICE_SEARCH } from "../../graphql/queries";

export const namespaced = true;

export const state = {
  services: [],
};

export const mutations = {
  SET_SERVICES(state, services) {
    state.services = services;
  },
};

export const actions = {
  searchServices({ commit }, { q }) {
    return apolloClient
      .query({
        query: SERVICE_SEARCH,
        variables: {
          filter: {
            nameContains: q,
          },
        },
      })
      .then(({ data: { serviceSearch } }) => {
        commit("SET_SERVICES", serviceSearch.nodes);
        return serviceSearch;
      });
  },
  async fetchServiceById({ state, commit }, id) {
    const s = state.services.find((s) => s.id == id);
    if (s) {
      return s;
    }

    const {
      data: { service },
    } = await apolloClient.query({
      query: SERVICE,
      variables: {
        id,
      },
    });

    if (service) {
      commit("SET_SERVICES", [...state.services, s]);
    }

    return service;
  },
};
