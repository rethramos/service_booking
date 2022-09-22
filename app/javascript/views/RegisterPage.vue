<template lang="">
  <BaseCard class="card-body">
    <h1>Register</h1>
    <form @submit.prevent="register" class="row g-2">
      <ErrorMessages :errors="errors" />
      <BaseInput
        required
        label="First Name"
        type="text"
        name="user[first_name]"
        id="user_first_name"
        class="form-control"
        v-model="user.firstName"
      />
      <BaseInput
        required
        label="Last Name"
        type="text"
        name="user[last_name]"
        id="user_last_name"
        class="form-control"
        v-model="user.lastName"
      />
      <BaseInput
        label="Email"
        type="email"
        name="user[email]"
        id="user_email"
        class="form-control"
        v-model="user.email"
        required
      />
      <BaseInput
        label="Password"
        type="password"
        name="user[password]"
        id="user_password"
        class="form-control"
        v-model="user.password"
        required
      />
      <BaseInput
        label="Password Confirmation"
        type="password"
        name="user[password_confirmation]"
        id="user_password_confirmation"
        class="form-control"
        v-model="user.passwordConfirmation"
        required
      />
      <div class="form-group">
        <BaseButton type="submit" class="btn-primary w-100">Register</BaseButton>
      </div>
    </form>
  </BaseCard>
</template>
<script>
import { mapActions, mapMutations } from "vuex";
import BaseCard from "../components/shared/BaseCard.vue";
import BaseInput from "../components/shared/BaseInput.vue";
import BaseButton from "../components/shared/BaseButton.vue";
import ErrorMessages from "../components/shared/ErrorMessages.vue";

export default {
  data() {
    return {
      user: {
        firstName: "",
        lastName: "",
        email: "",
        password: "",
        passwordConfirmation: "",
      },
      errors: [],
    };
  },
  methods: {
    ...mapActions("auth", ["createUser"]),
    ...mapMutations("toast", ["SET_TOAST"]),
    register() {
      this.createUser(this.user).then((createUser) => {
        if (createUser.__typename === "CreateUserPayload") {
          this.SET_TOAST({
            header: "Success",
            isVisible: true,
            message: `Welcome, ${createUser.user.firstName}!`,
            type: "success",
          });
          this.$router.push({ name: "home" });
        } else if (createUser.__typename === "ValidationFailed") {
          this.errors = createUser.errors;
        }
      });
    },
  },
  components: { BaseCard, BaseInput, ErrorMessages, BaseButton },
};
</script>
<style lang=""></style>
