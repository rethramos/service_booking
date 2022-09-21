export const namespaced = true

export const state = {
  toast: {
    type: 'white',
    isVisible: false,
    message: 'Message',
    header: 'Header',
  },
}

export const mutations = {
  SET_TOAST(state, toastObj) {
    state.toast = toastObj
  },
}

export const actions = {
  toggleToast({ state, commit }, toggle) {
    commit('SET_TOAST', { ...state.toast, isVisible: toggle })
  },
}
