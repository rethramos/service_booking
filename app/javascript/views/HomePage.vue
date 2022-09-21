<template lang="">
  <div>
    <h1 class="text-center">Service Booking</h1>
    <form @submit.prevent="search">
      <label for="service_search">Search services by name</label>
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
    <br />
    <ul class="d-flex flex-column gap-4">
      <li v-for="service in services" :key="service.id">
        <ServiceSearchCard :service="service" />
      </li>
    </ul>
  </div>
</template>
<script>
import { mapActions, mapState } from "vuex";
import ServiceSearchCard from "../components/service/ServiceSearchCard.vue";
import BaseButton from "../components/shared/BaseButton.vue";

export default {
  components: {
    BaseButton,
    ServiceSearchCard,
  },
  data() {
    return {
      q: "",
    };
  },
  computed: {
    ...mapState("service", ["services"]),
  },
  methods: {
    ...mapActions("service", ["searchServices"]),
    search() {
      console.log(this.q);
      this.searchServices({ q: this.q });
    },
  },
  created() {
    this.searchServices({ q: this.q });
  },
};
</script>
<style lang=""></style>
