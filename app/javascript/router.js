import { createRouter, createWebHistory } from "vue-router";
import HomePage from "./views/HomePage.vue";
import RegisterPage from "./views/RegisterPage.vue";
import LoginPage from "./views/LoginPage.vue";
import NotFound from "./views/NotFound.vue";
import ServiceShow from "./views/services/ServiceShow.vue";
import BookingSuccess from "./views/bookings/BookingSuccess.vue";
import nProgress from "nprogress";
import store from "./store/store";
import receipt from "./graphql-requests/receipts/receipt";

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: "/", name: "home", component: HomePage },
    { path: "/register", name: "register", component: RegisterPage },
    { path: "/login", name: "login", component: LoginPage },
    {
      path: "/services/:id",
      name: "services-show",
      component: ServiceShow,
      props: true,
      meta: { requiresAuth: true },
      async beforeEnter(to, from, next) {
        const service = await store.dispatch(
          "service/fetchServiceById",
          to.params.id
        );
        if (service) {
          to.params.service = service;
          next();
        } else {
          next({ name: "404" });
        }
      },
    },
    {
      path: "/bookings/success",
      name: "bookings-success",
      component: BookingSuccess,
      props: true,
      meta: { requiresAuth: true },
      async beforeEnter(to, from, next) {
        const result = await receipt({ id: to.query.receiptId });
        const r = result.data.receipt;
        if (!r || !r.bookings?.length) {
          next({ name: "404" });
        } else {
          to.params.receipt = r;
          next();
        }
      },
    },
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

router.beforeResolve((to) => {
  if (to.meta.requiresAuth && !store.getters["auth/isLoggedIn"]) {
    return {
      name: "login",
    };
  }
});

router.afterEach(() => {
  nProgress.done();
});

export default router;
