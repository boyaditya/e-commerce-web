<template>
  <div>
    <HeaderPage title="Pembayaran" />

    <div class="payment-container">
      <div class="payment-card">
        <div class="timer-section">
          <h2>Selesaikan pembayaran dalam</h2>
          <div class="countdown">{{ formatTime }}</div>
          <p class="deadline">Batas Akhir Pembayaran</p>
          <p class="deadline-date">{{ paymentDeadline }}</p>
        </div>

        <div class="payment-details">
          <div class="bank-info">
            <div class="bank-header">
              <h3>{{ paymentMethodName }}</h3>
            </div>

            <div class="account-info">
              <div class="info-row">
                <span class="label">Nomor Virtual Account</span>
                <div class="value-container">
                  <span class="value">{{ virtualAccountNumber }}</span>
                  <button
                    @click="copyToClipboard(virtualAccountNumber)"
                    class="copy-button"
                  >
                    <span>Salin</span>
                  </button>
                </div>
              </div>

              <div class="info-row">
                <span class="label">Total Tagihan</span>
                <div class="value-container">
                  <span class="value">Rp{{ formatPrice(totalAmount) }}</span>
                  <button
                    @click="copyToClipboard(totalAmount)"
                    class="copy-button"
                  >
                    <span>Salin</span>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="action-buttons">
          <button class="btn-outline" @click="checkPaymentStatus">
            Sudah Bayar
          </button>
          <button class="btn-primary" @click="continueShopping">
            Belanja Lagi
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, computed, onMounted, onUnmounted } from "vue";
import { useRoute } from "vue-router";
import { useRouter } from "vue-router";
import HeaderPage from "@/components/templates/HeaderPage.vue";
import { useGlobalState } from "@/globalState";

export default {
  name: "PaymentPage",
  components: {
    HeaderPage,
  },
  setup() {
    const router = useRouter();
    const route = useRoute();
    const countdown = ref(23 * 60 * 60 + 47 * 60 + 50); // 23:47:50
    const paymentMethodName = ref("");
    const bankLogo = ref("/path/to/bank-logo.png");
    const virtualAccountNumber = ref("8870182389");
    const totalAmount = ref(0);
    let timer;
    const { state, updateTransaction, getPayment } = useGlobalState();

    const setPaymentMethodName = () => {
      const paymentMethodMap = {
        va_permata: "Bank Permata",
        va_bca: "Bank BCA",
        va_bni: "Bank BNI",
        va_mandiri: "Bank Mandiri",
        va_bri: "Bank BRI",
        cod: "Cash on Delivery (COD)",
        store_alfamart: "Alfamart",
        store_indomaret: "Indomaret",
      };

      const pathParts = route.path.split("/");
      const paymentMethodKey = pathParts.slice(2, 3).join("_");
      paymentMethodName.value =
        paymentMethodMap[paymentMethodKey] || "Unknown Payment Method";
    };

    const fetchPaymentDetails = async () => {
      const paymentId = route.params.payment_id;
      const payment = await getPayment(paymentId);
      if (payment) {
        totalAmount.value = payment.amount;
      }
    };

    const checkPaymentStatus = async () => {
      try {
        const transactionId = route.params.transaction_id; // Assuming transactionId is passed as a route parameter
        const updatedTransaction = {
          payment_id: route.params.payment_id,
          status: "Terbayar",
        };

        const response = await updateTransaction(
          transactionId,
          updatedTransaction
        );
        if (response) {
          alert("Pembayaran berhasil diverifikasi");
          router.push("/user/order-history");
        } else {
          alert("Gagal memverifikasi pembayaran");
        }
      } catch (error) {
        console.error("Error verifying payment:", error);
        alert("Terjadi kesalahan saat memverifikasi pembayaran");
      }
    };

    const formatTime = computed(() => {
      const hours = Math.floor(countdown.value / 3600);
      const minutes = Math.floor((countdown.value % 3600) / 60);
      const seconds = countdown.value % 60;
      return `${String(hours).padStart(2, "0")}:${String(minutes).padStart(
        2,
        "0"
      )}:${String(seconds).padStart(2, "0")}`;
    });

    const paymentDeadline = computed(() => {
      const date = new Date();
      date.setHours(date.getHours() + 24);
      return date.toLocaleString("id-ID", {
        weekday: "long",
        day: "numeric",
        month: "long",
        year: "numeric",
        hour: "2-digit",
        minute: "2-digit",
      });
    });

    const startCountdown = () => {
      timer = setInterval(() => {
        if (countdown.value > 0) {
          countdown.value--;
        } else {
          clearInterval(timer);
        }
      }, 1000);
    };

    const formatPrice = (price) => {
      return price.toLocaleString("id-ID");
    };

    const copyToClipboard = async (text) => {
      try {
        await navigator.clipboard.writeText(text.toString());
        alert("Berhasil disalin!");
      } catch (err) {
        console.error("Failed to copy:", err);
      }
    };

    const continueShopping = () => {
      router.push("/");
    };

    onMounted(() => {
      setPaymentMethodName();
      fetchPaymentDetails();
      startCountdown();
    });

    onUnmounted(() => {
      clearInterval(timer);
    });

    return {
      formatTime,
      paymentDeadline,
      paymentMethodName,
      bankLogo,
      virtualAccountNumber,
      totalAmount,
      formatPrice,
      copyToClipboard,
      checkPaymentStatus,
      continueShopping,
    };
  },
};
</script>

<style scoped>
.payment-container {
  max-width: 600px;
  margin: 20px auto;
  padding: 0 20px;
}

.payment-card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  padding: 24px;
}

.timer-section {
  text-align: center;
  margin-bottom: 24px;
}

.timer-section h2 {
  font-size: 16px;
  color: #333;
  margin-bottom: 8px;
}

.countdown {
  font-size: 32px;
  font-weight: bold;
  color: #ff6b6b;
  margin-bottom: 8px;
}

.deadline {
  font-size: 14px;
  color: #666;
  margin-bottom: 4px;
}

.deadline-date {
  font-size: 16px;
  font-weight: 500;
  color: #333;
}

.bank-info {
  margin-bottom: 24px;
}

.bank-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.bank-header h3 {
  font-size: 18px;
  color: #333;
}

.bank-logo {
  height: 32px;
  object-fit: contain;
}

.info-row {
  margin-bottom: 16px;
}

.label {
  display: block;
  font-size: 14px;
  color: #666;
  margin-bottom: 4px;
}

.value-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: #f8f9fa;
  padding: 12px;
  border-radius: 8px;
}

.value {
  font-size: 16px;
  font-weight: 500;
  color: #333;
}

.copy-button {
  background: none;
  border: none;
  color: #00a389;
  font-weight: 500;
  cursor: pointer;
  padding: 4px 8px;
}

.copy-button:hover {
  text-decoration: underline;
}

.action-buttons {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
  margin-top: 24px;
}

.btn-outline {
  padding: 12px 24px;
  border: 1px solid #00a389;
  background: white;
  color: #00a389;
  border-radius: 8px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
}

.btn-outline:hover {
  background: #f0f9f7;
}

.btn-primary {
  padding: 12px 24px;
  border: none;
  background: #00a389;
  color: white;
  border-radius: 8px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
}

.btn-primary:hover {
  background: #008d76;
}
</style>