<template>
  <div>
    <AppHeader />
    <AppToast />
    <main class="container mt-2 main-content">
      <RouterView />
    </main>
    <AppFooter />
  </div>
</template>
<script>
import AppHeader from "./shared/AppHeader.vue";
import AppFooter from "./shared/AppFooter.vue";
import AppToast from "./shared/AppToast.vue";
import { mapActions } from "vuex";
export default {
  components: { AppHeader, AppFooter, AppToast },
  methods: {
    ...mapActions('auth', ['fetchCurrentUser'])
  },
  created() {
    this.fetchCurrentUser()
  }
};
</script>
<style></style>
