<template>
  <div class="col-md-4 col-xs-6">
    <div class="shop">
      <div class="shop-img">
        <img :src="resolvedImgSrc" :alt="imgAlt" />
      </div>
      <div class="shop-body">
        <h3>{{ title }}<br />{{ subtitle }}</h3>
        <a :href="link" class="cta-btn">
          Shop now <i class="fa fa-arrow-circle-right"></i>
        </a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ShopItem',
  props: {
    imgSrc: {
      type: String,
      required: true
    },
    imgAlt: {
      type: String,
      default: ''
    },
    title: {
      type: String,
      required: true
    },
    subtitle: {
      type: String,
      required: true
    },
    link: {
      type: String,
      default: '#'
    }
  },
  computed: {
    resolvedImgSrc() {
      // Use require to dynamically resolve the image path
      return require(`@/assets/img/${this.imgSrc}`);
    }
  }
};
</script>

<style scoped>
/* Your styles here */
</style>