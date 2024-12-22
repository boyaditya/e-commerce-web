<template>
  <!-- SECTION -->
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
        <!-- ASIDE -->
        <div id="aside" class="col-md-3">
          <!-- aside Widget -->
          <div class="aside">
            <h3 class="aside-title">Categories</h3>
            <div class="checkbox-filter">
              <div
                v-for="category in categories"
                :key="category.id"
                class="input-checkbox"
              >
                <input
                  type="checkbox"
                  :id="'category-' + category.id"
                  :value="category.id"
                  v-model="selectedCategories"
                />
                <label :for="'category-' + category.id">
                  <span></span>
                  {{ category.name }}
                  <small>({{ category.productCount }})</small>
                </label>
              </div>
            </div>
          </div>
          <!-- /aside Widget -->

          <!-- aside Widget -->
          <!-- <div class="aside">
            <h3 class="aside-title">Price</h3>
            <div class="price-filter">
              <div id="price-slider"></div>
              <div class="input-number price-min">
                <input id="price-min" type="number" />
                <span class="qty-up">+</span>
                <span class="qty-down">-</span>
              </div>
              <span>-</span>
              <div class="input-number price-max">
                <input id="price-max" type="number" />
                <span class="qty-up">+</span>
                <span class="qty-down">-</span>
              </div>
            </div>
          </div> -->
          <!-- /aside Widget -->
        </div>
        <!-- /ASIDE -->

        <!-- STORE -->
        <div id="store" class="col-md-9">
          <!-- store top filter -->
          <div class="store-filter clearfix">
            <div class="store-sort">
              <label>
                Sort By:
                <select
                  class="input-select"
                  v-model="selectedSort"
                  @change="sortProducts"
                >
                  <option value="newest">Newest</option>
                  <option value="lowest">Lowest Price</option>
                  <option value="highest">Highest Price</option>
                </select>
              </label>

              <!-- <label>
                Show:
                <select class="input-select">
                  <option value="0">20</option>
                  <option value="1">50</option>
                </select>
              </label> -->
            </div>
            <!-- <ul class="store-grid">
              <li class="active"><i class="fa fa-th"></i></li>
              <li>
                <a href="#"><i class="fa fa-th-list"></i></a>
              </li>
            </ul> -->
          </div>
          <!-- /store top filter -->

          <!-- store products -->
          <div class="row">
            <!-- products -->
            <ProductItem
              v-for="product in filteredProducts"
              :key="product.id"
              :id="product.id"
              :imgSrc="product.image_url || 'default-image.jpg'"
              :imgAlt="product.name"
              :saleLabel="'-30%'"
              :newLabel="'NEW'"
              :category="product.category.name"
              :productName="product.name"
              :productLink="product.id"
              :productPrice="product.price"
              :addCartItemHandler="addCartItemHandler"
              :colClass="'col-md-3'"
            />
            <!-- /products -->
          </div>
          <!-- /store products -->

          <!-- store bottom filter -->
          <div class="store-filter clearfix">
            <span class="store-qty">Showing 20-100 products</span>
            <ul class="store-pagination">
              <li class="active">1</li>
              <li><a href="#">2</a></li>
              <li><a href="#">3</a></li>
              <li><a href="#">4</a></li>
              <li>
                <a href="#"><i class="fa fa-angle-right"></i></a>
              </li>
            </ul>
          </div>
          <!-- /store bottom filter -->
        </div>
        <!-- /STORE -->
      </div>
      <!-- /row -->
    </div>
    <!-- /container -->
  </div>
  <!-- /SECTION -->
</template>

<script>
import ProductItem from "@/components/shop_item/ProductItem.vue";
import {
  fetchAllProducts,
  fetchCategories,
  fetchProductsByCategory,
} from "@/api/api";
import "@/assets/css/loading.css"; // Import CSS file

export default {
  name: "StorePage",
  components: {
    ProductItem,
  },
  data() {
    return {
      allProducts: [],
      categories: [],
      selectedCategories: [],
      filteredProducts: [],
      selectedSort: "newest", // Add selectedSort property
      isLoading: true, // Add isLoading property
    };
  },
  methods: {
    async fetchAllProducts() {
      try {
        this.allProducts = await fetchAllProducts();
        this.filteredProducts = this.allProducts;
        this.sortProducts(); // Sort products after fetching
      } catch (error) {
        console.error(error);
      }
    },
    async fetchCategories() {
      try {
        const categories = await fetchCategories();
        // Fetch product count for each category
        for (const category of categories) {
          const products = await fetchProductsByCategory(category.id);
          category.productCount = products.length;
        }
        this.categories = categories;
      } catch (error) {
        console.error("Failed to fetch categories:", error);
      }
    },
    async fetchProductsByCategory() {
      try {
        if (this.selectedCategories.length === 0) {
          this.filteredProducts = this.allProducts;
        } else {
          const promises = this.selectedCategories.map((categoryId) =>
            fetchProductsByCategory(categoryId)
          );
          const results = await Promise.all(promises);
          this.filteredProducts = results.flat();
        }
        this.sortProducts(); // Sort products after filtering
      } catch (error) {
        console.error("Failed to fetch products by category:", error);
      }
    },
    filterProducts() {
      const searchQuery = this.$route.query.search?.toLowerCase() || "";
      this.filteredProducts = this.allProducts.filter((product) =>
        product.name.toLowerCase().includes(searchQuery)
      );
      this.sortProducts();
    },
    sortProducts() {
      if (this.selectedSort === "newest") {
        this.filteredProducts.sort(
          (a, b) => new Date(b.created_at) - new Date(a.created_at)
        );
      } else if (this.selectedSort === "lowest") {
        this.filteredProducts.sort((a, b) => a.price - b.price);
      } else if (this.selectedSort === "highest") {
        this.filteredProducts.sort((a, b) => b.price - a.price);
      }
    },
  },
  watch: {
    "$route.query.search": "filterProducts",
    selectedCategories() {
      this.fetchProductsByCategory();
      this.filterProducts();
    },
  },
  async created() {
    await this.fetchAllProducts();
    await this.fetchCategories();
    const categoryId = this.$route.query.category;
    if (categoryId) {
      this.selectedCategories = [parseInt(categoryId)];
      await this.fetchProductsByCategory();
    }
    this.filterProducts();
    this.isLoading = false;
  },
};
</script>

<style>
/* Add your styles here */
</style>