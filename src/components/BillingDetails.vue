<template>
    <div class="billing-details">
      <div class="section-title">
        <h3 class="title">Billing address</h3>
      </div>
      <div v-for="(field, key) in fields" :key="key" class="form-group">
        <input class="input" v-model="formData[key]" :type="field.type" :placeholder="field.placeholder">
      </div>
    </div>
  </template>
  
<script>
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

<style>
.form-check-input {
  position: relative;
  cursor: pointer;
}

.form-check-input:checked {
  outline: none;
}

.form-check-input:checked::before {
  content: '';
  position: absolute;
  width: 20px;
  height: 20px;
  background-color: red; /* Warna latar belakang centang */
  border: 2px solid red; /* Warna border */
  border-radius: 4px; /* Mengatur border radius agar sudut melengkung */
  top: -2px; /* Atur posisi vertikal */
  left: -2px; /* Atur posisi horizontal */
}

.form-check-input:checked + .form-check-label {
  color: red; /* Mengubah warna label centang jika dicentang */
}
</style>
