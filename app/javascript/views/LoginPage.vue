<template lang="">
  <BaseCard class="card-body">
    <h1>Log in</h1>
    <form @submit.prevent="logIn" action="" class="row g-2">
      <BaseInput
        :label="'Email'"
        v-model="credentials.email"
        type="email"
        name="email"
        id="email"
        class="form-control"
      />
      <BaseInput
        :label="'Password'"
        v-model="credentials.password"
        type="password"
        name="password"
        id="password"
        class="form-control"
      />
      <div class="form-group">
        <BaseButton type="submit" class="btn-primary w-100">
          Log in
        </BaseButton>
      </div>
    </form>
  </BaseCard>
</template>
<script>
import BaseCard from "../components/shared/BaseCard.vue";
import BaseInput from "../components/shared/BaseInput.vue";
import BaseButton from "../components/shared/BaseButton.vue";
import { mapActions, mapMutations } from "vuex";
export default {
  components: {
    BaseCard,
    BaseInput,
    BaseButton,
  },
  data() {
    return {
      credentials: {
        email: "",
        password: "",
      },
    };
  },
  methods: {
    ...mapActions("auth", ["loginUser"]),
    ...mapMutations("toast", ["SET_TOAST"]),
    logIn() {
      this.loginUser(this.credentials).then((loginUser) => {
        switch (loginUser.__typename) {
          case "LoginUserPayload":
            this.SET_TOAST({
              header: "Success",
              isVisible: true,
              message: `Welcome, ${loginUser.user.firstName}!`,
              type: "success",
            });
            this.$router.push({ name: "home" });
            break;

          case "InvalidCredentials":
            this.SET_TOAST({
              header: "Error",
              isVisible: true,
              message: loginUser.message,
              type: "danger",
            });
            break;

          default:
            break;
        }
      });
    },
  },
};
</script>
<style lang=""></style>
