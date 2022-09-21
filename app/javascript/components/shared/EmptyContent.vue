<template>
  <BaseCard class="bg-light empty-container">
    <p class="text" ref="message">{{ message }}</p>
  </BaseCard>
</template>

<script>
import BaseCard from './BaseCard.vue'
export default {
  components: { BaseCard },
  props: {
    message: {
      type: String,
      default: 'No records found',
    },
  },
}
</script>

<style lang="scss">
.empty-container {
  min-height: 10rem;
  display: flex;
  justify-content: center;
  align-items: center;

  & > .text {
    margin: 0;
  }
}
</style>
