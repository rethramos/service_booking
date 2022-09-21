<template>
  <div>
    <AppHeader />
    <AppToast />
    <main class="container mt-2">
      <RouterView />
    </main>
    <AppFooter />
  </div>
</template>
<script>
import AppHeader from "./shared/AppHeader.vue";
import AppFooter from "./shared/AppFooter.vue";
import AppToast from "./shared/AppToast.vue";
export default {
  components: { AppHeader, AppFooter, AppToast },
};
</script>
<style></style>
