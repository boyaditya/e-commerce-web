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
      <button @click="decrementQuantity">-</button>
      <input
        type="number"
        :value="quantity"
        @input="updateQuantity($event.target.value)"
        min="1"
      />
      <button @click="incrementQuantity">+</button>
    </div>
    <div class="remove-item">
      <button @click="removeItem">Hapus</button>
    </div>
  </div>
</template>

<script>
export default {
  name: "CartItem",
  props: {
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
      required: true,
    },
    isSelected: {
      type: Boolean,
      default: false,
    },
  },
  computed: {
    resolvedImgSrc() {
      // Use require to dynamically resolve the image path
      return require(`@/assets/img/${this.imgSrc}`);
    },
    formattedPrice() {
      return new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
      }).format(this.price);
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
  margin-bottom: 20px;
  padding-bottom: 20px;
  border-bottom: 1px solid #e4e7ed;
}

.select-item {
  margin-right: 20px;
}

.product-img img {
  width: 100px;
  height: 100px;
}

.product-details {
  margin-left: 20px;
  flex-grow: 1;
}

.product-name {
  font-size: 18px;
  font-weight: bold;
}

.product-price {
  color: #888;
}

.product-quantity {
  display: flex;
  align-items: center;
}

.product-quantity button {
  background-color: #ddd;
  border: none;
  padding: 5px 10px;
  cursor: pointer;
  border-radius: 6px;
  transition: background-color 0.3s;
}

.product-quantity button:hover {
  background-color: #ccc;
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

.remove-item {
  margin-left: 20px;
}

.remove-item button {
  background-color: #ff4d4d;
  border: none;
  padding: 5px 10px;
  cursor: pointer;
  color: white;
  border-radius: 12px;
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