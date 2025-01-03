<template>
  <div class="auth-page">
    <div class="auth-container">
      <h1 class="auth-title">Daftar</h1>
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

        <p v-if="errorEmail" class="error-message" role="alert">
          {{ errorEmail }}
        </p>

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
          <label for="recipients_name">Nama Penerima</label>
          <input 
            type="text" 
            id="recipients_name"
            v-model="address.recipients_name" 
            class="form-input" 
            placeholder="Nama Penerima"
            required
          >
        </div>

        <div class="form-group">
          <label for="phone">Nomor Telepon</label>
          <input 
            type="text" 
            id="phone"
            v-model="address.phone_number" 
            class="form-input" 
            placeholder="Nomor Telepon"
            required
          >
        </div>
        <div class="form-group">
          <label for="street_address">Alamat</label>
          <input
            type="text"
            id="street_address"
            v-model="address.street_address"
            class="form-input"
            placeholder="Alamat"
            required
          />
        </div>

        <div class="form-group">
          <label for="city">Kota</label>
          <input
            type="text"
            id="city"
            v-model="address.city"
            class="form-input"
            placeholder="Kota"
            required
          />
        </div>

        <div class="form-group">
          <label for="state">Provinsi</label>
          <input
            type="text"
            id="state"
            v-model="address.state"
            class="form-input"
            placeholder="Provinsi"
            required
          />
        </div>

        <div class="form-group">
          <label for="postal_code">Kode Pos</label>
          <input
            type="text"
            id="postal_code"
            v-model="address.postal_code"
            class="form-input"
            placeholder="Kode Pos"
            required
          />
        </div>

        <div class="form-group">
          <label for="country">Negara</label>
          <input
            type="text"
            id="country"
            v-model="address.country"
            class="form-input"
            placeholder="Negara"
            required
          />
        </div>

        <p v-if="errorMessage" class="error-message" role="alert">
          {{ errorMessage }}
        </p>

        <button type="submit" class="auth-button">Daftar</button>
      </form>

      <router-link to="/login" class="auth-link">
        Sudah punya akun? Log in
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
      errorEmail: "",
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

      try {
        const response = await this.register(this.username, this.email, this.password, this.address);

        if (response?.status === 200) { // Assuming 200 is the success status code
          this.$router.push("/login");
        }
      } catch (error) {
        console.error("Error during registration:", error);
        if (error.response?.status === 400) {
          this.errorEmail = error.response.data?.detail || "Invalid email provided.";
        } else {
          this.errorEmail = "An error occurred. Please try again later.";
        }
      }
    },
  },
};
</script>

<style scoped>
@import "../assets/css/auth.css";
</style>
