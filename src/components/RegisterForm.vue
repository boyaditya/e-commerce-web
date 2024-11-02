<template>
  <div class="auth-page">
    <div class="auth-container">
      <h1 class="auth-title">Register</h1>
      <form @submit.prevent="handleRegister" class="auth-form">
        <div class="form-group">
          <input 
            type="text" 
            v-model="username" 
            class="form-input" 
            placeholder="Choose a username"
            autocomplete="username"
            required
          >
        </div>

        <div class="form-group">
          <input 
            type="text" 
            v-model="name" 
            class="form-input" 
            placeholder="Enter your full name"
            autocomplete="name"
            required
          >
        </div>
        
        <div class="form-group">
          <input 
            type="email" 
            v-model="email" 
            class="form-input" 
            placeholder="Enter your email"
            autocomplete="email"
            required
          >
        </div>
        
        <div class="form-group">
          <input 
            type="password" 
            v-model="password" 
            class="form-input" 
            placeholder="Choose a password"
            autocomplete="new-password"
            required
          >
        </div>

        <p v-if="errorMessage" class="error-message" role="alert">{{ errorMessage }}</p>
        
        <button type="submit" class="auth-button">Register</button>
      </form>
      
      <router-link to="/login" class="auth-link">
        Already have an account? Login here
      </router-link>
    </div>
  </div>
</template>

<script>
export default {
  name: 'RegisterForm',
  data() {
    return {
      username: '',
      name: '',
      email: '',
      password: '',
      errorMessage: ''
    }
  },
  methods: {
    handleRegister() {
      if (!this.username || !this.name || !this.email || !this.password) {
        this.errorMessage = 'Please fill in all fields';
        return;
      }
      console.log('Register attempt:', {
        username: this.username,
        name: this.name,
        email: this.email,
        password: this.password
      });
    }
  }
}
</script>

<style scoped>
@import '../assets/css/auth.css';
</style>
