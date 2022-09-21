import apolloClient from '../../apollo'
import { SERVICE_SEARCH } from '../../graphql/queries'

export const namespaced = true

export const state = {
  services: [],
}

export const mutations = {
  SET_SERVICES(state, services) {
    state.services = services
  },
}

export const actions = {
  searchServices({commit}, { q }) {
    return apolloClient.query({
      query: SERVICE_SEARCH
    }).then(({data: {serviceSearch}}) => {
      commit('SET_SERVICES', serviceSearch.nodes)
      return serviceSearch
    })
  }

}
