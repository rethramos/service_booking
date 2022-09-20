<template>
  <div>
    Hello vue
    <RouterLink :to="{ name: 'home' }">Home</RouterLink>
    <RouterLink :to="{ name: 'register' }">Register</RouterLink>
    <RouterView />
  </div>
</template>
<script>
import Counter from "./Counter.vue";
export default {
  components: { Counter },
};
</script>
<style></style>
