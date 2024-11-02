// router/index.js
import { createRouter, createWebHistory } from 'vue-router';
// import HomePage from '@/components/HomePage.vue';
import CheckoutPage from '@/components/CheckoutPage.vue';
import QuickViewPage from '@/components/QuickViewPage';
import LoginForm from '@/components/LoginForm.vue';
import RegisterForm from '@/components/RegisterForm.vue';
import HomeView from '@/views/HomeView.vue';

const routes = [
  {
    path: '/',
    name: 'Home',
    component: HomeView,
  },
  {
    path: '/checkout',
    name: 'Checkout',
    component: CheckoutPage,
  },
  {
    path: '/login',
    component: LoginForm
  },
  {
    path: '/register',
    component: RegisterForm
  },
  {
    path: '/view',
    component: QuickViewPage
  }
];

const router = createRouter({
  history: createWebHistory(), // Enables history mode without hash in URLs
  routes,
});

export default router;