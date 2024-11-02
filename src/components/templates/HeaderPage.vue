<template>
    <!-- Header -->
    <header>
      <div id="top-header">
        <div class="container">
          <ul class="header-links pull-left">
            <li><a href="#"><i class="fa fa-phone"></i> +62 123 456 78</a></li>
            <li><a href="#"><i class="fa fa-envelope-o"></i> ardhicom@email.com</a></li>
            <li><a href="#"><i class="fa fa-map-marker"></i> 123 jalan jalan </a></li>
          </ul>
          <ul class="header-links pull-right">
            <li><a href="#"><i class="fa fa-dollar"></i> Rp</a></li>
            <li><a href="#"><i class="fa fa-user-o"></i> My Account</a></li>
          </ul>
        </div>
      </div>
      <div id="header">
        <div class="container">
          <div class="row">
            <div class="col-md-3">
              <div class="header-logo">
                <router-link to="/" class="logo">
                  <img src="@/assets/img/ardhicomlogo.png" alt="">
                </router-link>
              </div>
            </div>
            <div class="col-md-6">
              <div class="header-search">
                <form @submit.prevent="onSearch">
                  <select class="input-select" v-model="selectedCategory">
                    <option value="0">All Categories</option>
                    <option value="1">Category 01</option>
                    <option value="2">Category 02</option>
                  </select>
                  <input v-model="searchQuery" class="input" placeholder="Search here">
                  <button class="search-btn">Search</button>
                </form>
              </div>
            </div>
            <div class="col-md-3 clearfix">
              <div class="header-ctn">
                <div>
                  <a href="#">
                    <i class="fa fa-heart-o"></i>
                    <span>Your Wishlist</span>
                    <div class="qty">{{ wishlistCount }}</div>
                  </a>
                </div>
                <div class="dropdown">
                <a
                  class="dropdown-toggle"
                  data-toggle="dropdown"
                  aria-expanded="true"
                >
                    <i class="fa fa-shopping-cart"></i>
                    <span>Your Cart</span>
                    <div class="qty">{{ quantityTotal }}</div>
                  </a>
                  <div class="cart-dropdown" >
                    <div v-for="product in cartProducts" :key="product.product.id" class="product-widget">
                      <div class="product-img">
                        <img :src="product.product.image_url" :alt="product.product.name">
                      </div>
                      <div class="product-body">
                        <h3 class="product-name"><a href="#">{{ product.product.name }}</a></h3>
                        <h4 class="product-price"><span class="qty">{{ product.quantity }}x</span> {{ product.product.price }}</h4>
                      </div>
                      <button @click="removeFromCart(product.product.id)" class="delete"><i class="fa fa-close"></i></button>
                    </div>
                    <div class="cart-summary">
                      <small>{{ quantityTotal }} Item(s) selected</small>
                      <h5>SUBTOTAL: {{ cartTotal }}</h5>
                    </div>
                    <div class="cart-btns">
                      <a href="#">View Cart</a>
                      <router-link to="/checkout">Checkout <i class="fa fa-arrow-circle-right"></i></router-link>
                    </div>
                  </div>
                </div>
                <div class="menu-toggle">
                  <a href="#">
                    <i class="fa fa-bars"></i>
                    <span>Menu</span>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </header>
    <!-- Navigation -->
    <nav id="navigation">
      <div class="container">
        <div id="responsive-nav">
          <ul class="main-nav nav navbar-nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#">Hot Deals</a></li>
            <li><a href="#">Categories</a></li>
            <li><a href="#">Laptops</a></li>
            <li><a href="#">Smartphones</a></li>
            <li><a href="#">Cameras</a></li>
            <li><a href="#">Accessories</a></li>
          </ul>
        </div>
      </div>
    </nav>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      searchQuery: '',
      selectedCategory: '0',
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
    };
  },
  computed: {
    quantityTotal() {
      return this.cartProducts.reduce((total, product) => {
        return total + product.quantity;
      }, 0);
    },
    cartTotal() {
      return this.cartProducts.reduce((total, product) => {
        return total + product.product.price * product.quantity;
      }, 0);
    }
  },
  async mounted() {
    await this.login();

    if(this.userInfo != null)
      await this.fetchCarts();
  },
  methods: {
    onSearch() {
      console.log(`Searching for ${this.searchQuery} in category ${this.selectedCategory}`);
    },
    // toggleCartDropdown() {
    //   this.cartDropdown = !this.cartDropdown;
    // },
    removeFromCart(productId) {
      this.cartProducts = this.cartProducts.filter(product => product.product.id !== productId);
    },
    async login() {
      try{
        const response = await axios.post(
          'http://127.0.0.1:8000/login_email',
          {
            'email': 'aryaxdm9604@gmail.com',
            'password': 'inipassword'
          }
        );
        
        this.userInfo = response.data;
      } catch (error) {
        console.error(error);
      } finally {
        this.loadingCart = false;
      }
    },
    async fetchCarts() {
      try{
        const response = await axios.get(
          'http://127.0.0.1:8000/get_cart/1',
          {
            headers: {
              'Authorization': `Bearer ${this.userInfo.access_token}`
            }
          }
        );

        this.cartProducts.push(...response.data);
        console.log(this.cartProducts.product.name);
      } catch (error) {
        console.error(error);
      } finally {
        this.loadingCart = false;
      }
    }
  }
};
</script>

<style scoped>
/* Include relevant styles */
</style>
