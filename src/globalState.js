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
  addTransaction as apiAddTransaction,
  fetchTransactions as apiFetchTransactions,
  fetchTransactionByInvoice as apiFetchTransactionByInvoice,
  fetchTransactionDetails as apiFetchTransactionDetails,
  fetchAllTransactionDetails as apiFetchAllTransactionDetails,
  getAddress as apiGetAddress,
  createAddress as apiCreateAddress,
  createPayment as apiCreatePayment,
  getPayment as apiGetPayment,
  getPaymentsByTransaction as apiGetPaymentsByTransaction,
  updatePaymentStatus as apiUpdatePaymentStatus,
  updateTransaction as apiUpdateTransaction,
} from "@/api/api";

const state = reactive({
  userInfo: JSON.parse(localStorage.getItem("userInfo")) || null,
  userAddress: JSON.parse(localStorage.getItem("userAddress")) || null,
  cartProducts: JSON.parse(localStorage.getItem("cartProducts")) || [],
  wishlistProducts: JSON.parse(localStorage.getItem("wishlistProducts")) || [],
  transactions: JSON.parse(localStorage.getItem("transactions")) || [],
  transactionsDetails:
    JSON.parse(localStorage.getItem("transactionsDetails")) || [],
  payments: JSON.parse(localStorage.getItem("payments")) || [],
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
      state.userAddress = userAddress[0];
      localStorage.setItem("userAddress", JSON.stringify(userAddress[0]));
      state.isAuthenticated = true;
    } catch (error) {
      console.error(error);
    }
  };

  const register = async (username, email, password, address) => {
    try {
      return await apiRegister(username, email, password, address);
    } catch (error) {
      throw error;
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

  const addTransaction = async (transaction, details, cartItems) => {
    // console.log(transaction);
    // console.log(cartItems);
    try {
      if (state.userInfo) {
        const transactionData = await apiAddTransaction(transaction, details, cartItems, state.userInfo);

        state.transactions.push(transactionData);
        localStorage.setItem(
          "transactions",
          JSON.stringify(state.transactions)
        );

        await fetchCarts();
        // await fetchTransactionDetails(transactionData.id);

        return transactionData;
      }
    } catch (error) {
      console.error(error);
    }
  };

  const fetchTransactions = async (user_id) => {
    try {
      if (state.userInfo) {
        const transactionsData = await apiFetchTransactions(
          user_id,
          state.userInfo
        );
        state.transactions = transactionsData;
        localStorage.setItem("transactions", JSON.stringify(transactionsData));

        return transactionsData;
      }
    } catch (error) {
      console.error(error);
    }
  };

  const fetchTransactionByInvoice = async (invoice) => {
    try {
      if (state.userInfo) {
        const transactionData = await apiFetchTransactionByInvoice(
          invoice,
          state.userInfo
        );

        return transactionData;
      }
    } catch (error) {
      console.error(error);
    }
  };

  const fetchTransactionDetails = async (transaction_id) => {
    try {
      if (state.userInfo) {
        const transactionDetailsData = await apiFetchTransactionDetails(
          transaction_id,
          state.userInfo
        );
        // state.transactionsDetails = transactionDetailsData;
        // localStorage.setItem("transactionsDetails", JSON.stringify(transactionDetailsData));

        return transactionDetailsData;
      }
    } catch (error) {
      console.error(error);
    }
  };

  const fetchAllTransactionDetails = async (user_id) => {
    try {
      if (state.userInfo) {
        const transactionDetailsData = await apiFetchAllTransactionDetails(
          user_id,
          state.userInfo
        );
        // state.transactionsDetails = transactionDetailsData;
        // localStorage.setItem("transactionsDetails", JSON.stringify(transactionDetailsData));

        return transactionDetailsData;
      }
    } catch (error) {
      console.error(error);
    }
  };

  const updateTransaction = async (transaction_id, transactionDetails) => {
    try {
      const updatedTransaction = await apiUpdateTransaction(
        transaction_id,
        transactionDetails,
        state.userInfo.access_token
      );
      const index = state.transactions.findIndex(
        (transaction) => transaction.id === transaction_id,
      );
      if (index !== -1) {
        state.transactions[index] = updatedTransaction;
        localStorage.setItem(
          "transactions",
          JSON.stringify(state.transactions)
        );
      }
      return updatedTransaction;
    } catch (error) {
      console.error("Failed to update transaction:", error);
      throw error;
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

    const createPayment = async (paymentDetails) => {
      try {
        const payment = await apiCreatePayment(
          paymentDetails,
          state.userInfo.access_token
        );
        state.payments.push(payment);
        localStorage.setItem("payments", JSON.stringify(state.payments));
        return payment;
      } catch (error) {
        console.error("Failed to create payment:", error);
      }
    };

    const getPayment = async (paymentId) => {
      try {
        const payment = await apiGetPayment(
          paymentId,
          state.userInfo.access_token
        );
        return payment;
      } catch (error) {
        console.error("Failed to get payment:", error);
      }
    };

    const getPaymentsByTransaction = async (transactionId) => {
      try {
        const payments = await apiGetPaymentsByTransaction(
          transactionId,
          state.userInfo.access_token
        );
        state.payments = payments;
        localStorage.setItem("payments", JSON.stringify(payments));
        return payments;
      } catch (error) {
        console.error("Failed to get payments by transaction:", error);
      }
    };

    const updatePaymentStatus = async (paymentId, status) => {
      try {
        const updatedPayment = await apiUpdatePaymentStatus(
          paymentId,
          status,
          state.userInfo.access_token
        );
        const index = state.payments.findIndex(
          (payment) => payment.id === paymentId
        );
        if (index !== -1) {
          state.payments[index] = updatedPayment;
          localStorage.setItem("payments", JSON.stringify(state.payments));
        }
        return updatedPayment;
      } catch (error) {
        console.error("Failed to update payment status:", error);
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
    addTransaction,
    fetchTransactions,
    fetchTransactionByInvoice,
    fetchTransactionDetails,
    fetchAllTransactionDetails,
    setSelectedItems,
    fetchUserAddress,
    setUserAddress,
    createPayment,
    getPayment,
    getPaymentsByTransaction,
    updatePaymentStatus,
    updateTransaction,
  };
};
