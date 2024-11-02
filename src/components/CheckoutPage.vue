<template>
  <HeaderPage/>
  <NavPage/>
  <BreadcrumbPage/>
  <div class="checkout-section container mt-4">
    <!-- Billing Details -->
    <div class="billing-details">
      <h3>Billing Address</h3>
      <div class="form-group">
        <input type="text" class="form-control" v-model="firstName" placeholder="First Name">
      </div>
      <div class="form-group">
        <input type="text" class="form-control" v-model="lastName" placeholder="Last Name">
      </div>
      <div class="form-group">
        <input type="email" class="form-control" v-model="email" placeholder="Email">
      </div>
      <div class="form-group">
        <input type="text" class="form-control" v-model="address" placeholder="Address">
      </div>
      <div class="form-group">
        <input type="text" class="form-control" v-model="city" placeholder="City">
      </div>
      <div class="form-group">
        <input type="text" class="form-control" v-model="country" placeholder="Country">
      </div>
      <div class="form-group">
        <input type="text" class="form-control" v-model="zipCode" placeholder="ZIP Code">
      </div>
      <div class="form-group">
        <input type="tel" class="form-control" v-model="telephone" placeholder="Telephone">
      </div>
      <div class="form-group form-check">
        <input type="checkbox" class="form-check-input" v-model="createAccount" id="createAccount">
        <label class="form-check-label" for="createAccount">Create Account?</label>
      </div>
      <div v-if="createAccount" class="form-group">
        <input type="password" class="form-control" v-model="password" placeholder="Enter Your Password">
      </div>
    </div>
    <!-- </div> -->

    <!-- Shipping Details -->
    <div class="shipping-details">
      <h3>Shipping Address</h3>
      <div class="form-check">
        <input type="checkbox" class="form-check-input" v-model="differentShipping" id="differentShipping">
        <label class="form-check-label" for="differentShipping">Ship to a different address?</label>
      </div>
      <div v-if="differentShipping">
        <div class="form-group">
          <input type="text" class="form-control" v-model="shippingFirstName" placeholder="First Name">
        </div>
        <div class="form-group">
          <input type="text" class="form-control" v-model="shippingLastName" placeholder="Last Name">
        </div>
        <div class="form-group">
          <input type="email" class="form-control" v-model="shippingEmail" placeholder="Email">
        </div>
        <div class="form-group">
          <input type="text" class="form-control" v-model="shippingAddress" placeholder="Address">
        </div>
        <div class="form-group">
          <input type="text" class="form-control" v-model="shippingCity" placeholder="City">
        </div>
        <div class="form-group">
          <input type="text" class="form-control" v-model="shippingCountry" placeholder="Country">
        </div>
      </div>
    </div> 
  </div>
  <ShippingDetails/>
  <FooterPage/>
</template>

<script>
import HeaderPage from '@/components/templates/HeaderPage.vue';
import NavPage from '@/components/templates/NavPage.vue';
import BreadcrumbPage from '@/components/templates/BreadCrumbPage.vue';
import FooterPage from '@/components/templates/FooterPage.vue';
import ShippingDetails from '@/components/ShippingDetails.vue';

export default {

  name: 'CheckoutPage',
  components: {
    HeaderPage,
    NavPage,
    BreadcrumbPage,
    FooterPage,
    ShippingDetails,
  },
  data() {
    return {
      firstName: '',
      lastName: '',
      email: '',
      address: '',
      city: '',
      country: '',
      zipCode: '',
      telephone: '',
      createAccount: false,
      password: '',
      differentShipping: false,
      shippingFirstName: '',
      shippingLastName: '',
      shippingEmail: '',
      shippingAddress: '',
      shippingCity: '',
      shippingCountry: ''
    };
  }
};
</script>
<!-- .red-checkbox:checked {
  accent-color: red; /* Mengubah warna centang menjadi merah pada checkbox */
} -->
<style scoped>
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
