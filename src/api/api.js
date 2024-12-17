import axios from "axios";

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

