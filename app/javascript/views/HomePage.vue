<template lang="">
  <div>
    <h1 class="text-center">Service Booking</h1>
    <form @submit.prevent="searchServices">
      <label for="service_search">Search services</label>
      <div class="input-group">
        <input
          v-model="q"
          type="search"
          id="service_search"
          name="q"
          placeholder="Search haircuts"
          class="form-control"
        />
        <BaseButton class="btn-primary">Search</BaseButton>
      </div>
    </form>
  </div>
</template>
<script>
import { mapActions } from "vuex";
import BaseButton from "../components/shared/BaseButton.vue";

export default {
  components: {
    BaseButton,
  },
  data() {
    return {
      q: "",
    };
  },
  methods: {
    ...mapActions('service', ['searchServices']),
    search() {
      console.log(this.q);
      this.searchServices({q: this.q})
    },
  },
};
</script>
<style lang=""></style>
