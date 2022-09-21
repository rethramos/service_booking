<template>
  <div class="toast-container position-fixed top-0 end-0 p-3">
    <div
      id="liveToast"
      :class="[{ show: toast.isVisible }, `text-bg-${toast.type}`]"
      class="toast"
      role="alert"
      aria-live="assertive"
      aria-atomic="true"
    >
      <div class="toast-header">
        <strong class="me-auto">{{ toast.header }}</strong>
        <button
          @click="hideToast"
          type="button"
          class="btn-close"
          aria-label="Close"
        ></button>
      </div>
      <div class="toast-body">{{ toast.message }}</div>
    </div>
  </div>
</template>
<script>
import { mapActions, mapState } from 'vuex'

export default {
  props: {},
  methods: {
    ...mapActions('toast', ['toggleToast']),
    hideToast() {
      this.toggleToast(false)
    },
  },
  computed: {
    ...mapState('toast', ['toast']),
  },
}
</script>
<style lang="scss"></style>
