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
        <BaseButton
          type="submit"
          class="btn-primary w-100"
        >
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
    login() {

    }
  }
};
</script>
<style lang=""></style>
