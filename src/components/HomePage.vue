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
        <SectionTitle title="Category" />

        <!-- shop items -->
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
        <!-- /shop items -->
      </div>
      <!-- /row -->
    </div>
    <!-- /container -->
  </div>
  <!-- /SECTION -->

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
        <!-- section title -->
        <SectionTitle title="New Products" />
        <!-- /section title -->
        <div class="col-md-12">
          <div class="row">
            <div class="products-tabs">
              <!-- tab -->
              <div id="tab1" class="tab-pane active">
                <div class="products-slick" data-nav="#slick-nav-1">
                  <!-- products -->

                  <ProductItem
                    v-for="product in allProducts"
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
                  />
                  <!-- /products -->
                </div>
                <div id="slick-nav-1" class="products-slick-nav"></div>
              </div>
              <!-- /tab -->
            </div>
          </div>
        </div>
        <!-- Products tab & slick -->
      </div>
      <!-- /row -->
    </div>
    <!-- /container -->
  </div>
  <!-- /SECTION -->

  <!-- HOT DEAL SECTION -->
  <div id="hot-deal" class="section">
    <!-- container -->
    <div class="container">
      <!-- row -->
      <div class="row">
        <div class="col-md-12">
          <div class="hot-deal">
            <ul class="hot-deal-countdown">
              <li>
                <div>
                  <h3>02</h3>
                  <span>Days</span>
                </div>
              </li>
              <li>
                <div>
                  <h3>10</h3>
                  <span>Hours</span>
                </div>
              </li>
              <li>
                <div>
                  <h3>34</h3>
                  <span>Mins</span>
                </div>
              </li>
              <li>
                <div>
                  <h3>60</h3>
                  <span>Secs</span>
                </div>
              </li>
            </ul>
            <h2 class="text-uppercase">hot deal this week</h2>
            <p>New Collection Up to 50% OFF</p>
            <a class="primary-btn cta-btn" href="#">Shop now</a>
          </div>
        </div>
      </div>
      <!-- /row -->
    </div>
    <!-- /container -->
  </div>
  <!-- /HOT DEAL SECTION -->

  <!-- SECTION -->
  <div class="section">
    <!-- container -->
    <div class="container">
      <!-- row -->
      <div class="row">
        <!-- section title -->
        <SectionTitle title="Top selling" />
        <!-- /section title -->

        <!-- Products tab & slick -->
        <div class="col-md-12">
          <div class="row">
            <div class="products-tabs">
              <!-- tab -->
              <div id="tab2" class="tab-pane fade in active">
                <div class="products-slick" data-nav="#slick-nav-2">
                  <!-- products -->
                  <ProductItem
                    v-for="product in allProducts"
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
                  />
                  <!-- /products -->
                </div>
                <div id="slick-nav-2" class="products-slick-nav"></div>
              </div>
              <!-- /tab -->
            </div>
          </div>
        </div>
        <!-- /Products tab & slick -->
      </div>
      <!-- /row -->
    </div>
    <!-- /container -->
  </div>
  <!-- /SECTION -->

  <!-- SECTION -->
  <!-- <div class="section">
   
    <div class="container">
     
      <div class="row">
        <div class="col-md-4 col-xs-6">
          <div class="section-title">
            <h4 class="title">Top selling</h4>
            <div class="section-nav">
              <div id="slick-nav-3" class="products-slick-nav"></div>
            </div>
          </div>

          <div class="products-widget-slick" data-nav="#slick-nav-3">
            <div>
            
              <ProductWidget
                v-for="(widget, index) in new_products"
                :key="index"
                :imgSrc="widget.imgSrc"
                :imgAlt="widget.imgAlt"
                :category="widget.category"
                :productName="widget.productName"
                :productLink="widget.productLink"
                :productPrice="widget.productPrice"
                :oldPrice="widget.oldPrice"
              />
      
            </div>

            <div>
            
              <ProductWidget
                v-for="(widget, index) in new_products"
                :key="index"
                :imgSrc="widget.imgSrc"
                :imgAlt="widget.imgAlt"
                :category="widget.category"
                :productName="widget.productName"
                :productLink="widget.productLink"
                :productPrice="widget.productPrice"
                :oldPrice="widget.oldPrice"
              />
  
            </div>
          </div>
        </div>

        <div class="col-md-4 col-xs-6">
          <div class="section-title">
            <h4 class="title">Top selling</h4>
            <div class="section-nav">
              <div id="slick-nav-4" class="products-slick-nav"></div>
            </div>
          </div>

          <div class="products-widget-slick" data-nav="#slick-nav-4">
            <div>

              <ProductWidget
                v-for="(widget, index) in new_products"
                :key="index"
                :imgSrc="widget.imgSrc"
                :imgAlt="widget.imgAlt"
                :category="widget.category"
                :productName="widget.productName"
                :productLink="widget.productLink"
                :productPrice="widget.productPrice"
                :oldPrice="widget.oldPrice"
              />
   
            </div>

            <div>

              <ProductWidget
                v-for="(widget, index) in new_products"
                :key="index"
                :imgSrc="widget.imgSrc"
                :imgAlt="widget.imgAlt"
                :category="widget.category"
                :productName="widget.productName"
                :productLink="widget.productLink"
                :productPrice="widget.productPrice"
                :oldPrice="widget.oldPrice"
              />

            </div>
          </div>
        </div>

        <div class="clearfix visible-sm visible-xs"></div>

        <div class="col-md-4 col-xs-6">
          <div class="section-title">
            <h4 class="title">Top selling</h4>
            <div class="section-nav">
              <div id="slick-nav-5" class="products-slick-nav"></div>
            </div>
          </div>

          <div class="products-widget-slick" data-nav="#slick-nav-5">
            <div>

              <ProductWidget
                v-for="(widget, index) in new_products"
                :key="index"
                :imgSrc="widget.imgSrc"
                :imgAlt="widget.imgAlt"
                :category="widget.category"
                :productName="widget.productName"
                :productLink="widget.productLink"
                :productPrice="widget.productPrice"
                :oldPrice="widget.oldPrice"
              />
     
            </div>

            <div>

              <ProductWidget
                v-for="(widget, index) in new_products"
                :key="index"
                :imgSrc="widget.imgSrc"
                :imgAlt="widget.imgAlt"
                :category="widget.category"
                :productName="widget.productName"
                :productLink="widget.productLink"
                :productPrice="widget.productPrice"
                :oldPrice="widget.oldPrice"
              />

            </div>
          </div>
        </div>
      </div>

    </div>

  </div> -->
  <!-- /SECTION -->

  <!-- NEWSLETTER -->
  <!-- <div id="newsletter" class="section">
   
    <div class="container">
 
      <div class="row">
        <div class="col-md-12">
          <div class="newsletter">
            <p>Sign Up for the <strong>NEWSLETTER</strong></p>
            <form>
              <input
                class="input"
                type="email"
                placeholder="Enter Your Email"
              />
              <button class="newsletter-btn">
                <i class="fa fa-envelope"></i> Subscribe
              </button>
            </form>
            <ul class="newsletter-follow">
              <li>
                <a href="#"><i class="fa fa-facebook"></i></a>
              </li>
              <li>
                <a href="#"><i class="fa fa-twitter"></i></a>
              </li>
              <li>
                <a href="#"><i class="fa fa-instagram"></i></a>
              </li>
              <li>
                <a href="#"><i class="fa fa-pinterest"></i></a>
              </li>
            </ul>
          </div>
        </div>
      </div>
   
    </div>

  </div> -->
  <!-- /NEWSLETTER -->
</template>
  
  <script>
// import NavPage from "@/components/NavPage.vue";
// import BreadcrumbPage from "@/components/BreadCrumbPage.vue";
import CategoryItem from "@/components/shop_item/CategoryItem.vue";
import ProductItem from "@/components/shop_item/ProductItem.vue";
// import ProductWidget from "@/components/shop_item/ProductWidget.vue";
import SectionTitle from "@/components/filter/SectionTitle.vue";
import { fetchAllProducts, fetchCategories } from "@/api/api";
import "@/assets/css/loading.css"; // Impor file CSS

// import axios from "axios";

export default {
  name: "HomePage",
  components: {
    // NavPage,
    // BreadcrumbPage,
    CategoryItem,
    ProductItem,
    // ProductWidget,
    SectionTitle,
  },
  data() {
    return {
      allProducts: [],
      categories: [],
      loadingCart: true,
      isLoading: true,
      searchQuery: "",
      selectedCategory: "0",
      wishlistCount: 2,
      cartDropdown: false,
      cartProducts: [],
      userInfo: null,
      // cartProducts: [
      //   { id: 1, name: 'Product 1', quantity: 1, price: '$980.00', image: require('@/assets/img/product01.png') },
      //   { id: 2, name: 'Product 2', quantity: 3, price: '$980.00', image: require('@/assets/img/product02.png') },
      // ],
    };
  },
  methods: {
    async fetchAllProducts() {
      try {
        this.allProducts = await fetchAllProducts();
        console.log("jawa");
        console.log(this.allProducts);
      } catch (error) {
        console.error(error);
      } finally {
        this.loadingCart = false;
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
      return categoryImages[categoryName] || "default-cat.png"; // Gambar default jika kategori tidak ditemukan
    },
    navigateToStore(categoryId) {
      this.$router.push({ path: "/store", query: { category: categoryId } });
    },
    async fetchCategories() {
      try {
        // Fetch categories from API
        this.categories = await fetchCategories();
      } catch (error) {
        console.error("Failed to fetch categories:", error);
      } finally {
        this.isLoading = false;
      }
    },
  },
  async created() {
    await this.fetchAllProducts();

    try {
      const categories_api = await fetchCategories();
      this.categories = categories_api.map((category) => ({
        id: category.id,
        imgSrc: this.getCategoryImage(category.name), // Ganti dengan gambar default atau sesuai kebutuhan
        imgAlt: `${category.name} Gaming`,
        title: category.name,
        link: `/category/${category.id}`, // Sesuaikan dengan rute kategori Anda
      }));
    } catch (error) {
      console.error("Failed to fetch categories:", error);
    } finally {
      this.isLoading = false;
    }
  },
};

// export default {
//   components: {
//     // NavPage,
//     // BreadcrumbPage,
//     ShopItem,
//     ProductItem,
//     ProductWidget,
//     SectionTitle,
//   },
//   data() {
//     return {
//       searchQuery: "",
//       selectedCategory: "0",
//       wishlistCount: 2,
//       cartDropdown: false,
//       cartProducts: [],
//       allProducts: [],
//       loadingCart: true,
//       userInfo: null,
//       // cartProducts: [
//       //   { id: 1, name: 'Product 1', quantity: 1, price: '$980.00', image: require('@/assets/img/product01.png') },
//       //   { id: 2, name: 'Product 2', quantity: 3, price: '$980.00', image: require('@/assets/img/product02.png') },
//       // ],

//       categories: [
//         {
//           imgSrc: "shop03.png",
//           imgAlt: "Accessories Collection",
//           title: "Accessories",
//           subtitle: "Collection",
//           link: "#",
//         },
//         {
//           imgSrc: "shop02.png",
//           imgAlt: "Cameras Collection",
//           title: "Cameras",
//           subtitle: "Collection",
//           link: "#",
//         },
//         {
//           imgSrc: "shop01.png",
//           imgAlt: "Laptops Collection",
//           title: "Laptops",
//           subtitle: "Collection",
//           link: "#",
//         },
//       ],

//       new_products: [
//         {
//           imgSrc: "product01.png",
//           imgAlt: "Product Image",
//           saleLabel: "-30%",
//           newLabel: "NEW",
//           category: "Category",
//           productName: "product name goes here",
//           productLink: "#",
//           productPrice: "$980.00",
//           oldPrice: "$990.00",
//           rating: 5,
//         },
//         {
//           imgSrc: "product02.png",
//           imgAlt: "Product Image",
//           newLabel: "NEW",
//           category: "Category",
//           productName: "product name goes here",
//           productLink: "#",
//           productPrice: "$980.00",
//           oldPrice: "$990.00",
//           rating: 4,
//         },
//         {
//           imgSrc: "product03.png",
//           imgAlt: "Product Image",
//           saleLabel: "-30%",
//           category: "Category",
//           productName: "product name goes here",
//           productLink: "#",
//           productPrice: "$980.00",
//           oldPrice: "$990.00",
//           rating: 0,
//         },
//         {
//           imgSrc: "product04.png",
//           imgAlt: "Product Image",
//           category: "Category",
//           productName: "product name goes here",
//           productLink: "#",
//           productPrice: "$980.00",
//           oldPrice: "$990.00",
//           rating: 5,
//         },
//         {
//           imgSrc: "product05.png",
//           imgAlt: "Product Image",
//           category: "Category",
//           productName: "product name goes here",
//           productLink: "#",
//           productPrice: "$980.00",
//           oldPrice: "$990.00",
//           rating: 5,
//         },
//       ],
//     };
//   },
//   // watch: {
//   //   cartProducts: {
//   //     handler(newVal) {
//   //       console.log("Cart products updated:", newVal);
//   //     },
//   //     deep: true, // Ensures the watcher reacts to nested changes in the array
//   //     immediate: true, // Runs the watcher immediately on component mount
//   //   },
//   // },
//   computed: {
//     // quantityTotal() {
//     //   return this.cartProducts.reduce((total, product) => {
//     //     return total + product.quantity;
//     //   }, 0);
//     // },
//     // cartTotal() {
//     //   return this.cartProducts.reduce((total, product) => {
//     //     return total + product.product.price * product.quantity;
//     //   }, 0);
//     // },
//   },
//   async mounted() {
//     // await this.login();
//     await this.fetchAllProducts();

//     // if (this.userInfo != null) await this.fetchCarts();
//   },
//   methods: {
//     // onSearch() {
//     //   console.log(
//     //     `Searching for ${this.searchQuery} in category ${this.selectedCategory}`
//     //   );
//     // },
//     // toggleCartDropdown() {
//     //   this.cartDropdown = !this.cartDropdown;
//     // },
//     // removeFromCart(productId) {
//     //   this.cartProducts = this.cartProducts.filter(
//     //     (product) => product.product.id !== productId
//     //   );
//     // },
//     // async login() {
//     //   try {
//     //     const response = await axios.post("http://127.0.0.1:8000/login_email", {
//     //       email: "aryaxdm9604@gmail.com",
//     //       password: "inipassword",
//     //     });

//     //     this.userInfo = response.data;
//     //   } catch (error) {
//     //     console.error(error);
//     //   } finally {
//     //     this.loadingCart = false;
//     //   }
//     // },
//     // async fetchCarts() {
//     //   try {
//     //     const response = await axios.get("http://127.0.0.1:8000/get_cart/1", {
//     //       headers: {
//     //         Authorization: `Bearer ${this.userInfo.access_token}`,
//     //       },
//     //     });

//     //     this.cartProducts.push(...response.data);
//     //     console.log(this.cartProducts.product.name);
//     //   } catch (error) {
//     //     console.error(error);
//     //   } finally {
//     //     this.loadingCart = false;
//     //   }
//     // },
//     async fetchAllProducts() {
//       try {
//         const response = await axios.get("http://127.0.0.1:8000/get_products");

//         this.allProducts = response.data;
//       } catch (error) {
//         console.error(error);
//       } finally {
//         this.loadingCart = false;
//       }
//     },
//   },
// };
</script>
  
  <style scoped>
/* Include relevant styles */
</style>
  