<template>
  <!-- SECTION -->
  <div class="section">
    <!-- container -->
    <div class="container">
      <!-- row -->
      <div class="row">
        <!-- shop items -->
        <ShopItem
          v-for="(shop, index) in shops"
          :key="index"
          :imgSrc="shop.imgSrc"
          :imgAlt="shop.imgAlt"
          :title="shop.title"
          :subtitle="shop.subtitle"
          :link="shop.link"
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
      <div class="row">
        <!-- section title -->
        <SectionTitle
          title="New Products"
          :tabs="[
            { label: 'Laptops', href: '#tab1', active: true },
            { label: 'Smartphones', href: '#tab1', active: false },
            { label: 'Cameras', href: '#tab1', active: false },
            { label: 'Accessories', href: '#tab1', active: false },
          ]"
        />
        <!-- /section title -->

        <!-- Products tab & slick -->
        <!-- <div class="col-md-12">
          <div class="row">
            <div class="products-tabs">
              <div id="tab1" class="tab-pane active">
                <div class="products-slick" data-nav="#slick-nav-1">
                  <div
                    v-for="product in allProducts"
                    :key="product.id"
                    class="product"
                  >
                    <div class="product-img">
                      <img :src="product.image_url" :alt="product.name" />
                      <div class="product-label">
                        <span class="sale">-30%</span>
                        <span class="new">NEW</span>
                      </div>
                    </div>
                    <div class="product-body">
                      <p class="product-category">
                        {{ product.category.name }}
                      </p>
                      <h3 class="product-name">
                        <a href="#">{{ product.name }}</a>
                      </h3>
                      <h4 class="product-price">
                        Rp{{ product.price }}
                        <del class="product-old-price"
                          >Rp{{ product.price - 50000 }}</del
                        >
                      </h4>
                      <div class="product-rating">
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
                        <i class="fa fa-star"></i>
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
                        <button class="quick-view">
                          <i class="fa fa-eye"></i
                          ><span class="tooltipp">quick view</span>
                        </button>
                      </div>
                    </div>
                    <div class="add-to-cart">
                      <button
                        @click="addCartItemHandler(product.id, 1)"
                        class="add-to-cart-btn"
                      >
                        <i class="fa fa-shopping-cart"></i> add to cart
                      </button>
                    </div>
                  </div>
                </div>
                <div id="slick-nav-1" class="products-slick-nav"></div>
              </div>
            </div>
          </div>
        </div> -->

        <div class="col-md-12">
          <div class="row">
            <div class="products-tabs">
              <!-- tab -->
              <div id="tab1" class="tab-pane active">
                <div class="products-slick" data-nav="#slick-nav-1">
                  <!-- products -->
                  <ProductItem
                    v-for="product in new_products"
                    :key="product.id"
                    :imgSrc="product.imgSrc"
                    :imgAlt="product.productName"
                    :saleLabel="'-30%'"
                    :newLabel="'NEW'"
                    :category="product.category"
                    :productName="product.productName"
                    :productLink="product.productLink"
                    :productPrice="product.productPrice"
                    :oldPrice="product.oldPrice"
                    :addCartItemHandler="addCartItemHandler"
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
        <SectionTitle
          title="Top selling"
          :tabs="[
            { label: 'Laptops', href: '#tab2', active: true },
            { label: 'Smartphones', href: '#tab2', active: false },
            { label: 'Cameras', href: '#tab2', active: false },
            { label: 'Accessories', href: '#tab2', active: false },
          ]"
        />
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
                    v-for="product in new_products"
                    :key="product.id"
                    :imgSrc="product.imgSrc"
                    :imgAlt="product.productName"
                    :saleLabel="'-20%'"
                    :category="product.category"
                    :productName="product.productName"
                    :productLink="product.productLink"
                    :productPrice="product.productPrice"
                    :oldPrice="product.oldPrice"
                    :addCartItemHandler="addCartItemHandler"
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
  <div class="section">
    <!-- container -->
    <div class="container">
      <!-- row -->
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
              <!-- product widgets -->
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
              <!-- /product widgets -->
            </div>

            <div>
              <!-- product widgets -->
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
              <!-- /product widgets -->
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
              <!-- product widgets -->
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
              <!-- /product widgets -->
            </div>

            <div>
              <!-- product widgets -->
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
              <!-- /product widgets -->
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
              <!-- product widgets -->
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
              <!-- /product widgets -->
            </div>

            <div>
              <!-- product widgets -->
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
              <!-- /product widgets -->
            </div>
          </div>
        </div>
      </div>
      <!-- /row -->
    </div>
    <!-- /container -->
  </div>
  <!-- /SECTION -->

  <!-- NEWSLETTER -->
  <div id="newsletter" class="section">
    <!-- container -->
    <div class="container">
      <!-- row -->
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
      <!-- /row -->
    </div>
    <!-- /container -->
  </div>
  <!-- /NEWSLETTER -->
</template>
  
  <script>
// import NavPage from "@/components/NavPage.vue";
// import BreadcrumbPage from "@/components/BreadCrumbPage.vue";
import ShopItem from "@/components/shop_item/ShopItem.vue";
import ProductItem from "@/components/shop_item/ProductItem.vue";
import ProductWidget from "@/components/shop_item/ProductWidget.vue";
import SectionTitle from "@/components/filter/SectionTitle.vue";

import axios from "axios";

export default {
  components: {
    // NavPage,
    // BreadcrumbPage,
    ShopItem,
    ProductItem,
    ProductWidget,
    SectionTitle,
  },
  data() {
    return {
      searchQuery: "",
      selectedCategory: "0",
      wishlistCount: 2,
      cartDropdown: false,
      cartProducts: [],
      allProducts: [],
      loadingCart: true,
      userInfo: null,
      // cartProducts: [
      //   { id: 1, name: 'Product 1', quantity: 1, price: '$980.00', image: require('@/assets/img/product01.png') },
      //   { id: 2, name: 'Product 2', quantity: 3, price: '$980.00', image: require('@/assets/img/product02.png') },
      // ],

      shops: [
        {
          imgSrc: "shop03.png",
          imgAlt: "Accessories Collection",
          title: "Accessories",
          subtitle: "Collection",
          link: "#",
        },
        {
          imgSrc: "shop02.png",
          imgAlt: "Cameras Collection",
          title: "Cameras",
          subtitle: "Collection",
          link: "#",
        },
        {
          imgSrc: "shop01.png",
          imgAlt: "Laptops Collection",
          title: "Laptops",
          subtitle: "Collection",
          link: "#",
        },
      ],

      new_products: [
        {
          imgSrc: "product01.png",
          imgAlt: "Product Image",
          saleLabel: "-30%",
          newLabel: "NEW",
          category: "Category",
          productName: "product name goes here",
          productLink: "#",
          productPrice: "$980.00",
          oldPrice: "$990.00",
          rating: 5,
        },
        {
          imgSrc: "product02.png",
          imgAlt: "Product Image",
          newLabel: "NEW",
          category: "Category",
          productName: "product name goes here",
          productLink: "#",
          productPrice: "$980.00",
          oldPrice: "$990.00",
          rating: 4,
        },
        {
          imgSrc: "product03.png",
          imgAlt: "Product Image",
          saleLabel: "-30%",
          category: "Category",
          productName: "product name goes here",
          productLink: "#",
          productPrice: "$980.00",
          oldPrice: "$990.00",
          rating: 0,
        },
        {
          imgSrc: "product04.png",
          imgAlt: "Product Image",
          category: "Category",
          productName: "product name goes here",
          productLink: "#",
          productPrice: "$980.00",
          oldPrice: "$990.00",
          rating: 5,
        },
        {
          imgSrc: "product05.png",
          imgAlt: "Product Image",
          category: "Category",
          productName: "product name goes here",
          productLink: "#",
          productPrice: "$980.00",
          oldPrice: "$990.00",
          rating: 5,
        },
      ],
    };
  },
  // watch: {
  //   cartProducts: {
  //     handler(newVal) {
  //       console.log("Cart products updated:", newVal);
  //     },
  //     deep: true, // Ensures the watcher reacts to nested changes in the array
  //     immediate: true, // Runs the watcher immediately on component mount
  //   },
  // },
  computed: {
    // quantityTotal() {
    //   return this.cartProducts.reduce((total, product) => {
    //     return total + product.quantity;
    //   }, 0);
    // },
    // cartTotal() {
    //   return this.cartProducts.reduce((total, product) => {
    //     return total + product.product.price * product.quantity;
    //   }, 0);
    // },
  },
  async mounted() {
    // await this.login();
    await this.fetchAllProducts();

    // if (this.userInfo != null) await this.fetchCarts();
  },
  methods: {
    // onSearch() {
    //   console.log(
    //     `Searching for ${this.searchQuery} in category ${this.selectedCategory}`
    //   );
    // },
    // toggleCartDropdown() {
    //   this.cartDropdown = !this.cartDropdown;
    // },
    // removeFromCart(productId) {
    //   this.cartProducts = this.cartProducts.filter(
    //     (product) => product.product.id !== productId
    //   );
    // },
    // async login() {
    //   try {
    //     const response = await axios.post("http://127.0.0.1:8000/login_email", {
    //       email: "aryaxdm9604@gmail.com",
    //       password: "inipassword",
    //     });

    //     this.userInfo = response.data;
    //   } catch (error) {
    //     console.error(error);
    //   } finally {
    //     this.loadingCart = false;
    //   }
    // },
    // async fetchCarts() {
    //   try {
    //     const response = await axios.get("http://127.0.0.1:8000/get_cart/1", {
    //       headers: {
    //         Authorization: `Bearer ${this.userInfo.access_token}`,
    //       },
    //     });

    //     this.cartProducts.push(...response.data);
    //     console.log(this.cartProducts.product.name);
    //   } catch (error) {
    //     console.error(error);
    //   } finally {
    //     this.loadingCart = false;
    //   }
    // },
    async fetchAllProducts() {
      try {
        const response = await axios.get("http://127.0.0.1:8000/get_products");

        this.allProducts = response.data;
      } catch (error) {
        console.error(error);
      } finally {
        this.loadingCart = false;
      }
    },
  },
};
</script>
  
  <style scoped>
/* Include relevant styles */
</style>
  