<template lang="">
  <div>
    <h1>Success!</h1>
    <h2>Receipt Information</h2>
    <ul class="d-flex flex-column gap-4" v-if="receipt.bookings.length">
      <li v-for="i in receipt.bookings" :key="i.id">
        <BaseCard class="card-body">
          <strong>{{ i.serviceName }} (x {{ i.slots }})</strong>
          <p>{{ new Date(i.serviceAppointment).toString() }}</p>
          <p><strong>Store:</strong> {{ i.service.business.name }}</p>
          <p>
            <strong>Subtotal:</strong> {{ i.serviceCurrency }}
            {{ i.serviceUnitPrice * i.slots }}
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
    <p><strong>Name:</strong> {{ receipt.firstName }} {{ receipt.lastName }}</p>
    <p><strong>Contact Number: </strong> {{ receipt.contactNumber }}</p>
    <p><strong>Email: </strong> {{ receipt.email }}</p>

    <hr />
    <p class="h4">Address</p>
    <p>{{ receipt.address.lineOne }}</p>
    <p>{{ receipt.address.lineTwo }}</p>
    <p>{{ receipt.address.city }} {{ receipt.address.postalCode }}</p>
    <p>{{ receipt.address.province }}</p>
    <p>{{ receipt.address.country }}</p>

    <hr />
    <p class="h4">Payment Method</p>
    <p>{{ receipt.paymentOption.name }}</p>
  </div>
</template>
<script>
import BaseCard from "../../components/shared/BaseCard.vue";
export default {
  components: { BaseCard },
  props: {
    receipt: {
      type: Object,
      required: true,
    },
  },
};
</script>
<style lang=""></style>
