<template>
  <div class="order-detail-page">
    <HeaderPage />

    <div class="container">
      <!-- Loading State -->
      <div v-if="isLoading" class="loading-state">
        <div class="spinner"></div>
        <p>Memuat detail pesanan...</p>
      </div>

      <!-- Error State -->
      <div v-else-if="error" class="error-state">
        <i class="fas fa-exclamation-circle"></i>
        <p>{{ error }}</p>
        <button @click="fetchOrderDetail" class="btn-retry">Coba Lagi</button>
      </div>

      <!-- Order Detail Content -->
      <div v-else-if="order" class="order-detail-section">
        <!-- Status Header -->
        <div class="order-header">
          <div class="order-info">
            <h1 class="order-title">Detail Pesanan</h1>
            <div class="order-meta">
              <span class="order-id">{{ order.invoice }}</span>
              <span class="separator">•</span>
              <span class="order-date">{{ formatDate(order.created_at) }}</span>
            </div>
          </div>
          <div class="order-status" :class="getStatusClass(order.status)">
            {{ getStatusText(order.status) }}
          </div>
        </div>

        <!-- Shipping Info -->
        <div class="shipping-info">
          <h2 class="section-title">Informasi Pengiriman</h2>
          <div class="info-content">
            <div class="address-info">
              <p class="recipient">{{ order.address.recipients_name }}</p>
              <p class="phone">{{ order.address.phone_number }}</p>
              <p class="address">{{ order.address.street_address }}</p>
              <p class="city-info">
                {{ order.address.city }}, {{ order.address.state }}
                {{ order.address.postal_code }}
              </p>
            </div>
            <div v-if="order.tracking_number" class="tracking-info">
              <h3>Nomor Resi</h3>
              <p class="tracking-number">{{ order.tracking_number }}</p>
            </div>
          </div>
        </div>

        <!-- Product List -->
        <div class="product-list">
          <h2 class="section-title">Produk yang Dibeli</h2>
          <div class="products">
            <div
              v-for="item in order.details"
              :key="item.id"
              class="product-item"
            >
              <div class="product-image">
                <img
                  :src="require('@/assets/img/' + item.product_image_url)"
                  :alt="item.product_name"
                />
              </div>
              <div class="product-details">
                <h3 class="product-name">{{ item.product_name }}</h3>
                <p class="product-quantity">{{ item.quantity }} barang</p>
                <p class="product-price">
                  {{ formatPrice(item.product_price) }}
                </p>
              </div>
            </div>
          </div>
        </div>

        <!-- Payment Summary -->
        <div class="payment-summary">
          <h2 class="section-title">Ringkasan Pembayaran</h2>
          <div class="summary-details">
            <div class="summary-row">
              <span>Subtotal Produk</span>
              <span>{{ formatPrice(calculateSubtotal()) }}</span>
            </div>
            <div class="summary-row">
              <span>Biaya Pengiriman</span>
              <span>{{ formatPrice(shippingCost) }}</span>
            </div>
            <div class="summary-row total">
              <span>Total Pembayaran</span>
              <span>{{ formatPrice(calculateTotal()) }}</span>
            </div>
          </div>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
          <button @click="handleBuyAgain" class="btn-buy-again">
            Beli Lagi
          </button>
          <button @click="handleCompletePayment" class="btn-complete-payment">
            Selesaikan Pembayaran
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import { useGlobalState } from "@/globalState";
import HeaderPage from "@/components/templates/HeaderPage.vue";

export default {
  name: "OrderDetailView",
  components: {
    HeaderPage,
  },
  setup(props) {
    const { state, fetchTransactionByInvoice, fetchTransactionDetails, updateTransaction } =
      useGlobalState();
    const route = useRoute();
    const order = ref(null);
    const isLoading = ref(true);
    const error = ref(null);
    const shippingCost = ref(12000);

    const mockOrders = [
      {
        id: 28,
        invoice: "INV/20240128/001",
        created_at: "2024-01-28",
        status: "completed",
        shipping_address: {
          name: "John Doe",
          phone: "08123456789",
          address: "Jl. Mawar No. 10",
          city: "Jakarta",
          province: "DKI Jakarta",
          postal_code: "12345",
        },
        tracking_number: "123456789",
        shipping_cost: 15000,
        items: [
          {
            id: 1,
            quantity: 2,
            product: {
              id: 101,
              name: "Logitech G Pro X Superlight",
              price: 750000,
              image_url: "https://via.placeholder.com/80",
            },
          },
        ],
      },
    ];

    const fetchOrderDetail = async () => {
      const orderInvoice = route.params.invoice;
      // order.value = mockOrders.find((o) => o.id === orderId);
      order.value = await fetchTransactionByInvoice(orderInvoice);
      if (!order.value) {
        error.value = "Pesanan tidak ditemukan";
      }
      console.log(order.value);
      isLoading.value = false;
    };

    const formatDate = (dateString) => {
      const options = { day: "numeric", month: "short", year: "numeric" };
      return new Date(dateString).toLocaleDateString("id-ID", options);
    };

    const handleCompletePayment = async () => {
      if (!order.value) return;

      try {
        const transactionId = order.value.id;
        const updatedTransaction = {
          payment_id: order.value.payment_id,
          status: "Terbayar",
        };

        const response = await updateTransaction(transactionId, updatedTransaction);
        if (response) {
          order.value.status = "Terbayar";
          alert("Pembayaran berhasil diselesaikan");
        } else {
          alert("Gagal menyelesaikan pembayaran");
        }
      } catch (error) {
        console.error("Error completing payment:", error);
        alert("Terjadi kesalahan saat menyelesaikan pembayaran");
      }
    };

    const formatPrice = (price) => {
      return new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
      }).format(price);
    };

    const calculateSubtotal = () => {
      return order.value.details.reduce((total, item) => {
        return total + item.total_price;
      }, 0);
    };

    const calculateTotal = () => {
      return calculateSubtotal() + shippingCost.value;
    };

    const getStatusClass = (status) => {
      const statusClasses = {
        completed: "status-completed",
        processing: "status-processing",
        shipped: "status-shipped",
        cancelled: "status-cancelled",
      };
      return statusClasses[status] || "status-processing";
    };

    const getStatusText = (status) => {
      const statusTexts = {
        completed: "Selesai",
        processing: "Diproses",
        shipped: "Dikirim",
        cancelled: "Dibatalkan",
      };
      return statusTexts[status] || status;
    };

    onMounted(async () => {
      await fetchOrderDetail();
    });

    return {
      order,
      isLoading,
      error,
      shippingCost,
      formatDate,
      formatPrice,
      calculateSubtotal,
      calculateTotal,
      getStatusClass,
      getStatusText,
      fetchOrderDetail,
      handleCompletePayment,
    };
  },
};
</script>

<style scoped>
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.order-detail-section {
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 1px 6px rgba(0, 0, 0, 0.1);
}

.order-header {
  padding: 20px;
  border-bottom: 1px solid #e0e0e0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.order-title {
  font-size: 24px;
  font-weight: 600;
  color: #2b2d42;
  margin: 0 0 8px 0;
}

.order-meta {
  color: #757575;
  font-size: 14px;
}

.separator {
  margin: 0 8px;
}

.order-status {
  padding: 6px 12px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
}

.status-completed {
  background-color: #e8f5e9;
  color: #03ac0e;
}

.status-processing {
  background-color: #fff8e1;
  color: #ffa000;
}

.status-shipped {
  background-color: #e3f2fd;
  color: #1976d2;
}

.status-cancelled {
  background-color: #ffebee;
  color: #d32f2f;
}

.section-title {
  font-size: 18px;
  font-weight: 600;
  color: #2b2d42;
  margin: 0 0 16px 0;
}

.shipping-info,
.product-list,
.payment-summary {
  padding: 20px;
  border-bottom: 1px solid #e0e0e0;
}

.info-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
}

.recipient {
  font-weight: 500;
  margin: 0 0 4px 0;
}

.phone,
.address,
.city-info {
  margin: 0 0 4px 0;
  color: #757575;
}

.tracking-number {
  font-family: monospace;
  font-size: 16px;
  color: #d10024;
}

.product-item {
  display: flex;
  padding: 16px 0;
  border-bottom: 1px solid #f0f0f0;
}

.product-item:last-child {
  border-bottom: none;
}

.product-image img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 4px;
}

.product-details {
  margin-left: 16px;
}

.product-name {
  font-size: 16px;
  font-weight: 500;
  margin: 0 0 4px 0;
}

.product-quantity {
  color: #757575;
  margin: 0 0 4px 0;
}

.product-price {
  font-weight: 500;
  color: #2b2d42;
}

.summary-details {
  max-width: 400px;
  margin-left: auto;
}

.summary-row {
  display: flex;
  justify-content: space-between;
  padding: 8px 0;
  color: #757575;
}

.summary-row.total {
  border-top: 1px solid #e0e0e0;
  margin-top: 8px;
  padding-top: 16px;
  font-weight: 600;
  color: #2b2d42;
}

.action-buttons {
  padding: 20px;
  text-align: right;
}

.btn-buy-again {
  padding: 12px 24px;
  background: #d10024;
  color: white;
  border: none;
  border-radius: 4px;
  font-weight: 500;
  cursor: pointer;
  transition: background 0.2s;
}

.btn-buy-again:hover {
  background: #a0001b;
}

/* Loading State */
.loading-state {
  padding: 40px;
  text-align: center;
}

.spinner {
  width: 40px;
  height: 40px;
  margin: 0 auto 16px;
  border: 3px solid #f3f3f3;
  border-top: 3px solid #d10024;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

/* Error State */
.error-state {
  padding: 40px;
  text-align: center;
  color: #d32f2f;
}

.error-state i {
  font-size: 48px;
  margin-bottom: 16px;
}

.btn-retry {
  margin-top: 16px;
  padding: 8px 24px;
  background: #d10024;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
</style>