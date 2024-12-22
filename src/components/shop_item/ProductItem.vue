<template>
  <div :class="colClass">
    <div class="product">
      <div class="product-img">
        <img :src="resolvedImgSrc" :alt="productName" />
        <div class="product-label">
          <span v-if="saleLabel" class="sale">{{ saleLabel }}</span>
          <span v-if="newLabel" class="new">{{ newLabel }}</span>
        </div>
      </div>
      <div class="product-body">
        <p class="product-category">{{ category }}</p>
        <h3 class="product-name">
          <router-link :to="{ path: `/product/${id}` }">{{
            productName
          }}</router-link>
        </h3>
        <h4 class="product-price">
          {{ formattedTotalPrice }}
          <del v-if="oldPrice" class="product-old-price">{{ oldPrice }}</del>
        </h4>
        <!-- <div class="product-rating">
          <i v-for="star in 5" :key="star" class="fa fa-star"></i>
        </div> -->
        <!-- <div class="product-btns">
          <button class="add-to-wishlist">
            <i class="fa fa-heart-o"></i
            ><span class="tooltipp">add to wishlist</span>
          </button>
          <button class="quick-view">
            <router-link to="/view" class="quick-view">
              <i class="fa fa-eye"></i><span class="tooltipp">quick view</span>
            </router-link>
          </button>
        </div> -->
      </div>
      <!-- <div class="add-to-cart">
        <button @click="handleAddToCart" class="add-to-cart-btn">
          <i class="fa fa-shopping-cart"></i> +cart
        </button>
      </div> -->
    </div>
  </div>
</template>

<script>
import Swal from "sweetalert2";
import axios from "axios";

export default {
  name: "ProductItem",
  data() {
    return {
      cartProducts: [],
    };
  },
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
      type: Number,
      required: true,
    },
    productPrice: {
      type: Number,
      required: true,
    },
    oldPrice: {
      type: String,
      default: "",
    },
    addCartItemHandler: {
      type: Function,
    },
    colClass: {
      type: String,
      default: "col-md-2",
    },
  },
  computed: {
    resolvedImgSrc() {
      try {
        return require(`@/assets/img/${this.imgSrc}`);
      } catch (e) {
        console.error(`Image not found: ${this.imgSrc}`);
        return require("@/assets/img/default-image.jpg");
      }
    },
    formattedTotalPrice() {
      return new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
      })
        .format(this.productPrice)
        .replace(/\s/g, "");
    },
  },
  methods: {
    async addCartItem(product_id, quantity) {
      try {
        const response = await axios.post(
          "http://127.0.0.1:8000/add_cart_item",
          {
            user_id: this.userInfo.user_id,
            product_id: product_id,
            quantity: quantity,
          },
          {
            headers: {
              Authorization: `Bearer ${this.userInfo.access_token}`,
            },
          }
        );

        console.log(response.data);
        console.log(this.cartProducts.length);
        this.cartProducts.push(response.data);
        this.cartProducts = [...this.cartProducts];
        console.log(this.cartProducts.length);
      } catch (error) {
        console.error(error);
      } finally {
        this.loadingCart = false;
      }
    },
    handleAddToCart(product_id, quantity = 1) {
      console.log("handleAddToCart");
      var productExist = this.cartProducts.find(
        (product) => product.product.id == product_id
      );
      if (productExist) {
        console.log("exist");
        this.addCartItem(product_id, quantity);
      } else {
        this.addCartItem(product_id, quantity);
      }

      Swal.fire({
        title: "Success!",
        text: "Item has been added to the cart.",
        icon: "success",
        confirmButtonText: "OK",
        showCancelButton: true,
        cancelButtonText: "Lihat Keranjang Saya",
      }).then((result) => {
        if (result.dismiss === Swal.DismissReason.cancel) {
          this.goToCart();
        }
      });
    },
    goToCart() {
      this.$router.push("/cart").then(() => {
        window.scrollTo(0, 0);
      });
    },
  },
  watch: {
    cartProducts: {
      handler(newVal) {
        console.log("Cart products updated:", newVal);
      },
      deep: true, // Ensures the watcher reacts to nested changes in the array
      immediate: true, // Runs the watcher immediately on component mount
    },
  },
};
</script>

<style scoped>
/* Add your styles here */
</style>