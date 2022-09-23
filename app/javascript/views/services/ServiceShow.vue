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
          <p v-if="service.business.formattedAddress">
            Address: {{ service.business.formattedAddress }}
          </p>
          <p v-else>No adress specified</p>
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
          :label="slotLabel"
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
      <form class="row g-2" @submit.prevent="choosePaymentOption">
        <ErrorMessages :errors="errors" />
        <p class="h3">Account Details</p>
        <BaseInput
          label="First Name"
          type="text"
          name="receipt[first_name]"
          id="receipt_first_name"
          class="form-control"
          v-model="receipt.firstName"
          required
        />
        <BaseInput
          label="Last Name"
          type="text"
          name="receipt[last_name]"
          id="receipt_last_name"
          class="form-control"
          v-model="receipt.lastName"
          required
        />
        <BaseInput
          label="Contact Number"
          type="tel"
          name="receipt[contact_number]"
          id="receipt_contact_number"
          class="form-control"
          v-model="receipt.contactNumber"
          required
        />
        <BaseInput
          label="Email"
          type="email"
          name="receipt[email]"
          id="receipt_email"
          class="form-control"
          v-model="receipt.email"
          required
        />

        <p class="h3">Complete Address</p>
        <BaseInput
          label="Line 1"
          type="text"
          name="receipt[address][line_one]"
          id="receipt_address_line_one"
          class="form-control"
          v-model="receipt.address.lineOne"
          required
        />
        <BaseInput
          label="Line 2"
          type="text"
          name="receipt[address][line_two]"
          id="receipt_address_line_two"
          class="form-control"
          v-model="receipt.address.lineTwo"
          required
        />

        <BaseInput
          label="City"
          type="text"
          name="receipt[address][city]"
          id="receipt_address_city"
          class="form-control"
          v-model="receipt.address.city"
          required
        />
        <BaseInput
          label="Province"
          type="text"
          name="receipt[address][province]"
          id="receipt_address_province"
          class="form-control"
          v-model="receipt.address.province"
          required
        />
        <BaseInput
          label="Country"
          type="text"
          name="receipt[address][country]"
          id="receipt_address_country"
          class="form-control"
          v-model="receipt.address.country"
          required
        />
        <BaseInput
          label="Postal Code"
          type="number"
          name="receipt[address][postal_code]"
          id="receipt_address_postal_code"
          class="form-control"
          v-model="receipt.address.postalCode"
          required
        />

        <div class="form-group d-flex justify-content-end gap-2">
          <BaseButton
            type="button"
            class="btn-secondary"
            @click="this.previousStep"
          >
            Back
          </BaseButton>
          <BaseButton type="submit" class="btn-primary">
            Choose payment option
          </BaseButton>
        </div>
      </form>
    </div>
    <!-- Step 2 -->
    <div v-if="step === 2">
      <form class="row g-2" @submit.prevent="submitCheckoutDetails">
        <ErrorMessages :errors="errors" />
        <p class="h3">Payment method</p>
        <BaseSelect
          label="Payment Option"
          :options="paymentOptions"
          :valueKey="'id'"
          :labelKey="'name'"
          class="form-select"
          v-model="receipt.paymentOptionId"
        />

        <div class="form-group d-flex justify-content-end gap-2">
          <BaseButton
            type="button"
            class="btn-secondary"
            @click="this.previousStep"
          >
            Back
          </BaseButton>
          <BaseButton type="submit" class="btn-primary">Checkout</BaseButton>
        </div>
      </form>
    </div>

    <!-- Step 3 -->
    <div v-if="step === 3">
      <form class="row g-2" @submit.prevent="confirmBooking">
        <ErrorMessages :errors="errors" />
        <p class="h3">Checkout</p>
        <p class="h4">Your cart</p>
        <!-- loop through each item in the cart -->
        <ul class="d-flex flex-column gap-4" v-if="cartItems.length">
          <li v-for="i in cartItems" :key="i.id">
            <BaseCard class="card-body">
              <strong>{{ i.service.name }} (x {{ i.slots }})</strong>
              <p>{{ new Date(i.appointment.timeslot).toString() }}</p>
              <p><strong>Store:</strong> {{ i.service.business.name }}</p>
              <p>
                <strong>Subtotal:</strong> {{ i.service.currency }}
                {{ i.service.unitPrice * i.slots }}
              </p>
              <div v-if="i.addon">
                <strong>Add-on:</strong>
                <p>{{ i.addon }}</p>
              </div>
            </BaseCard>
          </li>
        </ul>

        <hr />
        <p class="h4">Account Details</p>
        <p>
          <strong>Name:</strong> {{ receipt.firstName }} {{ receipt.lastName }}
        </p>
        <p><strong>Contact Number: </strong> {{ receipt.contactNumber }}</p>
        <p><strong>Email: </strong> {{ receipt.email }}</p>

        <hr />
        <p><strong>Line One:</strong> {{ receipt.address.lineOne }}</p>
        <p><strong>Line Two:</strong> {{ receipt.address.lineTwo }}</p>
        <p>
          <strong>City: </strong> {{ receipt.address.city }} (ZIP:
          {{ receipt.address.postalCode }})
        </p>
        <p><strong>Province: </strong> {{ receipt.address.province }}</p>
        <p><strong>Country:</strong> {{ receipt.address.country }}</p>

        <hr />
        <p class="h4">Payment Method</p>
        <p>{{ selectedPaymentOption.name }}</p>

        <div class="form-group d-flex justify-content-end gap-2">
          <BaseButton
            type="button"
            class="btn-secondary"
            @click="this.previousStep"
          >
            Back
          </BaseButton>
          <BaseButton type="submit" class="btn-primary"
            >Confirm Booking(s)</BaseButton
          >
        </div>
      </form>
    </div>
  </section>
</template>
<script>
import BaseCard from "../../components/shared/BaseCard.vue";
import BaseButton from "../../components/shared/BaseButton.vue";
import BaseInput from "../../components/shared/BaseInput.vue";
import BaseSelect from "../../components/shared/BaseSelect.vue";
import ErrorMessages from "../../components/shared/ErrorMessages.vue";
import addToCart from "../../graphql-requests/carts/add-to-cart";
import paymentOptions from "../../graphql-requests/payment-options/payment-options";
import createReceipt from "../../graphql-requests/receipts/create-receipt";
import placeBookings from "../../graphql-requests/bookings/place-bookings";
import me from "../../graphql-requests/user/me";
import { mapMutations, mapState } from "vuex";

export default {
  components: {
    BaseCard,
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
        appointmentId: "",
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
        paymentOptionId: "",
      },
      receiptId: "",
      paymentOptions: [],
      errors: [],
      step: 0,
      cartItems: [],
    };
  },
  computed: {
    ...mapState("auth", ["currentUser"]),
    selectedAppointment() {
      return this.service.appointments.find(
        (s) => s.id == this.cartItem.appointmentId
      );
    },
    slotLabel() {
      const str = "Slots";
      return this.selectedAppointment
        ? str + ` (${this.selectedAppointment.remainingSlots} remaining)`
        : str;
    },
    formattedAppointments() {
      return this.service.appointments.map((a) => ({
        ...a,
        timeslot: new Date(a.timeslot).toString(),
      }));
    },
    selectedPaymentOption() {
      return this.paymentOptions.find(
        (p) => p.id == this.receipt.paymentOptionId
      );
    },
  },
  methods: {
    ...mapMutations("toast", ["SET_TOAST"]),
    getCartItems() {
      me().then(({ data: { me } }) => {
        switch (me.__typename) {
          case "User":
            this.cartItems = me.cart.cartItems;
            break;

          case "Unauthenticated":
            this.handleUnauthenticated();
            break;

          default:
            this.showDefaultError();
            break;
        }
      });
    },
    getPaymentOptions() {
      paymentOptions().then(({ data: { paymentOptions } }) => {
        this.paymentOptions = paymentOptions;
      });
    },
    previousStep() {
      if (this.step > 0) {
        this.step--;
      }
    },
    nextStep() {
      this.step++;
    },
    addServiceToCart() {
      addToCart({ ...this.cartItem, serviceId: this.service.id }).then(
        ({ data: { addToCart } }) => {
          switch (addToCart.__typename) {
            case "CartItem":
              this.errors = [];
              this.nextStep();
              break;
            case "ValidationFailed":
              this.errors = addToCart.errors;
              break;

            case "Unauthenticated":
              this.handleUnauthenticated();
              break;

            default:
              this.showDefaultError();
              break;
          }
        }
      );
    },
    choosePaymentOption() {
      this.nextStep();
    },
    submitCheckoutDetails() {
      createReceipt(this.receipt).then(({ data: { createReceipt } }) => {
        switch (createReceipt.__typename) {
          case "Receipt":
            // transition to next step
            this.handleReceipt(createReceipt);
            break;
          case "ValidationFailed":
            this.errors = createReceipt.errors;
            break;

          case "Unauthenticated":
            this.handleUnauthenticated();
            break;

          default:
            this.showDefaultError();
            break;
        }
      });
    },
    confirmBooking() {
      placeBookings({ receiptId: this.receiptId }).then(
        ({ data: { placeBookings } }) => {
          switch (placeBookings.__typename) {
            case "Receipt":
              // redirect to success page with receipt information
              this.SET_TOAST({
                header: "Success",
                isVisible: true,
                message: "Booking successful",
                type: "success",
              });
              this.$router.push({
                name: "bookings-success",
                query: {
                  receiptId: placeBookings.id,
                },
              });
              break;
            case "ValidationFailed":
              this.errors = placeBookings.errors;
              break;

            case "Unauthenticated":
              this.handleUnauthenticated();
              break;

            default:
              this.showDefaultError();
              break;
          }
        }
      );
    },
    handleReceipt(newReceipt) {
      this.receiptId = newReceipt.id;
      this.nextStep();
      this.errors = [];
      this.getCartItems();
    },
    handleUnauthenticated() {
      this.$router.push({ name: "login" });
    },
    showDefaultError() {
      this.SET_TOAST({
        header: "Error",
        isVisible: true,
        message: `Something went wrong.`,
        type: "danger",
      });
    },
  },
  created() {
    this.getPaymentOptions();
  },
};
</script>
<style lang=""></style>
