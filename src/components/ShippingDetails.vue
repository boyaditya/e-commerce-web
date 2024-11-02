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
          firstName: { placeholder: 'First Name', type: 'text' },
          lastName: { placeholder: 'Last Name', type: 'text' },
          email: { placeholder: 'Email', type: 'email' },
          address: { placeholder: 'Address', type: 'text' },
          city: { placeholder: 'City', type: 'text' },
          country: { placeholder: 'Country', type: 'text' },
          zipCode: { placeholder: 'ZIP Code', type: 'text' },
          telephone: { placeholder: 'Telephone', type: 'tel' }
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