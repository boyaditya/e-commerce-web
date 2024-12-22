<template>
  <div class="cart-item">
    <div class="select-item">
      <input
        type="checkbox"
        class="checkbox-item"
        @change="toggleSelection"
        :checked="isSelected"
      />
    </div>
    <div class="product-img">
      <img :src="resolvedImgSrc" alt="Product Image" />
    </div>
    <div class="product-details">
      <h4 class="product-name">{{ name }}</h4>
      <p class="product-price">{{ formattedPrice }}</p>
    </div>
    <div class="product-quantity">
      <button class="quantity-btn" @click="decrementQuantity">-</button>
      <input
        type="number"
        :value="quantity"
        @input="updateQuantity($event.target.value)"
        min="1"
      />
      <button class="quantity-btn" @click="incrementQuantity">+</button>
    </div>
    <div class="remove-item">
      <button class="remove-btn" @click="removeItem">Hapus</button>
    </div>
  </div>
</template>

<script>
export default {
  name: "CartItem",
  props: {
    id: {
      type: Number,
      required: true,
    },
    name: {
      type: String,
      required: true,
    },
    price: {
      type: Number,
      required: true,
    },
    quantity: {
      type: Number,
      default: 1,
    },
    imgSrc: {
      type: String,
      // required: true,
    },
    isSelected: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    resolvedImgSrc() {
      try {
        return require(`@/assets/img/${this.imgSrc}`);
      } catch (e) {
        console.error(`Image not found: ${this.imgSrc}`);
        return require("@/assets/img/default-image.jpg");
      }
    },
    formattedPrice() {
      return new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
      })
        .format(this.price)
        .replace(/\s/g, "");
    },
  },
  methods: {
    incrementQuantity() {
      this.$emit("update-quantity", this.quantity + 1);
    },
    decrementQuantity() {
      if (this.quantity > 1) {
        this.$emit("update-quantity", this.quantity - 1);
      }
    },
    updateQuantity(newQuantity) {
      const parsedQuantity = parseInt(newQuantity, 10);
      if (!isNaN(parsedQuantity) && parsedQuantity > 0) {
        this.$emit("update-quantity", parsedQuantity);
      }
    },
    removeItem() {
      this.$emit("remove-item");
    },
    toggleSelection(event) {
      this.$emit("toggle-selection", event.target.checked);
    },
  },
};
</script>
<style scoped>
.cart-item {
  display: flex;
  align-items: center;
  padding: 15px;
  border: 1px solid #e4e4e4;
  border-radius: 5px;
  background-color: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  margin-bottom: 20px;
}

.select-item {
  margin-right: 15px;
}

.product-img img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 5px;
  margin-right: 15px;
}

.product-details {
  margin-left: 10px;
  flex-grow: 1;
}

.product-name {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 5px;
}

.product-price {
  font-size: 14px;
  color: #888;
  margin-bottom: 10px;
}

.product-quantity {
  display: flex;
  align-items: center;
}

.product-quantity input {
  width: 50px;
  text-align: center;
  border: 1px solid #ddd;
  border-radius: 6px;
  padding: 5px;
  margin: 0 10px;
  transition: border-color 0.3s;
}

.product-quantity input:focus {
  border-color: #42b983;
  outline: none;
}

.quantity-btn {
  background-color: #f0f0f0;
  border: 1px solid #ccc;
  padding: 5px 10px;
  cursor: pointer;
  border-radius: 3px;
}

.quantity-btn:hover {
  background-color: #e0e0e0;
}

.remove-item {
  margin-left: 15px;
}

.remove-item button {
  background-color: #ff4d4d;
  border: none;
  padding: 5px 10px;
  cursor: pointer;
  color: white;
  border-radius: 3px;
  transition: background-color 0.3s;
}

.remove-item button:hover {
  background-color: #e60000;
}

.checkbox-item {
  width: 20px;
  height: 20px;
  accent-color: #00ff40; /* Example color */
  cursor: pointer;
}
</style>