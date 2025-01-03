<template>
  <BreadCrumbPage :categoryName="categoryName" :productName="product.name" :categoryId="product.category_id" />

  <div class="section">
    <!-- container -->
    <div class="container">
      <!-- row -->
      <div class="row" v-if="isLoading">
        <div class="col-md-12 loading-container">
          <div class="spinner"></div>
        </div>
      </div>
      <div class="row" v-else>
        <!-- Product main img -->
        <div class="col-md-5">
          <div id="product-main-img">
            <div class="product-preview">
              <!-- <img src="@/assets/img/product01.png" alt="" /> -->
               <img :src="require('@/assets/img/' + product.image_url)" :alt="product.name">
            </div>
          </div>
        </div>
        <!-- /Product main img -->

        <!-- Product details -->
        <div class="col-md-7">
          <div class="product-details">
            <h2 class="product-name">{{ product.name }}</h2>
            <div>
              <h3 class="product-price">
                {{ formattedTotalPrice }}
                <!-- <del class="product-old-price">$990.00</del> -->
              </h3>
              <span class="product-available">Stock: {{ product.stock }}</span>
            </div>

            <hr class="hr" />
            <p>
              <i class="fa fa-map-marker icon"></i> Dikirim dari
              <b>Kota Bandung</b>
            </p>
            <p><i class="fa fa-truck icon"></i> <b>Ongkir mulai Rp12.000</b></p>
            <small style="margin-left: 30px"
              >Reguler • Estimasi tiba {{ estimatedArrival }}</small
            >
            <br />
            <hr class="hr" />
            <div class="add-to-cart">
              <div class="qty-label">
                Qty
                <div class="input-number">
                  <input
                    type="number"
                    v-model.number="quantity"
                    min="1"
                    :max="product.stock"
                  />
                  <span class="qty-up" @click="increaseQuantity">+</span>
                  <span class="qty-down" @click="decreaseQuantity">-</span>
                </div>
              </div>
              <button @click="handleAddToCart" class="add-to-cart-btn">
                <i class="fa fa-shopping-cart"></i> add to cart
              </button>
            </div>

            <ul class="product-btns">
              <li>
                <a @click="toggleWishlist">
                  <div v-if="!isWishlist">
                    <i class="fa fa-heart-o"></i>
                    add to wishlist
                  </div>
                  <div v-else>
                    <i class="fa fa-heart" style="color:red;"></i>
                    remove from wishlist
                  </div>
                </a>
              </li>
            </ul>

            <ul class="product-links">
              <li>Category:</li>
              <li>
                <a href="#">{{ categoryName }}</a>
              </li>
            </ul>
          </div>
        </div>
        <!-- /Product details -->

        <!-- Product tab -->
        <div class="col-md-12">
          <div id="product-tab">
            <!-- product tab nav -->
            <ul class="tab-nav">
              <li class="active">
                <a data-toggle="tab" href="#tab1">Description</a>
              </li>
            </ul>
            <!-- /product tab nav -->

            <!-- product tab content -->
            <div class="tab-content">
           
              <div id="tab1" class="tab-pane fade in active">
                <div class="row">
                  <div class="col-md-12">
                    <p v-html="formattedDescription"></p>
                  </div>
                </div>
              </div>
            </div>
            <!-- /product tab content  -->
          </div>
        </div>
        <!-- /product tab -->
      </div>
      <!-- /row -->
    </div>
    <!-- /container -->
  </div>
  <!-- /SECTION -->

  <!-- Section -->
  <div class="section">
    <!-- container -->
    <div class="container">
      <!-- row -->

      <!-- /row -->
    </div>
    <!-- /container -->
  </div>
  <!-- /Section -->
</template>

<script>
import BreadCrumbPage from "@/components/templates/BreadCrumbPage.vue";
import { fetchProductById, fetchCategoryById } from "@/api/api.js";
import "@/assets/css/loading.css"; // Impor file CSS
import { useGlobalState } from "@/globalState";

export default {
  name: "ProductPage",
  components: {
    BreadCrumbPage,
  },
  data() {
    return {
      product: {},
      productPrice: 0,
      isLoading: true, // Tambahkan properti isLoading
      shippingDuration: { min: 3, max: 5 }, // Estimated shipping duration in days
      quantity: 1, // Default quantity
      // isWishlist: false,
    };
  },
  setup() {
    const globalState = useGlobalState();

    return {
      globalState
    };
  },
  computed: {
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

    estimatedArrival() {
      const today = new Date();
      const minArrival = new Date(today);
      const maxArrival = new Date(today);
      minArrival.setDate(today.getDate() + this.shippingDuration.min);
      maxArrival.setDate(today.getDate() + this.shippingDuration.max);
      const options = { day: "numeric", month: "short" }; // Format options
      return `${minArrival.toLocaleDateString(
        "id",
        options
      )} - ${maxArrival.toLocaleDateString("id", options)}`;
    },

    formattedDescription() {
      return this.product.description.replace(/\n/g, "<br>");
    },

    isWishlist(){
      return this.globalState.state.wishlistProducts.some(item => item.product_id === this.product.id);
    }
  },

  async created() {
    await this.fetchProduct();
  },
  methods: {
    async fetchProduct() {
      const productId = this.$route.params.id;
      try {
        const product = await fetchProductById(productId);
        this.product = product;
        this.productPrice = product.price;
        await this.fetchCategory(product.category_id); // Fetch category name based on category_id
      } catch (error) {
        console.error("Failed to fetch product:", error);
      } finally {
        this.isLoading = false;
      }
    },
    async fetchCategory(categoryId) {
      try {
        const category = await fetchCategoryById(categoryId);
        this.categoryName = category.name;
      } catch (error) {
        console.error("Failed to fetch category:", error);
      }
    },
    increaseQuantity() {
      if (this.quantity < this.product.stock) {
        this.quantity++;
      }
    },
    decreaseQuantity() {
      if (this.quantity > 1) {
        this.quantity--;
      }
    },
    async handleAddToCart() {
      // Implement the add-to-cart functionality here
      // For example, you can emit an event or call an API to add the product to the cart
      console.log(`Added ${this.quantity} items to the cart`);

      try {
        const responseData = await this.globalState.addOrUpdate(this.product.id, this.quantity);
        if(responseData){
          alert("Added " + this.quantity + " item(s) to your cart");
          this.quantity = 1;
        }
      } catch (error) {
        console.error(error);
      }
    },
    async toggleWishlist() {
      if(this.globalState.state.isAuthenticated){
        if(this.isWishlist){
          const item = this.globalState.state.wishlistProducts.find(item => item.product.id === this.product.id);
          await this.globalState.removeFromWishlist(item.id);
        }
        else{
          await this.globalState.addToWishlist(this.product.id);
        }
      }
      else{
        this.$router.push({ name: "login" });
      }
    }
  },
    watch: {
    quantity(newQuantity) {
      if (newQuantity > this.product.stock) {
        this.quantity = this.product.stock;
      } else if (newQuantity < 1) {
        this.quantity = 1;
      }
    },
  },
};
</script>

<style scoped>
.product-name {
  font-size: 24px; /* Adjust the value as needed */
}

.product-price {
  font-size: 36px; /* Adjust the value as needed */
}

.icon {
  width: 20px; /* Set a consistent width for the icons */
  text-align: center; /* Center align the icons */
  margin-right: 5px; /* Add some space between the icon and the text */
}



p {
  white-space: pre-line; /* Preserve new lines */
}
</style>