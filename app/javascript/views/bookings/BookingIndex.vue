<template>
  <div>
    <h1>Bookings</h1>
    <table class="table">
      <thead>
        <tr>
          <th>ID</th>
          <th>Booked at</th>
          <th>Service</th>
          <th>Appointment</th>
          <th>Slots</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="booking in bookings" :key="booking.id">
          <th>{{ booking.id }}</th>
          <td>{{ humanizeTime(booking.createdAt) }}</td>
          <td>{{ booking.serviceName }}</td>
          <td>{{ humanizeTime(booking.serviceAppointment) }}</td>
          <td>{{ booking.slots }}</td>
          <td>{{ booking.bookingStatus.name }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
import { mapMutations } from "vuex";
import me from "../../graphql-requests/user/me";

export default {
  data() {
    return {
      bookings: [],
    };
  },
  methods: {
    ...mapMutations("toast", ["SET_TOAST"]),
    humanizeTime(datetime) {
      return new Date(datetime).toString();
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
          this.bookings = me.bookings;
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
