<template lang="">
  <header class="navbar navbar-expand-lg bg-light">
    <div class="container">
      <RouterLink :to="{ name: 'home' }" class="navbar-brand">
        Service Booking
      </RouterLink>
      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <nav class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0 align-items-center">
          <li class="nav-item">
            <RouterLink :to="{ name: 'home' }" class="nav-link">
              Home
            </RouterLink>
          </li>
          <li v-if="!isLoggedIn" class="nav-item">
            <RouterLink
              :to="{ name: 'register' }"
              class="nav-link"
              id="register"
            >
              Register
            </RouterLink>
          </li>
          <li v-if="!isLoggedIn" class="nav-item">
            <RouterLink :to="{ name: 'login' }" class="nav-link" id="login">
              Log in
            </RouterLink>
          </li>
          <li v-if="isLoggedIn" class="nav-item">
            <RouterLink :to="{ name: 'bookings-index' }" class="nav-link" id="bookings">
              Bookings
            </RouterLink>
          </li>
          <li v-if="isLoggedIn" class="nav-item">
            <RouterLink :to="{ name: 'cart-index' }" class="nav-link" id="cart">
              Cart
            </RouterLink>
          </li>
          <li v-if="isLoggedIn" class="nav-item">
            <form action="" @click.prevent="logOut" id="logout">
              <BaseButton type="submit" class="nav-link">Log out</BaseButton>
            </form>
          </li>
        </ul>
      </nav>
    </div>
  </header>
</template>
<script>
import { mapActions, mapGetters } from "vuex";
import BaseButton from "./BaseButton.vue";
export default {
  components: { BaseButton },
  computed: {
    ...mapGetters("auth", ["isLoggedIn"]),
  },
  methods: {
    ...mapActions("auth", ["logoutUser"]),
    logOut() {
      this.logoutUser().then((success) => {
        if (success) {
          window.location.reload()
        }
      });
    },
  },
};
</script>
<style lang=""></style>
