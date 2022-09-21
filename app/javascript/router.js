import { createRouter, createWebHistory } from "vue-router";
import HomePage from "./views/HomePage.vue";
import RegisterPage from "./views/RegisterPage.vue";
import LoginPage from "./views/LoginPage.vue";
import NotFound from "./views/NotFound.vue";
import nProgress from "nprogress";

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: "/", name: "home", component: HomePage },
    { path: "/register", name: "register", component: RegisterPage },
    { path: "/login", name: "login", component: LoginPage },
    {
      path: "/404",
      name: "404",
      component: NotFound,
      props: true,
    },
    {
      path: "/:catchAll(.*)",
      redirect: { name: "404" },
    },
  ],
});

router.beforeEach((to, from, next) => {
  nProgress.start();
  next();
});

router.afterEach(() => {
  nProgress.done();
});

export default router;
