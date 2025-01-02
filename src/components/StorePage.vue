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
            <h3 class="aside-title">Kategori</h3>
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
                Urutkan berdasarkan:
                <select
                  class="input-select"
                  v-model="selectedSort"
                  @change="sortProducts"
                >
                  <option value="newest">Terbaru</option>
                  <option value="lowest">Harga Terendah</option>
                  <option value="highest">Harga Tertinggi</option>
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
    <div class="row">
      <ProductItem
        v-for="product in paginatedProducts"
        :key="product.id"
        :id="product.id"
        :imgSrc="product.image_url || 'default-image.jpg'"
        :imgAlt="product.name"
        :category="product.category.name"
        :productName="product.name"
        :productLink="product.id"
        :productPrice="product.price"
        :addCartItemHandler="addCartItemHandler"
        :colClass="'col-md-3'"
      />
    </div>
    <div class="store-filter clearfix">
      <span class="store-qty">
        Tampilkan {{ startIndex + 1 }} - {{ endIndex }} Produk
      </span>
      <ul class="store-pagination">
        <li
          v-for="page in visiblePages"
          :key="page"
          :class="{ active: page === currentPage }"
        >
          <a href="#" @click.prevent="changePage(page)">{{ page }}</a>
        </li>
      </ul>
    </div>
  </div>
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
      selectedSort: "newest",
      filteredProducts: [],
      totalProducts: 0, // Total produk setelah filter
      itemsPerPage: 10, // Maksimum produk per halaman
      currentPage: 1, // Halaman saat ini
      isLoading: true, // Status loading
    };
  },
  computed: {
    paginatedProducts() {
      // Produk yang ditampilkan pada halaman tertentu
      const start = this.startIndex;
      const end = this.endIndex;
      return this.filteredProducts.slice(start, end);
    },
    totalPages() {
      return Math.ceil(this.totalProducts / this.itemsPerPage);
    },
    visiblePages() {
      return this.totalPages > 1
        ? Array.from({ length: this.totalPages }, (_, i) => i + 1)
        : [1];
    },
    startIndex() {
      return (this.currentPage - 1) * this.itemsPerPage;
    },
    endIndex() {
      return Math.min(this.startIndex + this.itemsPerPage, this.totalProducts);
    },
  },
  methods: {
    async fetchAllProducts() {
      try {
        this.allProducts = await fetchAllProducts();
        this.applyFilters();
      } catch (error) {
        console.error(error);
      }
    },
    async fetchCategories() {
  try {
    const categories = await fetchCategories();
    // Hitung jumlah produk untuk setiap kategori
    categories.forEach((category) => {
      category.productCount = this.allProducts.filter(
        (product) => product.category.id === category.id
      ).length;
    });
    this.categories = categories;
  } catch (error) {
    console.error("Failed to fetch categories:", error);
  }
},
    applyFilters() {
  const searchQuery = this.$route.query.search?.toLowerCase() || "";

  // Filter produk berdasarkan nama (search query)
  let products = this.allProducts.filter((product) =>
    product.name.toLowerCase().includes(searchQuery)
  );

  // Jika ada kategori yang dipilih, filter berdasarkan kategori
  if (this.selectedCategories.length > 0) {
    products = products.filter((product) =>
      this.selectedCategories.includes(product.category.id)
    );
  }

  // Perbarui filteredProducts dan totalProducts
  this.filteredProducts = products;
  this.totalProducts = products.length;

  // Terapkan pengurutan
  this.sortProducts();

  // Reset ke halaman pertama setiap kali filter berubah
  this.currentPage = 1;
},
    sortProducts() {
  if (this.filteredProducts.length === 0) return;

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
    changePage(page) {
      this.currentPage = page;
    },
  },
  watch: {
    "$route.query.search": "applyFilters",
    selectedCategories() {
      this.applyFilters();
    },
  },
  async created() {
  await this.fetchAllProducts();
  await this.fetchCategories();

  // Tangkap parameter kategori dari query dan terapkan
  const categoryFromQuery = this.$route.query.category;
  if (categoryFromQuery) {
    this.selectedCategories = Array.isArray(categoryFromQuery)
      ? categoryFromQuery.map(Number) // Jika query parameter berupa array
      : [Number(categoryFromQuery)]; // Jika query parameter berupa string tunggal
  }

  this.applyFilters();
  this.isLoading = false;
}
};
</script>


<style>
/* Add your styles here */
</style>