<template>
  <HeaderPage />
  <HomePage />
  <FooterPage />
</template>

<script>
import HeaderPage from "@/components/templates/HeaderPage.vue";
import FooterPage from "@/components/templates/FooterPage.vue";
import HomePage from "@/components/HomePage.vue";

export default {
  name: "HomeView",
  components: {
    HeaderPage,
    FooterPage,
    HomePage,
  },
};
</script>

<style>
</style>