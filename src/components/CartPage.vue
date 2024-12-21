<template>
  <div id="breadcrumb" class="section">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h3 class="breadcrumb-header">Keranjang Belanja</h3>
        </div>
      </div>
    </div>
  </div>

  <div class="section">
    <div class="container">
      <div class="row">
        <div class="col-md-8">
          <div class="caption">
            <div class="cart-items">
              <CartItem
                v-for="item in cartItems"
                :key="item.id"
                :name="item.name"
                :price="item.price"
                :quantity="item.quantity"
                :imgSrc="item.image"
                @update-quantity="updateQuantity(item.id, $event)"
                @remove-item="removeItem(item.id)"
                @toggle-selection="toggleSelection(item.id, $event)"
              />
            </div>
          </div>
        </div>

        <div class="col-md-4 order-details">
          <div class="section-title text-center">
            <h4 class="title">Ringkasan Belanja</h4>
          </div>
          <div class="order-summary">
            <div class="order-col">
              <div><strong>TOTAL</strong></div>
              <div>
                <strong class="order-total">{{ formattedTotalPrice }}</strong>
              </div>
            </div>
          </div>

          <a href="#" class="primary-btn order-submit">Checkout</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import CartItem from "./shop_item/CartItem.vue";
import { fetchCarts } from "@/api/api";

export default {
  components: {
    CartItem,
  },
  data() {
    return {
      cartItems: [
        {
          id: 1,
          name: "Product 1",
          price: 100,
          quantity: 1,
          image: "shop03.png",
        },
        {
          id: 2,
          name: "Product 2",
          price: 200,
          quantity: 2,
          image: "shop03.png",
        },
      ],
      selectedItems: [],
    };
  },
  async mounted() {
    try {
      const data = await fetchCarts();
      console.log(data);
    } catch (error) {
      console.error("Failed to fetch cart items:", error);
    }
  },
  computed: {
    totalPrice() {
      return this.cartItems.reduce((total, item) => {
        if (this.selectedItems.includes(item.id)) {
          return total + item.price * item.quantity;
        }
        return total;
      }, 0);
    },
    formattedTotalPrice() {
      return new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
      }).format(this.totalPrice);
    },
  },
  methods: {
    updateQuantity(id, newQuantity) {
      const item = this.cartItems.find((item) => item.id === id);
      if (item) {
        item.quantity = newQuantity;
      }
    },
    removeItem(id) {
      this.cartItems = this.cartItems.filter((item) => item.id !== id);
      this.selectedItems = this.selectedItems.filter((itemId) => itemId !== id);
    },
    toggleSelection(id, isSelected) {
      if (isSelected) {
        this.selectedItems.push(id);
      } else {
        this.selectedItems = this.selectedItems.filter(
          (itemId) => itemId !== id
        );
      }
    },
  },
};
</script>

<style>
</style>