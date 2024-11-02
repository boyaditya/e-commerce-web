<template>
  <div class="product">
    <div class="product-img">
      <img :src="resolvedImgSrc" :alt="imgAlt" />
      <div class="product-label">
        <span v-if="saleLabel" class="sale">{{ saleLabel }}</span>
        <span v-if="newLabel" class="new">{{ newLabel }}</span>
      </div>
    </div>
    <div class="product-body">
      <p class="product-category">{{ category }}</p>
      <h3 class="product-name">
        <a :href="productLink">{{ productName }}</a>
      </h3>
      <h4 class="product-price">
        {{ productPrice }}
        <del v-if="oldPrice" class="product-old-price">{{ oldPrice }}</del>
      </h4>
      <div class="product-rating">
        <i v-for="star in 5" :key="star" class="fa fa-star"></i>
      </div>
      <div class="product-btns">
        <button class="add-to-wishlist">
          <i class="fa fa-heart-o"></i
          ><span class="tooltipp">add to wishlist</span>
        </button>
        <button class="add-to-compare">
          <i class="fa fa-exchange"></i
          ><span class="tooltipp">add to compare</span>
        </button>
        <!-- <div> -->
          <button class="quick-view">
              <router-link to="/view" class="quick-view">
              <i class="fa fa-eye"></i><span class="tooltipp">quick view</span>
            </router-link>
            </button>
        <!-- </div> -->
      </div>
    </div>
    <div class="add-to-cart">
      <button
        @click="addCartItemHandler(id, 1)"
        class="add-to-cart-btn"
      >
        <i class="fa fa-shopping-cart"></i> add to cart
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: "ProductItem",
  props: {
    id: {
      type: Number,
      required: true,
    },
    imgSrc: {
      type: String,
      required: true,
    },
    imgAlt: {
      type: String,
      required: true,
    },
    saleLabel: {
      type: String,
      default: "",
    },
    newLabel: {
      type: String,
      default: "",
    },
    category: {
      type: String,
      required: true,
    },
    productName: {
      type: String,
      required: true,
    },
    productLink: {
      type: String,
      required: true,
    },
    productPrice: {
      type: String,
      required: true,
    },
    oldPrice: {
      type: String,
      default: "",
    },
    addCartItemHandler: {
      type: Function,
      required: true,
    },
  },
  computed: {
    resolvedImgSrc() {
      // Use require to dynamically resolve the image path
      return require(`@/assets/img/${this.imgSrc}`);
    },
  },
};
</script>

<style scoped>
/* Add your styles here */
</style>