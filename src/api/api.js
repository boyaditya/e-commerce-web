import axios from "axios";



export async function register(username, email, password, address) {
  try {
    const response = await axios.post("http://127.0.0.1:8000/register_email", {
      username,
      email,
      password,
    });

    const userId = response.data.id;

    // Post the address data
    await createAddress(userId, address);

    return response;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function createAddress(userId, address) {
  try {
    const response = await axios.post("http://127.0.0.1:8000/addresses/", {
      user_id: userId,
      street_address: address.street_address,
      recipients_name: address.recipients_name,
      phone_number: address.phone_number,
      city: address.city,
      state: address.state,
      postal_code: address.postal_code,
      country: address.country,
    });

    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function getAddress(userId, accessToken) {
  try {
    const response = await axios.get(
      `http://127.0.0.1:8000/addresses/${userId}`,
      {
        headers: {
          Authorization: `Bearer ${accessToken}`,
        },
      }
    );

    console.log(response.data);
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}


export async function login(email, password) {
  try {
    const response = await axios.post("http://127.0.0.1:8000/login_email", {
      email,
      password,
    });
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function fetchUserById(userId, accessToken) {
  try {
    const response = await axios.get(
      `http://127.0.0.1:8000/get_user/${userId}`,
      {
        headers: {
          Authorization: `Bearer ${accessToken}`,
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function fetchCarts(userId, accessToken) {
  try {
    const response = await axios.get(`http://127.0.0.1:8000/get_cart/${userId}`, {
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    });
    return response.data
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function addCartItem(item, userInfo) {
  try {
    const response = await axios.post(
      "http://127.0.0.1:8000/add_cart_item",
      item,
      {
        headers: {
          Authorization: `Bearer ${userInfo.access_token}`,
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function updateCartItem(cart_id, cart, userInfo) {
  try {
    const response = await axios.put(
      `http://127.0.0.1:8000/update_cart_item/${cart_id}`,
      cart,
      {
        headers: {
          Authorization: `Bearer ${userInfo.access_token}`,
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function deleteCartItem(cart_id, accessToken) {
  try {
    const response = await axios.delete(`http://127.0.0.1:8000/delete_cart_item/${cart_id}`,
      {
        headers: {
          Authorization: `Bearer ${accessToken}`,
        },
      }
    );
    return response.data
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function fetchWishlist(userId, accessToken) {
  try {
    const response = await axios.get(`http://127.0.0.1:8000/get_wishlist/${userId}`, {
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    });
    return response.data
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function addWishlistItem(item, userInfo) {
  try {
    const response = await axios.post(
      "http://127.0.0.1:8000/add_wishlist_item",
      item,
      {
        headers: {
          Authorization: `Bearer ${userInfo.access_token}`,
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function deleteWishlistItem(wishlist_id, accessToken) {
  try {
    const response = await axios.delete(`http://127.0.0.1:8000/delete_wishlist_item/${wishlist_id}`,
      {
        headers: {
          Authorization: `Bearer ${accessToken}`,
        },
      }
    );
    return response.data
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function addTransaction(transaction, details, cart_items, userInfo) {
  try {
    const response = await axios.post(
      "http://127.0.0.1:8000/add_transaction",
      {
        transaction,
        details,
        cart_items
      },
      {
        headers: {
          Authorization: `Bearer ${userInfo.access_token}`,
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function fetchTransactions(user_id, userInfo) {
  try {
    const response = await axios.get(
      `http://127.0.0.1:8000/get_transactions/${user_id}`,
      {
        headers: {
          Authorization: `Bearer ${userInfo.access_token}`,
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function fetchTransactionByInvoice(invoice, userInfo) {
  // invoice = encodeURIComponent(invoice);
  try {
    const response = await axios.get(
      `http://127.0.0.1:8000/get_transaction_by_invoice?invoice=${invoice}`,
      {
        headers: {
          Authorization: `Bearer ${userInfo.access_token}`,
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function fetchTransactionDetails(transaction_id, userInfo) {
  try {
    const response = await axios.get(
      `http://127.0.0.1:8000/get_transaction_details/${transaction_id}`,
      {
        headers: {
          Authorization: `Bearer ${userInfo.access_token}`,
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function fetchAllTransactionDetails(user_id, userInfo) {
  try {
    const response = await axios.get(
      `http://127.0.0.1:8000/get_all_transaction_details/${user_id}`,
      {
        headers: {
          Authorization: `Bearer ${userInfo.access_token}`,
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function fetchAllProducts() {
  try {
    const response = await axios.get("http://127.0.0.1:8000/get_products");
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function fetchProductById(productId) {
  try {
    const response = await axios.get(
      `http://127.0.0.1:8000/product/${productId}`
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function fetchCategories() {
  try {
    const response = await axios.get("http://127.0.0.1:8000/get_categories");
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function fetchCategoryById(categoryId) {
  try {
    const response = await axios.get(
      `http://127.0.0.1:8000/get_category/${categoryId}`
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

// export async function fetchCarts() {
//   try {
//     const response = await axios.get("http://127.0.0.1:8000/get_cart/1", {
//       headers: {
//         Authorization: `Bearer ${this.userInfo.access_token}`,
//       },
//     });
//     return response.data;
//   } catch (error) {
//     console.error(error);
//     throw error;
//   }
// }

export async function fetchProductsByCategory(categoryId) {
  try {
    const response = await axios.get(
      `http://127.0.0.1:8000/get_products_by_category/${categoryId}`
    );
    return response.data;
  } catch (error) {
    if (error.response && error.response.status === 404) {
      return [];
    } else {
      console.error(error);
      throw error;
    }
  }
}


export async function createPayment(paymentDetails, token) {
  try {
    const response = await axios.post(
      "http://127.0.0.1:8000/payments/",
      paymentDetails,
      {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`, // Pass the token in the header
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}


export async function getPayment(paymentId, token) {
  try {
    const response = await axios.get(
      `http://127.0.0.1:8000/payments/${paymentId}`,
      {
        headers: {
          Authorization: `Bearer ${token}`, // Pass the token in the header
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function getPaymentsByTransaction(transactionId, token) {
  try {
    const response = await axios.get(
      `http://127.0.0.1:8000/payments/transaction/${transactionId}`,
      {
        headers: {
          Authorization: `Bearer ${token}`, // Pass the token in the header
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function updatePaymentStatus(paymentId, status, token) {
  try {
    const response = await axios.put(
      `http://127.0.0.1:8000/payments/${paymentId}`,
      { status },
      {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`, // Pass the token in the header
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}

export async function updateTransaction(
  transactionId,
  transactionDetails,
  token
) {
  try {
    const response = await axios.put(
      `http://127.0.0.1:8000/transactions/${transactionId}`,
      transactionDetails,
      {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`, // Pass the token in the header
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(error);
    throw error;
  }
}