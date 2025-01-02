<template>
  <!-- SECTION -->
  <div class="section">
    <div class="container">
      <div class="row" v-if="isLoading">
        <div class="col-md-12 loading-container">
          <div class="spinner"></div>
        </div>
      </div>
      <div class="row" v-else>
        <SectionTitle title="Kategori" />
        <CategoryItem
          v-for="(category, index) in categories"
          :key="index"
          :imgSrc="category.imgSrc"
          :imgAlt="category.imgAlt"
          :title="category.title"
          :subtitle="category.subtitle"
          :link="category.link"
          @click="navigateToStore(category.id)"
        />
      </div>
    </div>
  </div>

  <!-- New Products Section -->
  <div class="section">
    <div class="container">
      <div class="row" v-if="isLoading">
        <div class="col-md-12 loading-container">
          <div class="spinner"></div>
        </div>
      </div>
      <div class="row" v-else>
        <SectionTitle title="Produk Terbaru" />
        <div class="col-md-12">
          <div class="row">
            <div class="products-tabs">
              <div id="tab1" class="tab-pane active">
                <div v-if="newProducts.length" class="products-slick" data-nav="#slick-nav-1">
                  <ProductItem
                    v-for="product in newProducts"
                    :key="product.id"
                    :id="product.id"
                    :imgSrc="product.image_url || 'default-image.jpg'"
                    :imgAlt="product.name"
                    :category="product.category.name"
                    :productName="product.name"
                    :productPrice="product.price"
                    :newLabel="'BARU'"
                  />
                </div>
                <div v-else class="no-products">
                  <p>No new products available at the moment.</p>
                </div>
                <div id="slick-nav-1" class="products-slick-nav"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Featured Products Section -->
  <div class="section featured-section">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="featured-header text-center">
            <h2>Perlengkapan Gaming Pilihan</h2>
            <p>Temukan Pilihan Premium Kami</p>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <div class="products-tabs">
            <div id="tab2" class="tab-pane fade in active">
              <div class="products-slick" data-nav="#slick-nav-2">
                <ProductItem
                  v-for="product in randomTopProducts"
                  :key="product.id"
                  :id="product.id"
                  :imgSrc="product.image_url || 'default-image.jpg'"
                  :imgAlt="product.name"
                  :category="product.category.name"
                  :productName="product.name"
                  :productPrice="product.price"
                  :newLabel="product.isNew ? 'NEW' : ''"
                />
              </div>
              <div id="slick-nav-2" class="products-slick-nav"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import CategoryItem from "@/components/shop_item/CategoryItem.vue";
import ProductItem from "@/components/shop_item/ProductItem.vue";
import SectionTitle from "@/components/filter/SectionTitle.vue";
import { fetchAllProducts, fetchCategories } from "@/api/api";
import "@/assets/css/loading.css";

export default {
  name: "HomePage",
  components: {
    CategoryItem,
    ProductItem,
    SectionTitle,
  },
  data() {
    return {
      allProducts: [],
      categories: [],
      isLoading: true,
    };
  },
  computed: {
  newProducts() {
    // Get 6 random products
    return this.allProducts
      .slice()
      .sort(() => Math.random() - 0.5) // Randomly sort the array
      .slice(0, 6) // Take the first 6 products
      .map(product => ({
        ...product,
        isNew: true // All products in this section are marked as new
      }));
  },
    randomTopProducts() {
      const shuffled = [...this.allProducts].sort(() => 0.5 - Math.random());
      return shuffled.slice(0, 6);
    }
  },
  methods: {
    getRandomProducts(count) {
      const shuffled = [...this.allProducts].sort(() => 0.5 - Math.random());
      const randomProducts = shuffled.slice(0, count);
      
      return randomProducts.map(product => ({
        ...product,
        isNew: Math.random() < 0.3 // 30% chance of being marked as new
      }));
    },
    async fetchAllProducts() {
      try {
        this.allProducts = await fetchAllProducts();
      } catch (error) {
        console.error(error);
      }
    },
    getCategoryImage(categoryName) {
      const categoryImages = {
        Headset: "headset-cat.png",
        Keyboard: "keyboard-cat.png",
        Mouse: "mouse-cat.png",
        Microphone: "microphone-cat.png",
        Gamepad: "gamepad-cat.png",
        Mousepad: "mousepad-cat.png",
      };
      return categoryImages[categoryName] || "default-cat.png";
    },
    navigateToStore(categoryId) {
      this.$router.push({ path: "/store", query: { category: categoryId } });
    },
    async fetchCategories() {
      try {
        const categories_api = await fetchCategories();
        this.categories = categories_api.map((category) => ({
          id: category.id,
          imgSrc: this.getCategoryImage(category.name),
          imgAlt: `${category.name} Gaming`,
          title: category.name,
          link: `/category/${category.id}`,
        }));
      } catch (error) {
        console.error("Failed to fetch categories:", error);
      } finally {
        this.isLoading = false;
      }
    },
  },
  async created() {
    await Promise.all([
      this.fetchAllProducts(),
      this.fetchCategories()
    ]);
  },
};
</script>

<style scoped>
.section {
  padding: 40px 0;
}

.featured-section {
  background-color: #f8f9fa;
}

.featured-header {
  margin-bottom: 40px;
}

.featured-header h2 {
  font-size: 32px;
  color: #2B2D42;
  margin-bottom: 10px;
}

.featured-header p {
  font-size: 18px;
  color: #8D99AE;
}

.products-tabs {
  margin-top: 20px;
}

.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 200px;
}

/* Animation for section transitions */
.section {
  animation: fadeIn 0.5s ease-in-out;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Hover effects for product cards */
.product:hover {
  transform: translateY(-5px);
  transition: transform 0.3s ease;
}
</style>