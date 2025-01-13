<template>
  <!-- Header -->
  <header>
    <div id="top-header">
      <div class="container">
        <ul class="header-links pull-left">
          <li>
            <a href="#"><i class="fa fa-phone"></i>+62-21-1234-5678</a>
          </li>
          <li>
            <a href="#"><i class="fa fa-envelope-o"></i>ardhicom@toko-gaming.com</a>
          </li>
          <li>
            <a href="#"><i class="fa fa-map-marker"></i>Jl. Ardhicom No. 123, Bandung</a>
          </li>
        </ul>
      </div>
    </div>
    <div id="header">
      <div class="container">
        <div class="row">
          <div class="col-md-3">
            <div class="header-logo">
              <router-link to="/" class="logo">
                <img src="@/assets/img/ardhicomlogo.png" alt="" />
              </router-link>
            </div>
          </div>
          <div class="col-md-5">
            <div class="header-search">
              <form @submit.prevent="onSearch">
                <input v-model="searchQuery" class="input" placeholder="Cari Disini" />
                <button class="search-btn">Cari</button>
              </form>
            </div>
          </div>
          <div class="col-md-4 clearfix">
            <div class="header-ctn button-container">
              <!-- Wishlist Dropdown -->
              <div class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                  <i class="fa fa-heart-o"></i>
                  <span>Wishlist</span>
                  <div v-if="state.isAuthenticated" class="qty">
                    {{ wishlistCount }}
                  </div>
                </a>
                <div class="cart-dropdown">
                  <div class="cart-items">
                    <div v-for="product in state.wishlistProducts" :key="product.product.id" class="product-widget">
                      <div class="product-img">
                        <img :src="
                            require('@/assets/img/' + product.product.image_url)
                          " :alt="product.product.name" />
                      </div>
                      <div class="product-body">
                        <h3 class="product-name">
                          <router-link :to="{ path: `/product/${product.product.id}` }">
                            {{ product.product.name }}
                          </router-link>
                        </h3>
                        <h4 class="product-price">
                          {{ formatPrice(product.product.price) }}
                        </h4>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Order History -->
              <div class="dropdown">
                <router-link to="/user/order-history" class="nav-link">
                  <i class="fa fa-history"></i>
                  <span>Riwayat Pesanan</span>
                </router-link>
              </div>
              <div class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                  <i class="fa fa-shopping-cart"></i>
                  <span>Keranjang</span>
                  <div v-if="state.isAuthenticated" class="qty">
                    {{ quantityTotal }}
                  </div>
                </a>
                <div class="cart-dropdown">
                  <div class="cart-items">
                    <div v-for="product in state.cartProducts" :key="product.product.id" class="product-widget">
                      <div class="product-img">
                        <img :src="
                            require('@/assets/img/' + product.product.image_url)
                          " :alt="product.product.name" />
                      </div>
                      <div class="product-body">
                        <h3 class="product-name">
                          <router-link :to="{ path: `/product/${product.product.id}` }">
                            {{ product.product.name }}
                          </router-link>
                        </h3>
                        <h4 class="product-price">
                          <span class="qty">{{ product.quantity }}x</span>
                          {{ formatPrice(product.product.price) }}
                        </h4>
                      </div>
                    </div>
                  </div>
                  <div class="cart-btns">
                    <router-link to="/cart">Lihat Keranjang</router-link>
                  </div>
                </div>
              </div>
              <div v-if="state.isAuthenticated">
                <router-link to="/user/profile" class="nav-link">
                  <i class="fa fa-user-o"></i>
                  <span>Akun</span>
                </router-link>
              </div>
              <div v-else>
                <router-link to="/login">
                  <button class="btn-login">Login</button>
                </router-link>
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
</template>

<script>
// import { login, fetchCarts } from "@/api/api";
import { onMounted, computed } from "vue";
import { useGlobalState } from "@/globalState";

export default {
  data() {
    return {
      searchQuery: "",
      cartDropdown: false,
      allProducts: [],
      loadingCart: true,
      userInfo: null,
    };
  },

  setup() {
    const { state, logout, fetchCarts, removeFromCart, fetchWishlist } =
      useGlobalState();

    onMounted(async () => {
      if (state.userInfo) {
        await fetchWishlist(
          state.userInfo.user_id,
          state.userInfo.access_token
        );
        await fetchCarts(state.userInfo.user_id, state.userInfo.access_token);
      }
    });

    const quantityTotal = computed(() => {
      return state.cartProducts.reduce((total, product) => {
        return total + product.quantity;
      }, 0);
    });

    const cartTotal = computed(() => {
      return state.cartProducts.reduce((total, product) => {
        return total + product.product.price * product.quantity;
      }, 0);
    });

    const formattedCartTotal = computed(() => {
      return new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
      }).format(cartTotal.value);
    });

    const wishlistCount = computed(() => {
      return state.wishlistProducts.reduce((total) => {
        return total + 1;
      }, 0);
    });

    const formatPrice = (price) => {
      return new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
      })
        .format(price)
        .replace(/\s/g, "");
    };

    return {
      state,
      logout,
      quantityTotal,
      formattedCartTotal,
      removeFromCart,
      wishlistCount,
      formatPrice,
    };
  },

  methods: {
    onSearch() {
      if (this.searchQuery.trim()) {
        this.$router.push({
          name: "store",
          query: { search: this.searchQuery },
        });
      }
    },
  },
  watch: {
    searchQuery(newSearch) {
      if (this.$route.name === "store") {
        if (newSearch.trim()) {
          this.$router.push({
            name: "store",
            query: { search: newSearch },
          });
        } else {
          this.$router.push({
            name: "store",
            query: {},
          });
        }
      }
    },
    "$route.query.search"(newSearch) {
      this.searchQuery = newSearch || "";
    },
  },
  created() {
    this.searchQuery = this.$route.query.search || "";
  },
};
</script>


<style scoped>
.cart-items {
  max-height: 200px; /* Adjust the height as needed */
  overflow-y: auto;
}

.btn-login {
  background-color: rgb(222, 14, 14);
  color: white;
  font-size: 12px;
  border: none;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
}

.btn-login {
  padding: 1em 2em;
  font-size: 12px;
  font-weight: 500;
  color: #000;
  background-color: #fff;
  /* border: none; */
  border: solid 1px #e3e3e3cb;
  width: 100%;
  position: relative;
  border-radius: 4px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
  outline: none;
}

.btn-login:hover {
  /* background-color: #0056b3; */
  background-color: rgb(196, 2, 50);
  box-shadow: 0px 15px 20px rgba(181, 0, 42, 0.57);
  color: #fff;
  transform: translateY(-7px);
}

.btn-login:active {
  transform: translateY(-1px);
}

.button-container {
  display: flex;
}

.product-widget {
  display: flex;
  align-items: center;
  padding: 10px;
  border-bottom: 1px solid #ddd;
}

.product-img img {
  width: 50px;
  height: 50px;
}

.product-body {
  flex-grow: 1;
  margin-left: 10px;
}

.product-name {
  font-size: 14px;
  margin: 0;
}

.product-price {
  font-size: 14px;
  color: #888;
}

.delete {
  background: none;
  border: none;
  cursor: pointer;
  color: #ff4d4d;
}

.cart-summary {
  padding: 10px;
  border-top: 1px solid #ddd;
}

.cart-btns {
  display: flex;
  justify-content: space-between;
  padding: 10px;
  border-top: 1px solid #ddd;
}

.cart-btns a {
  color: rgb(255, 255, 255);
  text-decoration: none;
}

.cart-btns a:hover {
  text-decoration: underline;
}
</style>

{% comment %} btn btn-primary {% endcomment %}