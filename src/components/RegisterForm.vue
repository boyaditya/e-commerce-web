<template>
  <div class="auth-page">
    <div class="auth-container">
      <h1 class="auth-title">Register</h1>
      <form @submit.prevent="handleRegister" class="auth-form">
        <div class="form-group">
          <label for="username">Username</label>
          <input
            type="text"
            id="username"
            v-model="username"
            class="form-input"
            placeholder="Enter your username"
            autocomplete="username"
            required
          />
        </div>

        <div class="form-group">
          <label for="email">Email</label>
          <input
            type="email"
            id="email"
            v-model="email"
            class="form-input"
            placeholder="Enter your email"
            autocomplete="email"
            required
          />
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input
            type="password"
            id="password"
            v-model="password"
            class="form-input"
            placeholder="Choose a password"
            autocomplete="new-password"
            required
          />
        </div>
        <hr />

                <div class="form-group">
          <label for="recipients_name">Recipient's Name</label>
          <input 
            type="text" 
            id="recipients_name"
            v-model="address.recipients_name" 
            class="form-input" 
            placeholder="Recipient's Name"
            required
          >
        </div>

        <div class="form-group">
          <label for="phone">Phone Number</label>
          <input 
            type="text" 
            id="phone"
            v-model="address.phone_number" 
            class="form-input" 
            placeholder="Phone Number"
            required
          >
        </div>
        <div class="form-group">
          <label for="street_address">Street Address</label>
          <input
            type="text"
            id="street_address"
            v-model="address.street_address"
            class="form-input"
            placeholder="Street Address"
            required
          />
        </div>

        <div class="form-group">
          <label for="city">City</label>
          <input
            type="text"
            id="city"
            v-model="address.city"
            class="form-input"
            placeholder="City"
            required
          />
        </div>

        <div class="form-group">
          <label for="state">State</label>
          <input
            type="text"
            id="state"
            v-model="address.state"
            class="form-input"
            placeholder="State"
            required
          />
        </div>

        <div class="form-group">
          <label for="postal_code">Postal Code</label>
          <input
            type="text"
            id="postal_code"
            v-model="address.postal_code"
            class="form-input"
            placeholder="Postal Code"
            required
          />
        </div>

        <div class="form-group">
          <label for="country">Country</label>
          <input
            type="text"
            id="country"
            v-model="address.country"
            class="form-input"
            placeholder="Country"
            required
          />
        </div>

        <p v-if="errorMessage" class="error-message" role="alert">
          {{ errorMessage }}
        </p>

        <button type="submit" class="auth-button">Register</button>
      </form>

      <router-link to="/login" class="auth-link">
        Already have an account? Login here
      </router-link>
    </div>
  </div>
</template>

<script>
import { useGlobalState } from "@/globalState";

export default {
  name: "RegisterForm",
  data() {
    return {
      username: "",
      name: "",
      email: "",
      password: "",
      address: {
        receipents_name: "",
        phone_number: "",
        street_address: "",
        city: "",
        state: "",
        postal_code: "",
        country: "",
      },
      errorMessage: "",
    };
  },
  setup() {
    const { register } = useGlobalState();
    return { register };
  },
  methods: {
    async handleRegister() {
      if (!this.username || !this.email || !this.password || !this.address) {
        this.errorMessage = "Please fill in all fields";
        return;
      }

      // console.log('Register attempt:', {
      //   username: this.username,
      //   email: this.email,
      //   password: this.password
      // });

      try {
        await this.register(this.username, this.email, this.password, this.address);
        this.$router.push("/login");
      } catch (error) {
        console.error(error);
      }
    },
  },
};
</script>

<style scoped>
@import "../assets/css/auth.css";
</style>
