<template lang="">
  <div>
    <h1>Cart</h1>
    <ul class="d-flex flex-column gap-4">
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
            <BaseButton type="submit" class="btn-danger" >Remove</BaseButton>
          </form>
        </BaseCard>
      </li>
    </ul>
  </div>
</template>
<script>
import { mapMutations } from "vuex";
import me from "../../graphql-requests/user/me";
import BaseCard from "../../components/shared/BaseCard.vue";
import BaseButton from "../../components/shared/BaseButton.vue";

export default {
  components: {
    BaseCard,BaseButton
  },
  data() {
    return {
      cartItems: [],
    };
  },
  methods: {
    ...mapMutations('toast', ['SET_TOAST']),
    removeFromCart(cartItemId) {
      console.log(cartItemId)
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
};
</script>
<style lang=""></style>
