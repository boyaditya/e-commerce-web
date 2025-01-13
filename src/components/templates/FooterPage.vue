<template>
  <div>
    <footer id="footer">
      <!-- top footer -->
      <div class="section">
        <!-- container -->
        <div class="container">
          <!-- row -->
          <div class="row">
            <div class="col-md-4 col-xs-6">
              <div class="footer">
                <h3 class="footer-title">About Us</h3>
                <p>
                  Kami adalah toko yang menyediakan berbagai peripheral gaming berkualitas tinggi,
                  mulai dari keyboard, mouse, hingga headset untuk meningkatkan pengalaman bermain Anda.
                </p>
                <ul class="footer-links">
                  <li>
                    <a href="#"><i class="fa fa-map-marker"></i>Jl. Ardhicom No. 123, Bandung</a>
                  </li>
                  <li>
                    <a href="#"><i class="fa fa-phone"></i>+62-21-1234-5678</a>
                  </li>
                  <li>
                    <a href="#"><i class="fa fa-envelope-o"></i>ardhicom@toko-gaming.com</a>
                  </li>
                </ul>
              </div>
            </div>

            <div class="col-md-4 col-xs-6">
              <div class="footer">
                <h3 class="footer-title">Kategori</h3>
                <ul class="footer-links">
                  <!-- Render categories dynamically based on the fetched data -->
                  <li v-for="(category) in categories" :key="category.id" @click="navigateToStore(category.id)">
                    <a :href="category.link">
                      {{ category.title }}
                    </a>
                  </li>
                </ul>
              </div>
            </div>

            <div class="clearfix visible-xs"></div>

            <div class="col-md-4 col-xs-6">
              <div class="footer">
                <h3 class="footer-title">Layanan</h3>
                <ul class="footer-links">
                  <!-- Using router-link for Layanan -->
                  <li><router-link to="/user/profile">Akun</router-link></li>
                  <li><router-link to="/cart">Keranjang</router-link></li>
                  <li><router-link to="/wishlist">Wishlist</router-link></li>
                  <li><router-link to="/user/order-history">Riwayat Pesanan</router-link></li>
                </ul>
              </div>
            </div>
          </div>
          <!-- /row -->
        </div>
        <!-- /container -->
      </div>
      <!-- /top footer -->

      <!-- bottom footer -->
      <div id="bottom-footer" class="section">
        <div class="container">
          <!-- row -->
          <div class="row">
            <div class="col-md-12 text-center">
              <span class="copyright">
                Copyright &copy; 2024 All rights reserved | This template is made with <i class="fa fa-heart-o"
                  aria-hidden="true"></i> by
                <a href="https://colorlib.com" target="_blank">Colorlib</a>
              </span>
            </div>
          </div>
          <!-- /row -->
        </div>
        <!-- /container -->
      </div>
      <!-- /bottom footer -->
    </footer>
    <!-- /FOOTER -->
  </div>
</template>

<script>
import { fetchCategories } from "@/api/api"; // Import the fetchCategories API method

export default {
  name: "FooterPage",
  data() {
    return {
      categories: [], // To hold the fetched categories
      isLoading: true, // To show loading state while fetching data
    };
  },
  methods: {
    async fetchCategories() {
      try {
        // Fetch categories from API
        const categoriesData = await fetchCategories();
        // Format categories as required for the footer
        this.categories = categoriesData.map(category => ({
          id: category.id,
          title: category.name, // Assuming the API provides a 'name' field
          imgSrc: category.image || "default-category.jpg", // Use category image or default
          imgAlt: `${category.name} Image`, // Alt text for image
          link: `/store?category=${category.id}`, // Use query parameter for category
        }));
      } catch (error) {
        console.error("Failed to fetch categories:", error);
      } finally {
        this.isLoading = false;
      }
    },
    navigateToStore(categoryId) {
      // Navigate to the category store using query params
      this.$router.push({ path: "/store", query: { category: categoryId } });
    },
  },
  async created() {
    await this.fetchCategories(); // Fetch categories when the component is created
  },
};
</script>

<style scoped>
/* Add any scoped CSS here */
</style>
