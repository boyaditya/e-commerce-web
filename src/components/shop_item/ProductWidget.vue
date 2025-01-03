<template>
  <div class="product-widget">
    <div class="product-img">
      <img :src="resolvedImgSrc" :alt="imgAlt" />
    </div>
    <div class="product-body">
      <p class="product-category">{{ category }}</p>
      <h3 class="product-name">
        <a :href="productLink">{{ productName }}</a>
      </h3>
      <h4 class="product-price">
        {{ productPrice }} <del v-if="oldPrice" class="product-old-price">{{ oldPrice }}</del>
      </h4>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ProductWidget',
  props: {
    imgSrc: {
      type: String,
      required: true
    },
    imgAlt: {
      type: String,
      default: ''
    },
    category: {
      type: String,
      required: true
    },
    productName: {
      type: String,
      required: true
    },
    productLink: {
      type: String,
      required: true
    },
    productPrice: {
      type: String,
      required: true
    },
    oldPrice: {
      type: String,
      default: ''
    }
  },
  computed: {
    resolvedImgSrc() {
      return require(`@/assets/img/${this.imgSrc}`);
    }
  }
};
</script>

<style scoped>
</style>