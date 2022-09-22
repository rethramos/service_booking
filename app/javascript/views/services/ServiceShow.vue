<template lang="">
  <section>
    <!-- Step 0 -->
    <div v-if="step === 0">
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
      <form class="d-flex flex-column gap-2" @submit.prevent="addServiceToCart">
        <ErrorMessages :errors="errors" />
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
          v-model.number="cartItem.slots"
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
    </div>
    <!-- Step 1 -->
    <div v-if="step === 1">
      <p class="h3">Account Details</p>
      <form class="row g-2">
        <ErrorMessages :errors="errors" />
        <BaseInput
          label="First Name"
          type="text"
          name="receipt[first_name]"
          id="receipt_first_name"
          class="form-control"
          v-model="receipt.firstName"
        />
        <BaseInput
          label="Last Name"
          type="text"
          name="receipt[last_name]"
          id="receipt_last_name"
          class="form-control"
          v-model="receipt.lastName"
        />
        <BaseInput
          label="Contact Number"
          type="text"
          name="receipt[contact_number]"
          id="receipt_contact_number"
          class="form-control"
          v-model="receipt.contactNumber"
        />
        <BaseInput
          label="Email"
          type="email"
          name="receipt[email]"
          id="receipt_email"
          class="form-control"
          v-model="receipt.email"
        />
        <div class="form-group">
          <button type="submit" class="btn btn-primary w-100">Checkout</button>
        </div>
      </form>
    </div>
  </section>
</template>
<script>
import BaseButton from "../../components/shared/BaseButton.vue";
import BaseInput from "../../components/shared/BaseInput.vue";
import BaseSelect from "../../components/shared/BaseSelect.vue";
import ErrorMessages from "../../components/shared/ErrorMessages.vue";
import addToCart from "../../graphql-requests/carts/add-to-cart";

export default {
  components: {
    BaseSelect,
    BaseInput,
    BaseButton,
    ErrorMessages,
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
      receipt: {
        firstName: "",
        lastName: "",
        email: "",
        contactNumber: "",
        address: {
          lineOne: "",
          lineTwo: "",
          city: "",
          province: "",
          postalCode: "",
          country: "",
        },
      },
      errors: [],
      step: 0,
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
  methods: {
    nextStep() {
      this.step++;
    },
    addServiceToCart() {
      addToCart({ ...this.cartItem, serviceId: this.service.id }).then(
        ({ data: { addToCart } }) => {
          console.log(addToCart);
          switch (addToCart.__typename) {
            case "CartItem":
              // transition to next form
              console.log(addToCart);
              this.errors = [];
              this.nextStep();
              break;
            case "ValidationFailed":
              this.errors = addToCart.errors;
              break;

            case "Unauthenticated":
              this.$router.push({ name: "login" });

            default:
              this.SET_TOAST({
                header: "Error",
                isVisible: true,
                message: `Something went wrong.`,
                type: "danger",
              });

              break;
          }
        }
      );
    },
  },
};
</script>
<style lang=""></style>
