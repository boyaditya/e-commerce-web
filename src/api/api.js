import axios from "axios";



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

export async function addCartItem(userInfo, product_id, quantity) {
  try {
    const response = await axios.post(
      "http://127.0.0.1:8000/add_cart_item",
      {
        user_id: userInfo.user_id,
        product_id: product_id,
        quantity: quantity,
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