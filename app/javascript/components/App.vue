<template>
  <div>
    <AppHeader />
    <main class="container mt-2">
      <RouterView />
    </main>
    <AppFooter />
  </div>
</template>
<script>
import AppHeader from "./shared/AppHeader.vue";
import AppFooter from "./shared/AppFooter.vue";
export default {
  components: { AppHeader, AppFooter },
};
</script>
<style></style>
