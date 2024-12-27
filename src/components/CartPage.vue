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
                :id="item.id"
                :name="item.product.name"
                :price="item.product.price"
                :quantity="item.quantity"
                :imgSrc="item.product.image_url"
                :isSelected="selectedItems.includes(item.id)"
                @update-quantity="updateQuantity(item, $event)"
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
              <div><strong>Total</strong></div>
              <div>
                <strong class="order-total">{{ formattedTotalPrice }}</strong>
              </div>
            </div>
          </div>

          <router-link to="/checkout" class="primary-btn order-submit" @click.prevent="proceedToCheckout">
            Checkout
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { computed, onMounted, ref } from "vue";
import { useGlobalState } from "@/globalState.js";
import CartItem from "./shop_item/CartItem.vue";
export default {
  //   components: {
  //     CartItem,
  //   },
  //   data() {
  //     return {
  //       cartItems: [
  //         {
  //           id: 1,
  //           name: "Product 1",
  //           price: 100,
  //           quantity: 1,
  //           image: "shop03.png",
  //         },
  //         {
  //           id: 2,
  //           name: "Product 2",
  //           price: 200,
  //           quantity: 2,
  //           image: "shop03.png",
  //         },
  //       ],
  //       selectedItems: [],
  //     };
  //   },
  //   async mounted() {
  //     try {
  //       const data = await fetchCarts();
  //       console.log(data);
  //     } catch (error) {
  //       console.error("Failed to fetch cart items:", error);
  //     }
  //   },
  //   computed: {
  //     totalPrice() {
  //       return this.cartItems.reduce((total, item) => {
  //         if (this.selectedItems.includes(item.id)) {
  //           return total + item.price * item.quantity;
  //         }
  //         return total;
  //       }, 0);
  //     },
  //     formattedTotalPrice() {
  //       return new Intl.NumberFormat("id-ID", {
  //         style: "currency",
  //         currency: "IDR",
  //       }).format(this.totalPrice);
  //     },
  //   },
  //   methods: {
  //     updateQuantity(id, newQuantity) {
  //       const item = this.cartItems.find((item) => item.id === id);
  //       if (item) {
  //         item.quantity = newQuantity;
  //       }
  //     },
  //     removeItem(id) {
  //       this.cartItems = this.cartItems.filter((item) => item.id !== id);
  //       this.selectedItems = this.selectedItems.filter((itemId) => itemId !== id);
  //     },
  //     toggleSelection(id, isSelected) {
  //       if (isSelected) {
  //         this.selectedItems.push(id);
  //       } else {
  //         this.selectedItems = this.selectedItems.filter(
  //           (itemId) => itemId !== id
  //         );
  //       }
  //     },
  //   },
  // };

  components: {
    CartItem,
  },
  setup() {
    const {
      state,
      addOrUpdateCart,
      fetchCarts,
      removeFromCart,
      setSelectedItems,
    } = useGlobalState();
    const selectedItems = ref([]);

    onMounted(async () => {
      if (state.userInfo) {
        await fetchCarts(state.userInfo.user_id, state.userInfo.access_token);
        console.log("User logged in");
      } else {
        console.log("User not logged in");
      }
    });

    const cartItems = computed(() => state.cartProducts);

    const totalPrice = computed(() => {
      return cartItems.value.reduce((total, item) => {
        if (selectedItems.value.includes(item.id)) {
          return total + item.product.price * item.quantity;
        }
        return total;
      }, 0);
    });

    const formattedTotalPrice = computed(() => {
      return new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
      })
        .format(totalPrice.value)
        .replace(/\s/g, "");
    });

    const updateQuantity = async (item, newQuantity) => {
      // console.log(item.product_id);
      const responseData = await addOrUpdateCart(item.product_id, newQuantity);
      // const item = state.cartProducts.find((item) => item.id === id);
      // if (item) {
      //   item.quantity = newQuantity;
      // }
    };

    const removeItem = (id) => {
      removeFromCart(id);
    };

    const toggleSelection = (id, isSelected) => {
      if (isSelected) {
        selectedItems.value.push(id);
      } else {
        selectedItems.value = selectedItems.value.filter(
          (itemId) => itemId !== id
        );
      }
    };

    const proceedToCheckout = () => {
      setSelectedItems(selectedItems.value);
    };

    return {
      cartItems,
      formattedTotalPrice,
      updateQuantity,
      removeItem,
      toggleSelection,
      selectedItems,
      proceedToCheckout,
    };
  },
};
</script>

<style>
</style>