<template>
  <router-link :to="{ path: '/store' }" class="shop-body-link">
  <div class="col-md-2 col-xs-6">
    <div class="shop">
      <div class="shop-img">
        <img :src="resolvedImgSrc" :alt="imgAlt" />
      </div>
    <div class="shop-body">
      <h3>{{ title }}<br />{{ subtitle }}</h3>
    </div>
  </div>
</div>
</router-link>
</template>

<script>
export default {
  name: "CategoryItem",
  props: {
    imgSrc: {
      type: String,
      required: true,
    },
    imgAlt: {
      type: String,
      default: "",
    },
    title: {
      type: String,
      required: true,
    },
    subtitle: {
      type: String,
      required: true,
    },
    link: {
      type: String,
      default: "#",
    },
  },
  computed: {
    resolvedImgSrc() {
      // Use require to dynamically resolve the image path
      return require(`@/assets/img/category/${this.imgSrc}`);
    },
  },
};
</script>

<style scoped>
/* Your styles here */
</style>