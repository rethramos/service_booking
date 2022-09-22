<template lang="">
  <div>Success! (REceipt {{ receiptId }})</div>
</template>
<script>
export default {
  props: {
    receiptId: {
      type: [Number, String],
      required: true,
    },
  },
};
</script>
<style lang=""></style>
