import { reactive } from "vue";
import {
  login as apiLogin,
  register as apiRegister,
  fetchUserById,
  fetchCarts as apiFetchCarts,
  addCartItem as apiAddCartItem,
  deleteCartItem as apiDeleteCartItem,
  updateCartItem as apiUpdateCartItem,
  fetchWishlist as apiFetchWishlist,
  addWishlistItem as apiAddWishlistItem,
  deleteWishlistItem as apiDeleteWishlistItem,
  getAddress as apiGetAddress,
  createAddress as apiCreateAddress,
} from "@/api/api";

const state = reactive({
  userInfo: JSON.parse(localStorage.getItem("userInfo")) || null,
  userAddress: JSON.parse(localStorage.getItem("userAddress")) || null,
  cartProducts: JSON.parse(localStorage.getItem("cartProducts")) || [],
  wishlistProducts: JSON.parse(localStorage.getItem("wishlistProducts")) || [],
  isAuthenticated: !!localStorage.getItem("userInfo"),
  selectedItems: [],
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

      const userAddress = await apiGetAddress(loginResponse.user_id, loginResponse.access_token);
      state.userAddress = userAddress;
      localStorage.setItem("userAddress", JSON.stringify(userAddress[0]));
      state.isAuthenticated = true;
    } catch (error) {
      console.error(error);
    }
  };

  const register = async (username, email, password, address) => {
    try {
      await apiRegister(username, email, password, address);
    } catch (error) {
      console.error(error);
    }
  };

  const logout = () => {
    try {
      // Clear user-related data from the state
      state.userInfo = null;
      state.cartProducts = [];
      state.wishlistProducts = [];

      // Remove user-related data from localStorage
      localStorage.removeItem("userInfo");
      localStorage.removeItem("cartProducts");
      localStorage.removeItem("wishlistProducts");

      state.isAuthenticated = false;
    } catch (error) {
      console.error("Error during logout:", error);
    }
  };

  const fetchUserAddress = async (userId) => {
    try {
      const address = await apiGetAddress(userId);
      state.userAddress = address;
      localStorage.setItem("userAddress", JSON.stringify(address));
    } catch (error) {
      console.error("Failed to fetch user address:", error);
    }
  };

  const setUserAddress = async (userId, address) => {
    try {
      const newAddress = await apiCreateAddress(userId, address);
      state.userAddress = newAddress;
      localStorage.setItem("userAddress", JSON.stringify(newAddress));
    } catch (error) {
      console.error("Failed to set user address:", error);
    }
  };

  const setSelectedItems = (items) => {
    state.selectedItems = items;
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

  const addToCart = async (product_id, quantity) => {
    const item = {
      // Initialize item here
      user_id: state.userInfo.user_id,
      product_id: product_id,
      quantity: quantity,
    };

    try {
      if (state.userInfo) {
        const cartData = await apiAddCartItem(item, state.userInfo);
        state.cartProducts.push(cartData);
        localStorage.setItem(
          "cartProducts",
          JSON.stringify(state.cartProducts)
        );
        return cartData;
      }
    } catch (error) {
      console.error(error);
    }
  };

  const updateCartItem = async (cart_id, quantity, index) => {
    const cart = {
      user_id: state.userInfo.user_id,
      product_id: state.cartProducts[index].product_id,
      quantity: quantity,
    };
    console.log(cart);

    try {
      if (state.userInfo) {
        const cartData = await apiUpdateCartItem(cart_id, cart, state.userInfo);

        state.cartProducts[index].quantity = quantity;
        localStorage.setItem(
          "cartProducts",
          JSON.stringify(state.cartProducts)
        );
        return cartData;
      }
    } catch (error) {
      console.error(error);
    }
  };

  const findProductInCart = (product_id) => {
    return state.cartProducts.findIndex(
      (item) => item.product_id === product_id
    );
  };

  const addOrUpdate = async (product_id, quantity) => {
    const index = findProductInCart(product_id);

    if (index !== -1) {
      return await updateCartItem(
        state.cartProducts[index].id,
        quantity + state.cartProducts[index].quantity,
        index
      );
    } else {
      return await addToCart(product_id, quantity);
    }
  };

  const addOrUpdateCart = async (product_id, quantity) => {
    const index = findProductInCart(product_id);

    if (index !== -1) {
      return await updateCartItem(
        state.cartProducts[index].id,
        quantity,
        index
      );
    } else {
      return await addToCart(product_id, quantity);
    }
  };

  const removeFromCart = async (cart_id) => {
    try {
      if (state.userInfo) {
        const cartData = await apiDeleteCartItem(
          cart_id,
          state.userInfo.access_token
        );
        state.cartProducts = state.cartProducts.filter(
          (cart) => cart.id !== cart_id
        );
        localStorage.setItem(
          "cartProducts",
          JSON.stringify(state.cartProducts)
        );
      }
    } catch (error) {
      console.error(error);
    }
  };

  const fetchWishlist = async () => {
    try {
      if (state.userInfo) {
        const wishlistData = await apiFetchWishlist(
          state.userInfo.user_id,
          state.userInfo.access_token
        );
        state.wishlistProducts = wishlistData;
        localStorage.setItem("wishlistProducts", JSON.stringify(wishlistData));
      }
    } catch (error) {
      console.error(error);
    }
  };

  const addToWishlist = async (product_id) => {
    const item = {
      // Initialize item here
      user_id: state.userInfo.user_id,
      product_id: product_id,
    };

    try {
      if (state.userInfo) {
        const wishlistData = await apiAddWishlistItem(item, state.userInfo);
        state.wishlistProducts.push(wishlistData);
        localStorage.setItem(
          "wishlistProducts",
          JSON.stringify(state.wishlistProducts)
        );
      }
    } catch (error) {
      console.error(error);
    }
  };

  const removeFromWishlist = async (wishlist_id) => {
    try {
      if (state.userInfo) {
        const wishlistData = await apiDeleteWishlistItem(
          wishlist_id,
          state.userInfo.access_token
        );
        state.wishlistProducts = state.wishlistProducts.filter(
          (wishlist) => wishlist.id !== wishlist_id
        );
        localStorage.setItem(
          "wishlistProducts",
          JSON.stringify(state.wishlistProducts)
        );
      }
    } catch (error) {
      console.error(error);
    }
  };

  return {
    state,
    login,
    register,
    logout,
    fetchCarts,
    findProductInCart,
    addOrUpdate,
    addOrUpdateCart,
    removeFromCart,
    fetchWishlist,
    addToWishlist,
    removeFromWishlist,
    setSelectedItems,
    fetchUserAddress,
    setUserAddress,
  };
};
