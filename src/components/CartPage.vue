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

          <button
            class="primary-btn order-submit"
            :class="{ disabled: !hasSelectedItems }"
            @click="proceedToCheckout"
            :disabled="!hasSelectedItems"
          >
            Checkout
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { computed, onMounted, ref } from "vue";
import { useRouter } from "vue-router";
import { useGlobalState } from "@/globalState.js";
import CartItem from "./shop_item/CartItem.vue";

export default {
  components: {
    CartItem,
  },
  setup() {
    const router = useRouter();
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

    const hasSelectedItems = computed(() => {
      return selectedItems.value.length > 0;
    });

    const updateQuantity = async (item, newQuantity) => {
      await addOrUpdateCart(item.product_id, newQuantity);
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
      if (hasSelectedItems.value) {
        setSelectedItems(selectedItems.value);
        router.push("/checkout");
      }
    };

    return {
      cartItems,
      formattedTotalPrice,
      updateQuantity,
      removeItem,
      toggleSelection,
      selectedItems,
      proceedToCheckout,
      hasSelectedItems,
    };
  },
};
</script>

<style scoped>
.cart-items {
  margin-bottom: 30px;
}

.order-details .order-summary {
  margin-bottom: 30px;
}

.order-details .order-summary .order-col {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
}

.primary-btn {
  display: block;
  width: 100%;
  padding: 10px;
  background-color: #d10024;
  color: #fff;
  text-align: center;
  border-radius: 5px;
  text-transform: uppercase;
  font-weight: 700;
  cursor: pointer;
  transition: background-color 0.3s;
}

.primary-btn.disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.primary-btn:hover:not(.disabled) {
  background-color: #a0001b;
}
</style>