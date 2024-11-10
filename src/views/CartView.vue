<template>
    <HeaderPage />
  <CartPage />
    <FooterPage />
</template>

<script>
import CartPage from '@/components/CartPage.vue';
import HeaderPage from '@/components/templates/HeaderPage.vue';
import FooterPage from '@/components/templates/FooterPage.vue';


export default {
    name: 'StoreView',
    components: {
        CartPage,
        HeaderPage,
        FooterPage,
    },
}
</script>

<style>

</style>