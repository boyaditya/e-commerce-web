// router/index.js
import { createRouter, createWebHistory } from "vue-router";

// import HomePage from '@/components/HomePage.vue';
import CheckoutPage from "@/components/CheckoutPage.vue";
import QuickViewPage from "@/components/QuickViewPage";
import ProductView from "@/views/ProductView.vue";

import LoginForm from "@/components/LoginForm.vue";
import RegisterForm from "@/components/RegisterForm.vue";
import HomeView from "@/views/HomeView.vue";
import StoreView from "@/views/StoreView.vue";
import CartView from "@/views/CartView.vue";

const routes = [
  {
    path: "/",
    name: "home",
    component: HomeView,
  },
  {
    path: "/checkout",
    name: "checkout",
    component: CheckoutPage,
  },
  {
    path: "/login",
    component: LoginForm,
  },
  {
    path: "/register",
    component: RegisterForm,
  },
  {
    path: "/view",
    component: QuickViewPage,
  },
  {
    path: "/store",
    name: "store",
    component: StoreView,
  },
  {
    path: "/product/:id", // Tambahkan parameter :id pada path
    name: "product",
    component: ProductView,
  },
  {
    path: "/cart",
    name: "cart",
    component: CartView,
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL), // Enables history mode without hash in URLs
  routes,
});
router.afterEach((to, from) => {
  if (from.name) {
    // window.location.reload();
     window.scrollTo(0, 0);
  }
});

export default router;
