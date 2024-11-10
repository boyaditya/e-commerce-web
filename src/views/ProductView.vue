<template>
    <HeaderPage />
  <ProductPage />
    <FooterPage />
</template>

<script>
import ProductPage from '@/components/ProductPage.vue';
import HeaderPage from '@/components/templates/HeaderPage.vue';
import FooterPage from '@/components/templates/FooterPage.vue';


export default {
    name: 'ProductView',
    components: {
        ProductPage,
        HeaderPage,
        FooterPage,
    },
}
</script>

<style>

</style>