<template lang="">
  <BaseCard class="card-body">
    <h1>Register</h1>
    <form @submit.prevent="register" class="row g-2">
      <ErrorMessages :errors="errors" />
      <BaseInput
        label="First Name"
        type="text"
        name="user[first_name]"
        id="user_first_name"
        class="form-control"
        v-model="user.firstName"
      />
      <BaseInput
        label="Last Name"
        type="text"
        name="user[last_name]"
        id="user_last_name"
        class="form-control"
        v-model="user.lastName"
      />
      <BaseInput
        label="Timezone"
        type="text"
        name="user[timezone]"
        id="user_timezone"
        class="form-control"
        v-model="user.timezone"
      />
      <BaseInput
        label="Email"
        type="email"
        name="user[email]"
        id="user_email"
        class="form-control"
        v-model="user.email"
      />
      <BaseInput
        label="Password"
        type="password"
        name="user[password]"
        id="user_password"
        class="form-control"
        v-model="user.password"
      />
      <BaseInput
        label="Password Confirmation"
        type="password"
        name="user[password_confirmation]"
        id="user_password_confirmation"
        class="form-control"
        v-model="user.passwordConfirmation"
      />
      <div class="form-group">
        <button type="submit" class="btn btn-primary w-100">Register</button>
      </div>
    </form>
  </BaseCard>
</template>
<script>
import BaseCard from "../components/shared/BaseCard.vue";
import BaseInput from "../components/shared/BaseInput.vue";
import ErrorMessages from "../components/shared/ErrorMessages.vue";


export default {
  data() {
    return {
      user: {
        firstName: "",
        lastName: "",
        email: "",
        timezone: "",
        password: "",
        passwordConfirmation: "",
      },
      errors: []
    };
  },
  methods: {
    register() {
      console.log(this.user)
    }
  },
  components: { BaseCard, BaseInput, ErrorMessages },
};
</script>
<style lang=""></style>
