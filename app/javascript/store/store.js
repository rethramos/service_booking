import { createStore } from "vuex";
import * as auth from './modules/auth'
import * as toast from './modules/toast'

const store = createStore({
  modules: {
    auth,
    toast
  }
});

export default store;
