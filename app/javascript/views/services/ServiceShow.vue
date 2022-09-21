<template lang="">
  <section>
    <div class="card">
      <img
        :src="service.image"
        :alt="service.name"
        class="card-img-top"
        height="200"
        style="object-fit: cover"
      />
      <div class="card-body">
        <p class="h3">{{ service.name }}</p>
        <p v-if="service.serviceCategory">
          Category: {{ service.serviceCategory.name }}
        </p>
        <p>Store: {{ service.business.name }}</p>
      </div>
    </div>
    <br />
    <p class="h4">Description</p>
    <p>{{ service.description }}</p>
    <p class="h4">{{ service.currency }} {{ service.unitPrice }}</p>
    <br />
    <form class="d-flex flex-column gap-2">
      <BaseSelect
        label="Select appointment"
        :options="formattedAppointments"
        :valueKey="'id'"
        :labelKey="'timeslot'"
        class="form-select"
        v-model="cartItem.appointmentId"
      />
      <BaseInput
        type="number"
        label="Slots"
        id="cart_item_slots"
        min="1"
        v-model="cartItem.slots"
        class="form-control"
      />

      <div class="form-group">
        <label for="cart_item_addon">Add-ons</label>
        <textarea
          class="form-control"
          v-model="cartItem.addon"
          name=""
          id="cart_item_addon"
          cols="30"
          rows="10"
        ></textarea>
      </div>
      <BaseButton class="btn-primary">Book Now</BaseButton>
    </form>
  </section>
</template>
<script>
import BaseButton from "../../components/shared/BaseButton.vue";
import BaseInput from "../../components/shared/BaseInput.vue";
import BaseSelect from "../../components/shared/BaseSelect.vue";
export default {
  components: {
    BaseSelect,
    BaseInput,
    BaseButton,
  },
  props: {
    service: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      cartItem: {
        appointmentId: 0,
        slots: 1,
        addon: "",
      },
    };
  },
  computed: {
    formattedAppointments() {
      return this.service.appointments.map((a) => ({
        ...a,
        timeslot: new Date(a.timeslot).toString(),
      }));
    },
  },
};
</script>
<style lang=""></style>
