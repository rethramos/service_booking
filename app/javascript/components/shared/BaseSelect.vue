<template>
  <div class="form-group">
    <label v-if="label" :for="$attrs.id">
      {{ label }}
      <span v-if="'required' in $attrs" class="text-danger">*</span>
    </label>
    <select :value="modelValue" @change="updateValue" v-bind="$attrs">
      <option value="" disabled>Select...</option>
      <!-- Only supports an array of objects for now -->
      <option
        v-for="option in options"
        :key="option[valueKey]"
        :value="option[valueKey]"
      >
        {{ option[labelKey] }}
      </option>
    </select>
  </div>
</template>
<script>
export default {
  inheritAttrs: false,
  props: {
    label: {
      type: String,
      default: "",
    },
    modelValue: {
      type: [String, Number],
    },
    options: {
      type: Array,
      required: true,
    },
    valueKey: {
      type: String,
    },
    labelKey: {
      type: String,
    },
  },
  emits: ["update:modelValue"],
  methods: {
    updateValue(event) {
      this.$emit("update:modelValue", event.target.value);
    },
  },
};
</script>
<style></style>
