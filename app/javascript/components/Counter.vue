<template>
  <div>
    Counter: {{ counter }}
    <button @click="counter++" class="btn btn-primary">Click me</button>
  </div>
</template>
<script>
export default {
  data() {
    return {
      counter: 0
    }
  }
}
</script>
<style lang="">
  
</style>