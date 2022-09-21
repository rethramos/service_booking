import { createStore } from "vuex";
import * as auth from './modules/auth'
import * as toast from './modules/toast'
import * as service from './modules/service'

const store = createStore({
  modules: {
    auth,
    toast,
    service
  }
});

export default store;
