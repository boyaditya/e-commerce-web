<template>
  <div class="order-history-page">
    <HeaderPage />

    <div class="container">
      <div class="order-history-section">
        <div class="section-header">
          <h2 class="section-title">Daftar Transaksi</h2>
        </div>

        <div v-if="orders.length > 0" class="orders-container">
          <div v-for="order in orders" :key="order.id" class="order-card">
            <!-- Order Header -->
            <div class="order-card-header">
              <div class="order-info">
                <div class="order-date">
                  <i class="fas fa-calendar-alt"></i>
                  {{ order.date }}
                </div>
                <div class="order-number">
                  No. Pesanan: {{ order.id }}
                </div>
              </div>
              <div class="order-status success">Selesai</div>
            </div>

            <!-- Order Items -->
            <div class="order-items">
              <div v-for="item in order.items" :key="item.id" class="order-item">
                <div class="item-image">
                  <img :src="item.image" :alt="item.name">
                </div>
                <div class="item-details">
                  <h4 class="item-name">{{ item.name }}</h4>
                  <p class="item-quantity">{{ item.quantity }} barang</p>
                </div>
              </div>
            </div>

            <!-- Order Footer -->
            <div class="order-card-footer">
              <div class="total-section">
                <span>Total Belanja</span>
                <span class="total-amount">{{ order.total }}</span>
              </div>
              <div class="action-buttons">
                <button 
                  class="btn-detail" 
                  @click="$router.push({ name: 'OrderDetail', params: { id: order.id } })">
                  Lihat Detail
                </button>
                <button class="btn-buy-again">Beli Lagi</button>
              </div>
            </div>
          </div>
        </div>

        <div v-else class="empty-state">
          <div class="empty-state-content">
            <i class="fas fa-shopping-bag empty-icon"></i>
            <h3>Belum ada transaksi</h3>
            <p>Yuk, mulai belanja dan dapatkan produk impianmu!</p>
            <router-link to="/store" class="btn-shop-now">Mulai Belanja</router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { onMounted, ref } from "vue";
import { useGlobalState } from "@/globalState";
import HeaderPage from "@/components/templates/HeaderPage.vue";

export default {
  name: "OrderHistoryView",
  components: {
    HeaderPage,
  },
  setup() {
    const { state } = useGlobalState();
    const orders = ref([]);

    onMounted(() => {
      if (state.isAuthenticated) {
        orders.value = [
          {
            id: "INV/20240128/001",
            date: "28 Jan 2024",
            total: "Rp1.500.000",
            items: [
              { id: 1, name: "Logitech G Pro X Superlight", quantity: 2, image: "https://via.placeholder.com/80" },
              { id: 2, name: "HyperX Cloud Alpha", quantity: 1, image: "https://via.placeholder.com/80" },
            ],
          },
          {
            id: "INV/20240127/002",
            date: "27 Jan 2024",
            total: "Rp2.300.000",
            items: [
              { id: 3, name: "Razer Blackwidow V3", quantity: 1, image: "https://via.placeholder.com/80" },
              { id: 4, name: "Steelseries Arctis 7", quantity: 3, image: "https://via.placeholder.com/80" },
            ],
          },
        ];
      }
    });

    return {
      orders,
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

.order-history-section {
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 1px 6px rgba(0, 0, 0, 0.1);
}

.section-header {
  padding: 20px;
  border-bottom: 1px solid #e0e0e0;
}

.section-title {
  font-size: 20px;
  font-weight: 600;
  color: #2B2D42;
  margin: 0;
}

.orders-container {
  padding: 20px;
}

.order-card {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  margin-bottom: 20px;
  background: #fff;
}

.order-card-header {
  padding: 16px;
  border-bottom: 1px solid #e0e0e0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.order-info {
  display: flex;
  gap: 20px;
}

.order-date, .order-number {
  color: #757575;
  font-size: 14px;
}

.order-status {
  font-size: 14px;
  font-weight: 600;
}

.order-status.success {
  color: #03ac0e;
}

.order-items {
  padding: 16px;
}

.order-item {
  display: flex;
  gap: 16px;
  padding: 12px 0;
  border-bottom: 1px solid #f0f0f0;
}

.order-item:last-child {
  border-bottom: none;
}

.item-image img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 4px;
}

.item-details {
  flex: 1;
}

.item-name {
  font-size: 14px;
  font-weight: 500;
  color: #2B2D42;
  margin: 0 0 4px 0;
}

.item-quantity {
  font-size: 13px;
  color: #757575;
  margin: 0;
}

.order-card-footer {
  padding: 16px;
  border-top: 1px solid #e0e0e0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.total-section {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.total-section span:first-child {
  font-size: 13px;
  color: #757575;
}

.total-amount {
  font-size: 16px;
  font-weight: 600;
  color: #2B2D42;
}

.action-buttons {
  display: flex;
  gap: 12px;
}

.btn-detail, .btn-buy-again {
  padding: 8px 16px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
}

.btn-detail {
  border: 1px solid #d10024;
  background: transparent;
  color: #d10024;
}

.btn-buy-again {
  border: none;
  background: #d10024;
  color: white;
}

.btn-detail:hover {
  background: rgba(209, 0, 36, 0.1);
}

.btn-buy-again:hover {
  background: #a0001b;
}

.empty-state {
  padding: 60px 20px;
  text-align: center;
}

.empty-state-content {
  max-width: 400px;
  margin: 0 auto;
}

.empty-icon {
  font-size: 48px;
  color: #bdbdbd;
  margin-bottom: 16px;
}

.empty-state h3 {
  font-size: 18px;
  color: #2B2D42;
  margin: 0 0 8px 0;
}

.empty-state p {
  font-size: 14px;
  color: #757575;
  margin: 0 0 24px 0;
}

.btn-shop-now {
  display: inline-block;
  padding: 12px 24px;
  background: #d10024;
  color: white;
  border-radius: 4px;
  text-decoration: none;
  font-weight: 500;
  transition: background 0.2s;
}

.btn-shop-now:hover {
  background: #a0001b;
}
</style>