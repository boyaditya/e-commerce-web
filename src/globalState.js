import { reactive } from "vue";
import {
  login as apiLogin,
  fetchUserById,
  fetchCarts as apiFetchCarts,
} from "@/api/api";

const state = reactive({
  userInfo: JSON.parse(localStorage.getItem("userInfo")) || null,
  cartProducts: JSON.parse(localStorage.getItem("cartProducts")) || [],
});

export const useGlobalState = () => {
  const login = async (email, password) => {
    try {
      const loginResponse = await apiLogin(email, password);
      const userInfo = await fetchUserById(
        loginResponse.user_id,
        loginResponse.access_token
      );
      state.userInfo = userInfo;
      state.userInfo.access_token = loginResponse.access_token;
      state.userInfo.user_id = loginResponse.user_id;
      delete userInfo.id;
      localStorage.setItem("userInfo", JSON.stringify(userInfo));
    } catch (error) {
      console.error(error);
    }
  };

  const fetchCarts = async () => {
    try {
      if (state.userInfo) {
        const cartData = await apiFetchCarts(
          state.userInfo.user_id,
          state.userInfo.access_token
        );
        state.cartProducts = cartData;
        localStorage.setItem("cartProducts", JSON.stringify(cartData));
      }
    } catch (error) {
      console.error(error);
    }
  };

  const removeFromCart = (cartId) => {
    state.cartProducts = state.cartProducts.filter(
      (cart) => cart.id !== cartId
    );
    localStorage.setItem("cartProducts", JSON.stringify(state.cartProducts));
  };

  return {
    state,
    login,
    fetchCarts,
    removeFromCart,
  };
};
