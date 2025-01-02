<template>
  <div id="breadcrumb" class="section">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h3 class="breadcrumb-header">Checkout</h3>
        </div>
      </div>
    </div>
  </div>

  <div class="section">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <div class="address-card">
            <div class="section-title">
              <h3 class="title">Shipping Address</h3>
            </div>
            <div class="address-details">
              <p>
                <strong>Recipient's Name:</strong> {{ address.recipients_name }}
              </p>
              <p><strong>Phone Number:</strong> {{ address.phone_number }}</p>
              <p>
                <strong>Street Address:</strong> {{ address.street_address }}
              </p>
              <p><strong>City:</strong> {{ address.city }}</p>
              <p><strong>State:</strong> {{ address.state }}</p>
              <p><strong>Country:</strong> {{ address.country }}</p>
              <p><strong>ZIP Code:</strong> {{ address.postal_code }}</p>
            </div>
            <router-link to="/user/address" class="btn btn-primary"
              >Edit Address</router-link
            >
          </div>
          <div class="caption">
            <div class="cart-items">
              <CheckoutItem
                v-for="item in selectedCartItems"
                :key="item.id"
                :id="item.id"
                :name="item.product.name"
                :price="item.product.price"
                :quantity="item.quantity"
                :imgSrc="item.product.image_url"
              />
            </div>
          </div>
        </div>

        <div class="col-md-6 order-details">
          <div class="section-title text-center">
            <h4 class="title">Order Summary</h4>
          </div>
          <div class="order-summary">
            <div class="order-col header">
              <div class="product-name"><strong>Product</strong></div>
              <div class="product-price"><strong>Price</strong></div>
              <div class="product-quantity"><strong>Quantity</strong></div>
              <div class="product-total"><strong>Total</strong></div>
            </div>
            <div
              v-for="item in selectedCartItems"
              :key="item.id"
              class="order-products"
            >
              <div class="order-col">
                <div class="product-name">{{ item.product.name }}</div>
                <div class="product-price">
                  {{ formatPrice(item.product.price) }}
                </div>
                <div class="product-quantity">{{ item.quantity }}</div>
                <div class="product-total">
                  {{ formatPrice(item.product.price * item.quantity) }}
                </div>
              </div>
            </div>
            <hr />
            <div class="order-col">
              <div><strong>Subtotal</strong></div>
              <div></div>
              <div>
                <strong>{{ formatPrice(totalPriceProduct) }}</strong>
              </div>
            </div>
            <div class="order-col">
              <div><strong>Shipping Cost</strong></div>
              <div></div>
              <div>
                <strong>{{ formatPrice(shippingCost) }}</strong>
              </div>
            </div>
            <div class="order-col">
              <div><strong>Total Payment</strong></div>
              <div></div>
              <div>
                <strong>{{ formatPrice(totalPayment) }}</strong>
              </div>
            </div>
          </div>
          <a
            href=""
            class="primary-btn order-submit"
            @click.prevent="submitOrder"
            >Place Order</a
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { computed, ref } from "vue";
import { useGlobalState } from "@/globalState.js";
import CheckoutItem from "./shop_item/CheckoutItem.vue";

export default {
  components: {
    CheckoutItem,
  },
  setup() {
    const { state, addTransaction } = useGlobalState();
    const shippingCost = ref(12000);

    const selectedCartItems = computed(() => {
      return state.cartProducts.filter((item) =>
        state.selectedItems.includes(item.id)
      );
    });

    const totalPriceProduct = computed(() => {
      return selectedCartItems.value.reduce((total, item) => {
        return total + item.product.price * item.quantity;
      }, 0);
    });

    const totalPayment = computed(() => {
      return totalPriceProduct.value + shippingCost.value;
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

    const submitOrder = async () => {
      // console.log("Order submitted", {
      //   selectedCartItems: selectedCartItems.value,
      // });
      // console.log(state.userAddress.id);
      const transaction = {
        user_id: state.userInfo.user_id,
        address_id: state.userAddress.id,
        total: totalPayment.value,
        status: "Menunggu Pembayaran",
        invoice: "",
        number: 0
      };

      const selected = JSON.parse(JSON.stringify(selectedCartItems.value));
      const details = selectedCartItems.value.map(item => {
        return {
          transaction_id: 0,
          product_id: item.product.id,  // Product ID
          product_name: item.product.name,  // Product Name
          product_price: item.product.price,  // Product Price
          product_image_url: item.product.image_url,  // Product Image URL
          product_category_id: item.product.category_id,  // Product Category ID
          quantity: item.quantity,  // Quantity in cart
          total_price: item.product.price * item.quantity,  // Total price for this item
        };
      });

      // console.log(details);  // Log the details array for verification
      // console.log(JSON.parse(JSON.stringify(selectedCartItems.value)));
      const responseData = await addTransaction(transaction, details, selected);
    };

    const address = computed(() => state.userAddress);

    return {
      selectedCartItems,
      totalPriceProduct,
      totalPayment,
      formatPrice,
      submitOrder,
      shippingCost,
      address,
    };
  },
};
</script>

<style scoped>
.cart-items {
  margin-bottom: 30px;
}

.address-card {
  background: #f9f9f9;
  padding: 20px;
  border: 1px solid #e4e7ed;
  border-radius: 5px;
  margin-bottom: 30px;
}

.address-details p {
  margin: 0 0 10px;
}

.order-details .order-summary {
  margin-bottom: 30px;
}

.order-details .order-summary .order-col {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
}

.order-details .order-summary .order-products .order-col {
  margin-bottom: 10px;
}

.order-details .order-summary .order-col div {
  flex: 1;
}

.order-details .order-summary .order-col .product-name {
  flex: 2;
}

.order-details .order-summary .order-col .product-price {
  flex: 1;
  text-align: center;
}

.order-details .order-summary .order-col .product-quantity {
  flex: 1;
  text-align: center;
}

.order-details .order-summary .order-col .product-total {
  flex: 1;
  text-align: right;
}

.order-details .order-summary .order-total {
  font-size: 24px;
  font-weight: 700;
  color: #d10024;
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

.primary-btn:hover {
  background-color: #a0001b;
}

.btn {
  display: inline-block;
  padding: 10px 20px;
  background-color: #007bff;
  color: #fff;
  text-align: center;
  border-radius: 5px;
  text-transform: uppercase;
  font-weight: 700;
  cursor: pointer;
  transition: background-color 0.3s;
  margin-top: 10px;
}

.btn:hover {
  background-color: #0056b3;
}
</style>