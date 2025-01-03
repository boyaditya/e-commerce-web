// router/index.js
import { createRouter, createWebHistory } from "vue-router";
import { useGlobalState } from "@/globalState";

// import HomePage from '@/components/HomePage.vue';
import ProductView from "@/views/ProductView.vue";
import LoginForm from "@/components/LoginForm.vue";
import RegisterForm from "@/components/RegisterForm.vue";
import HomeView from "@/views/HomeView.vue";
import StoreView from "@/views/StoreView.vue";
import CartView from "@/views/CartView.vue";
import UserView from "@/views/UserView.vue";
import ProfileSection from "@/components/user/ProfileSection.vue";
import CheckoutView from "@/views/CheckoutView.vue";
import AddressSection from "@/components/user/AddressSection.vue";
import OrderHistoryView from "@/views/OrderHistoryView.vue";
import OrderDetailView from "@/views/OrderDetailView.vue";
import PaymentPage from "@/components/PaymentPage.vue";


const routes = [
  {
    path: "/",
    name: "home",
    component: HomeView,
  },
  {
    path: "/checkout",
    name: "checkout",
    component: CheckoutView,
  },
  {
    path: "/payment/:method/:transaction_id/:payment_id",
    name: "payment",
    component: PaymentPage,
    props: true,
    beforeEnter: (to, from, next) => {
      const { state } = useGlobalState();
      if (!state.isAuthenticated) {
        next({ name: "login" });
      } else {
        next();
      }
    },
  },
  {
    path: "/user/order-history",
    name: "orderhistory",
    component: OrderHistoryView,
    beforeEnter: (to, from, next) => {
      const { state } = useGlobalState();
      if (!state.isAuthenticated) {
        next({ name: "login" });
      } else {
        next();
      }
    },
  },
  {
    path: '/order-detail/:invoice',
    name: 'OrderDetail',
    component: OrderDetailView,
    props: true, // agar parameter id dapat diterima sebagai props
  },
  {
    path: "/login",
    name: "login",
    component: LoginForm,
    beforeEnter: (to, from, next) => {
      const { state } = useGlobalState();
      if(state.isAuthenticated){
        next(from);
      }
      else{
        next();
      }
    },
  },
  {
    path: "/register",
    component: RegisterForm,
    beforeEnter: (to, from, next) => {
      const { state } = useGlobalState();
      if(state.isAuthenticated){
        next(from);
      }
      else{
        next();
      }
    },
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
  {
    path: "/user",
    name: "user",
    component: UserView,
    children: [
      {
        path: "profile",
        name: "profile",
        component: ProfileSection,
        props: () => ({
          userInfo: JSON.parse(localStorage.getItem("userInfo")),
          userAddress: JSON.parse(localStorage.getItem("userAddress")),
        }),
      },
      {
        name: "address",
        path: "address",
        component: () => AddressSection,
        props: () => ({
          userInfo: JSON.parse(localStorage.getItem("userAddress")),
        }),
      }

    ],
    beforeEnter: (to, from, next) => {
      const { state } = useGlobalState();
      if(!state.isAuthenticated){
        next({ name: "login" });
      }
      else{
        next();
      }
    },
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
