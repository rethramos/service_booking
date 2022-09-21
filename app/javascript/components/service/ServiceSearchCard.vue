<template lang="">
  <BaseCard class="card-body d-flex flex-row gap-4 align-items-start">
    <RouterLink :to="{ name: 'services-show', params: { id: service.id } }">
      <img
        :src="service.image"
        :alt="service.name"
        style="width: 100px; height: 100px; object-fit: cover"
      />
    </RouterLink>
    <div>
      <p class="text-uppercase mb-1">{{ service.serviceCategory.name }}</p>
      <RouterLink :to="{ name: 'services-show', params: { id: service.id } }">
        <p class="h3">{{ service.name }}</p>
      </RouterLink>
      <p>{{ service.business.name }}</p>
      <p>{{ service.description }}</p>
    </div>
  </BaseCard>
</template>
<script>
import BaseCard from "../shared/BaseCard.vue";

export default {
  components: { BaseCard },
  props: {
    service: {
      type: Object,
      required: true,
    },
  },
};
</script>
<style lang=""></style>
