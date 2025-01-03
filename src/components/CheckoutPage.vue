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
              <h3 class="title">Alamat Pengiriman</h3>
            </div>
            <div class="address-details">
              <p>
                <strong>Nama Penerima:</strong> {{ address.recipients_name }}
              </p>
              <p><strong>Nomor Telepon:</strong> {{ address.phone_number }}</p>
              <p><strong>Alamat:</strong> {{ address.street_address }}</p>
              <p><strong>Kota:</strong> {{ address.city }}</p>
              <p><strong>Provinsi:</strong> {{ address.state }}</p>
              <p><strong>Negara:</strong> {{ address.country }}</p>
              <p><strong>Kode Pos:</strong> {{ address.postal_code }}</p>
            </div>
            <router-link to="/user/address" class="btn btn-primary"
              >Ubah Alamat</router-link
            >
          </div>

          <!-- Payment Method Section -->
          <div class="payment-method-card">
            <div class="section-title">
              <h3 class="title">Metode Pembayaran</h3>
            </div>
            <div class="payment-selector">
              <select
                v-model="selectedPaymentMethod"
                class="payment-dropdown"
                :class="{ empty: !selectedPaymentMethod }"
              >
                <option value="">Pilih metode pembayaran</option>
                <optgroup label="Cash on Delivery">
                  <option value="cod">Cash on Delivery (COD)</option>
                </optgroup>
                <optgroup label="Virtual Account">
                  <option
                    v-for="bank in banks"
                    :key="bank.id"
                    :value="'va_' + bank.id"
                  >
                    {{ bank.name }} Virtual Account
                  </option>
                </optgroup>
                <optgroup label="Minimarket">
                  <option
                    v-for="store in stores"
                    :key="store.id"
                    :value="'store_' + store.id"
                  >
                    {{ store.name }}
                  </option>
                </optgroup>
              </select>
              <div class="payment-icon">
                <i class="fa fa-chevron-down"></i>
              </div>
            </div>
            <div v-if="selectedPaymentMethod" class="selected-payment-info">
              <div class="payment-icon">
                <i :class="getPaymentIcon"></i>
              </div>
              <div class="payment-details">
                <span class="payment-label">Metode Pembayaran Terpilih:</span>
                <span class="payment-value">{{ getPaymentLabel }}</span>
              </div>
            </div>
          </div>
        </div>

        <div class="col-md-6 order-details">
          <div class="section-title text-center">
            <h4 class="title">Ringkasan Transaksi</h4>
          </div>
          <div class="order-summary">
            <div class="order-col header">
              <div class="product-name"><strong>Produk</strong></div>
              <div class="product-price"><strong>Harga</strong></div>
              <div class="product-quantity"><strong>Jumlah</strong></div>
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
              <div><strong>Ongkos Pengiriman</strong></div>
              <div></div>
              <div>
                <strong>{{ formatPrice(shippingCost) }}</strong>
              </div>
            </div>
            <div class="order-col">
              <div><strong>Total Pembayaran</strong></div>
              <div></div>
              <div>
                <strong>{{ formatPrice(totalPayment) }}</strong>
              </div>
            </div>
          </div>
          <a
            href=""
            class="primary-btn order-submit"
            :class="{ disabled: !selectedPaymentMethod }"
            @click.prevent="submitOrder"
            >Pesan</a
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { computed, ref } from "vue";
import { useRouter } from "vue-router";
import { useGlobalState } from "@/globalState.js";
import CheckoutItem from "./shop_item/CheckoutItem.vue";

export default {
  components: {
    CheckoutItem,
  },
  setup() {
    const router = useRouter();
    const { state, addTransaction, createPayment, updateTransaction } =
      useGlobalState();
    const shippingCost = ref(12000);
    const selectedPaymentMethod = ref("");

    const banks = [
      { id: "bca", name: "BCA" },
      { id: "bni", name: "BNI" },
      { id: "mandiri", name: "Mandiri" },
      { id: "bri", name: "BRI" },
      { id: "permata", name: "Permata" },
    ];

    const stores = [
      { id: "alfamart", name: "Alfamart" },
      { id: "indomaret", name: "Indomaret" },
    ];

    const selectedCartItems = computed(() => {
      return state.cartProducts.filter((item) =>
        state.selectedItems.includes(item.id)
      );
    });

    const getPaymentIcon = computed(() => {
      if (!selectedPaymentMethod.value) return "";

      if (selectedPaymentMethod.value === "cod") {
        return "fa fa-money";
      }
      if (selectedPaymentMethod.value.startsWith("va_")) {
        return "fa fa-bank";
      }
      if (selectedPaymentMethod.value.startsWith("store_")) {
        return "fa fa-store";
      }
      return "";
    });

    const getPaymentLabel = computed(() => {
      if (!selectedPaymentMethod.value) return "";

      if (selectedPaymentMethod.value === "cod") {
        return "Cash on Delivery (COD)";
      }
      if (selectedPaymentMethod.value.startsWith("va_")) {
        const bankId = selectedPaymentMethod.value.replace("va_", "");
        const bank = banks.find((b) => b.id === bankId);
        return `${bank.name} Virtual Account`;
      }
      if (selectedPaymentMethod.value.startsWith("store_")) {
        const storeId = selectedPaymentMethod.value.replace("store_", "");
        const store = stores.find((s) => s.id === storeId);
        return store.name;
      }
      return "";
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
      if (!selectedPaymentMethod.value) {
        alert("Silakan pilih metode pembayaran terlebih dahulu");
        return;
      }
      const hargaTotal = totalPayment.value;

      const transaction = {
        user_id: state.userInfo.user_id,
        address_id: state.userAddress.id,
        total: totalPayment.value,
        status: "Menunggu Pembayaran",
        invoice: "",
        number: 0,
        payment_id: null,
      };

      const selectedCart = JSON.parse(JSON.stringify(selectedCartItems.value));
      const transactionData = selectedCartItems.value.map((item) => {
        return {
          transaction_id: 0,
          product_id: item.product.id,
          product_name: item.product.name,
          product_price: item.product.price,
          product_image_url: item.product.image_url,
          product_category_id: item.product.category_id,
          quantity: item.quantity,
          total_price: item.product.price * item.quantity,
        };
      });

      const transactionResponse = await addTransaction(
        transaction,
        transactionData,
        selectedCart
      );

      let paymentResponse = null;

      if (transactionResponse) {
        const paymentDetails = {
          transaction_id: transactionResponse.id,
          amount: hargaTotal,
          payment_date: new Date().toISOString(),
          payment_method: selectedPaymentMethod.value,
          status: "pending",
          verified_by: null,
        };

        paymentResponse = await createPayment(paymentDetails);
        if (paymentResponse) {
          const updatedTransaction = {
            payment_id: paymentResponse.id,
            status: "Menunggu Pembayaran",
          };

          await updateTransaction(transactionResponse.id, updatedTransaction);

          alert("Berhasil membuat pembayaran");
        } else {
          alert("Gagal membuat pembayaran");
        }
      } else {
        alert("Gagal membuat transaksi");
      }

      if (transactionResponse) {
        // Redirect to payment page with the selected payment method
        router.push({
          name: "payment",
          params: {
            method: selectedPaymentMethod.value,
            transaction_id: paymentResponse.transaction_id,
            payment_id: paymentResponse.id,
          },
        });
      }
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
      selectedPaymentMethod,
      banks,
      stores,
      getPaymentIcon,
      getPaymentLabel,
    };
  },
};
</script>

<style scoped>
.cart-items {
  margin-bottom: 30px;
}

.address-card,
.payment-method-card {
  background: #f9f9f9;
  padding: 20px;
  border: 1px solid #e4e7ed;
  border-radius: 5px;
  margin-bottom: 30px;
}

.address-details p {
  margin: 0 0 10px;
}

.payment-selector {
  position: relative;
  margin-top: 15px;
}

.payment-dropdown {
  width: 100%;
  padding: 12px 45px 12px 15px;
  font-size: 16px;
  border: 2px solid #e4e7ed;
  border-radius: 8px;
  background-color: white;
  appearance: none;
  cursor: pointer;
  transition: all 0.3s ease;
}

.payment-dropdown:focus {
  outline: none;
  border-color: #d10024;
  box-shadow: 0 0 0 3px rgba(209, 0, 36, 0.1);
}

.payment-dropdown.empty {
  color: #757575;
}

.payment-dropdown option,
.payment-dropdown optgroup {
  color: #333;
  padding: 12px;
}

.payment-icon {
  position: absolute;
  right: 15px;
  top: 50%;
  transform: translateY(-50%);
  color: #d10024;
  pointer-events: none;
}

.selected-payment-info {
  margin-top: 15px;
  padding: 15px;
  background-color: #fff;
  border: 1px solid #e4e7ed;
  border-radius: 8px;
  display: flex;
  align-items: center;
  gap: 15px;
}

.selected-payment-info .payment-icon {
  position: static;
  transform: none;
  width: 40px;
  height: 40px;
  background: #f8f9fa;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.selected-payment-info .payment-icon i {
  font-size: 20px;
}

.payment-details {
  flex: 1;
}

.payment-label {
  display: block;
  font-size: 12px;
  color: #757575;
  margin-bottom: 4px;
}

.payment-value {
  display: block;
  font-size: 16px;
  font-weight: 600;
  color: #333;
}

.payment-dropdown optgroup {
  font-weight: 600;
  background-color: #f8f9fa;
}

.payment-dropdown option {
  padding: 10px;
  font-weight: normal;
  background-color: white;
}

.order-details .order-summary {
  margin-bottom: 20px;
}

.order-details .order-summary .order-col {
  display: flex;
  justify-content: space-between;
}

.order-details .order-summary .order-products .order-col {
  margin-bottom: 5px;
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

.primary-btn.disabled {
  background-color: #ccc;
  cursor: not-allowed;
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