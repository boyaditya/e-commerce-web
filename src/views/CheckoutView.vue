<template>
  <HeaderPage />
  <CheckoutPage />
  <FooterPage />
</template>

<script>
import CheckoutPage from "@/components/CheckoutPage.vue";
import HeaderPage from "@/components/templates/HeaderPage.vue";
import FooterPage from "@/components/templates/FooterPage.vue";

export default {
  name: "CheckoutView",
  components: {
    CheckoutPage,
    HeaderPage,
    FooterPage,
  },
};
</script>

<style>
</style>