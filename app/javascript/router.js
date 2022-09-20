import { createRouter, createWebHistory } from "vue-router";
import HomePage from './views/HomePage.vue'
import RegisterPage from './views/RegisterPage.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', name: 'home', component: HomePage },
    { path: '/register', name: 'register', component: RegisterPage },
    
  ],
})

export default router