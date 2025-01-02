<template>
  <div class="auth-page">
    <div class="auth-container">
      <h1 class="auth-title">Log in</h1>
      <form @submit.prevent="handleLogin" class="auth-form">
        <div class="form-group">
          <input 
            type="email" 
            v-model="email" 
            class="form-input" 
            placeholder="Masukkan Email"
            autocomplete="email"
            required
          >
        </div>
        
        <div class="form-group">
          <input 
            type="password" 
            v-model="password" 
            class="form-input" 
            placeholder="Masukkan Password"
            autocomplete="current-password"
            required
          >
        </div>

        <p v-if="errorMessage" class="error-message" role="alert">{{ errorMessage }}</p>
        
        <button type="submit" class="auth-button">Log in</button>
      </form>
      
      <router-link to="/register" class="auth-link">
        Baru di ardhicom? Daftar disini
      </router-link>
    </div>
  </div>
</template>

<script>
import { useGlobalState } from "@/globalState";

export default {
  name: 'LoginForm',
  data() {
    return {
      email: '',
      password: '',
      errorMessage: ''
    }
  },
  setup(){
    const { login } = useGlobalState();
    return { login };
  },
  methods: {
    async handleLogin() {
      if (!this.email || !this.password) {
        this.errorMessage = 'Please fill in all fields';
        return;
      }
      
      try {
        // console.log('Login attempt:', { email: this.email, password: this.password });
        await this.login(this.email, this.password);
        const prevRoute = this.$router.options.history.state.back;
        if(prevRoute != "/register"){
          this.$router.back();
        }
        else{
          this.$router.push("/");
        }
      } catch (error) {
        console.error(error);
      }
    }
  }
}
</script>

<style scoped>
@import '../assets/css/auth.css';
</style>
