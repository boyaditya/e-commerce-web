<template>
    <!-- <div class="billing-details">
      <div class="section-title">
        <h3 class="title">Shipping Address</h3>
      </div>
      <div v-for="(field, key) in fields" :key="key" class="form-group">
        <input class="input" v-model="formData[key]" :type="field.type" :placeholder="field.placeholder">
      </div>
    </div> -->

</template>

<script>
/* eslint-disable */
  export default {
    props: ['value'],
    data() {
      return {
        fields: {
          shippingFirstName: { placeholder: 'First Name', type: 'text' },
          shippingLastName: { placeholder: 'Last Name', type: 'text' },
          shippingEmail: { placeholder: 'Email', type: 'email' },
          shippingAddress: { placeholder: 'Address', type: 'text' },
          shippingCity: { placeholder: 'City', type: 'text' },
          shippingCountry: { placeholder: 'Country', type: 'text' },
        },
        formData: { ...this.value }
      };
    },
    watch: {
      formData: {
        handler(val) {
          this.$emit('input', val);
        },
        deep: true
      }
    }
  };
</script>