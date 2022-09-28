<template lang="">
  <div>
    <h1>Cart</h1>
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
          <form @submit.prevent="removeFromCart(i.id)">
            <BaseButton type="submit" class="btn-danger">Remove</BaseButton>
          </form>
        </BaseCard>
      </li>
    </ul>
    <EmptyContent v-else :message="'Your cart is empty'" />
  </div>
</template>
<script>
import { mapMutations } from "vuex";
import me from "../../graphql-requests/user/me";
import deleteCartItem from "../../graphql-requests/carts/delete-cart-item";
import BaseCard from "../../components/shared/BaseCard.vue";
import BaseButton from "../../components/shared/BaseButton.vue";
import EmptyContent from "../../components/shared/EmptyContent.vue";

export default {
  components: {
    BaseCard,
    BaseButton,
    EmptyContent,
  },
  data() {
    return {
      cartItems: [],
    };
  },
  methods: {
    ...mapMutations("toast", ["SET_TOAST"]),
    removeFromCart(cartItemId) {
      deleteCartItem({ cartItemId }).then(({ data: { deleteCartItem } }) => {
        if (deleteCartItem) {
          this.cartItems = this.cartItems.filter((i) => i.id != cartItemId);
        } else {
          this.showDefaultError("Failed to remove an item from the cart.");
        }
      });
    },
    getCartItems() {
      return me().then(({ data: { me } }) => {
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
    handleUnauthenticated() {
      this.$router.push({ name: "login" });
    },
    showDefaultError(error = "Something went wrong") {
      this.SET_TOAST({
        header: "Error",
        isVisible: true,
        message: error,
        type: "danger",
      });
    },
  },
  created() {
    this.getCartItems();
  },
};
</script>
<style lang=""></style>
