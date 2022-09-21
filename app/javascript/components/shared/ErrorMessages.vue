<template>
  <div v-if="errors.length" class="alert alert-danger">
    <ul>
      <li v-for="error in formattedErrors" :key="error.attribute">
        {{ error.attribute }} {{ error.message }}
      </li>
    </ul>
  </div>
</template>

<script>
import startCase from 'lodash/startCase'

export default {
  props: {
    errors: {
      type: Array,
      required: true,
    },
  },
  computed: {
    formattedErrors() {
      return this.errors.map((e) => ({
        ...e,
        attribute: startCase(e.attribute),
      }))
    },
  },
}
</script>

<style></style>
