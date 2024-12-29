<template>
  <div class="col-md-8">
    <div class="address-section">
      <h3>Edit Address</h3>
      <form @submit.prevent="saveAddress">
        <div class="form-group">
          <label for="recipients_name">Recipient's Name</label>
          <input
            type="text"
            id="recipients_name"
            v-model="address.recipients_name"
            class="form-control"
          />
        </div>
        <div class="form-group">
          <label for="phone">Phone Number</label>
          <input
            type="text"
            id="phone"
            v-model="address.phone_number"
            class="form-control"
          />
        </div>
        <div class="form-group">
          <label for="street_address">Street Address</label>
          <input
            type="text"
            id="street_address"
            v-model="address.street_address"
            class="form-control"
          />
        </div>
        <div class="form-group">
          <label for="city">City</label>
          <input
            type="text"
            id="city"
            v-model="address.city"
            class="form-control"
          />
        </div>
        <div class="form-group">
          <label for="state">State</label>
          <input
            type="text"
            id="state"
            v-model="address.state"
            class="form-control"
          />
        </div>
        <div class="form-group">
          <label for="postal_code">Postal Code</label>
          <input
            type="text"
            id="postal_code"
            v-model="address.postal_code"
            class="form-control"
          />
        </div>
        <div class="form-group">
          <label for="country">Country</label>
          <input
            type="text"
            id="country"
            v-model="address.country"
            class="form-control"
          />
        </div>
        <button type="submit" class="btn btn-primary">Save Address</button>
      </form>
    </div>
  </div>
</template>

<script>
import { computed, onMounted } from "vue";
import { useGlobalState } from "@/globalState.js";

export default {
  setup() {
    const { state, setUserAddress } = useGlobalState();

    const address = computed(() => state.userAddress);

    const saveAddress = async () => {
      try {
        await setUserAddress(state.userInfo.user_id, address.value);
        console.log("Address saved:", address.value);
      } catch (error) {
        console.error("Failed to save address:", error);
      }
    };

    onMounted(() => {
      if (address.value) {
        address.value = { ...state.userAddress };
      }
    });

    return {
      address,
      saveAddress,
    };
  },
};
</script>

<style scoped>
.address-section {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
  background: #f9f9f9;
  border: 1px solid #e4e7ed;
  border-radius: 5px;
}

.form-group {
  margin-bottom: 15px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
}

.form-group input {
  width: 100%;
  padding: 8px;
  box-sizing: border-box;
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
}

.btn:hover {
  background-color: #0056b3;
}
</style>