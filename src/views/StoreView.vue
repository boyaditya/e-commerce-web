<template>
    <HeaderPage />
  <StorePage />
    <FooterPage />
</template>

<script>
import StorePage from '@/components/StorePage.vue';
import HeaderPage from '@/components/templates/HeaderPage.vue';
import FooterPage from '@/components/templates/FooterPage.vue';


export default {
    name: 'StoreView',
    components: {
        StorePage,
        HeaderPage,
        FooterPage,
    },
}
</script>

<style>

</style>