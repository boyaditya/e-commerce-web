# 🌟 Ardhicom (Gaming Peripheral E-Commerce Website)

This is an e-commerce website for selling gaming peripherals. The project was created as a final assignment for the **E-Business** course at our university. It is built using **Vue.js**, **FastAPI**, and **MySQL**.

## 🚀 Features

### 🔒 **Authentication**
- User Login
- User Registration
- Logout

### 🏠 **User Profile**
- Add Shipping Address
- Edit Shipping Address

### 🛒 **Product Management**
- Search Products
- Filter Products by Category
- Sort Products

### 💖 **Wishlist**
- Add Products to Wishlist
- View Wishlist

### 🛍️ **Shopping Cart**
- Add Products to Cart
- Remove Products from Cart
- Adjust Product Quantity in Cart

### 💳 **Checkout and Payment**
- Select Products from Cart for Checkout
- Choose Payment Method
- Complete Payment

### 📜 **Transaction History**
- View Transaction History
- View Transaction Details


## 🛠️ Tech Stack

- **Frontend**: Vue.js
- **Backend**: FastAPI
- **Database**: MySQL

## ⚙️ Installation

Follow these steps to set up the project locally:

### Prerequisites
Ensure you have the following installed:
- Node.js (for Vue.js)
- Python 3.8+ (for FastAPI)
- MySQL Server

### Clone the Repository
```bash
git clone https://github.com/boyaditya/vue-ecommerce-web
cd ecommerce-website
```

### Backend Setup
1. Navigate to the `webservice` folder:
   ```bash
   cd webservice
   ```
2. Import the database:
   - Locate the SQL file in the `database` folder.
   - Use your preferred MySQL client to import the database:
     ```bash
     mysql -u username -p database_name < path/to/database.sql
     ```
3. Start the FastAPI server:
   ```bash
   uvicorn main:app --reload
   ```
 
### Frontend Setup
1. Install dependencies:
   ```bash
   npm install
   ```
2. Start the development server:
   ```bash
   npm run serve
   ```

## 🎯 Usage

1. Open the frontend in your browser at `http://localhost:8080` (default Vue.js port).
2. Access the backend API at `http://127.0.0.1:8000` (default FastAPI port).
3. Register a new account, browse products, add to your wishlist or cart, and complete a purchase.


## 📸 Screenshot
### Home Page
![screencapture-localhost-8080-2025-01-13-12_42_57](https://github.com/user-attachments/assets/0cabffb7-f1be-4f55-941b-b66845a32a8d)
### Store Page
![screencapture-localhost-8081-store-2025-01-13-13_47_39](https://github.com/user-attachments/assets/87fa6c41-d187-4efc-a68e-f791054037da)
### Product Details
![screencapture-localhost-8081-product-9-2025-01-13-13_49_13](https://github.com/user-attachments/assets/a2e04200-f905-438a-a5df-32407d36b13f)
### Cart
![image](https://github.com/user-attachments/assets/e148db56-6604-492d-a22d-8b5be8616d66)
![image](https://github.com/user-attachments/assets/29f0423c-6e43-4a87-ba8b-d3f379c26a35)
### Wishlist
![image](https://github.com/user-attachments/assets/97fff089-660f-4fd4-a0ec-5b7ae8d41398)
### Checkout
![screencapture-localhost-8081-checkout-2025-01-13-14_40_52](https://github.com/user-attachments/assets/7011b806-739b-4ff9-84fa-d2ea171b5112)
### Payment
![screencapture-localhost-8081-payment-va-bni-101-54-2025-01-13-14_42_22](https://github.com/user-attachments/assets/b3987d4d-e77e-4035-a2d2-23cd5f9356e7)
### Order History
![screencapture-localhost-8081-user-order-history-2025-01-13-14_45_35](https://github.com/user-attachments/assets/046a94a5-2f80-471c-9b11-cf5ca8cd2c0d)
### Order Detail
![screencapture-localhost-8081-order-detail-INV-20250113-000003-2025-01-13-14_50_52](https://github.com/user-attachments/assets/b86f6c14-d513-4655-9955-a58311283392)
### Profile
![screencapture-localhost-8081-user-profile-2025-01-13-14_51_49](https://github.com/user-attachments/assets/ae9ca5a5-08a3-4588-bc54-16bf09e538e5)
### Edit Shipping Address
![screencapture-localhost-8081-user-address-2025-01-13-14_57_24](https://github.com/user-attachments/assets/da440305-5e77-4cbe-814e-de2335e4d25f)

## 🤓 Author(s)
- @boyaditya
- @aryaayy
- @RaffiArdhiN
- @rafiealhabsyi

## ✋ Acknowledgement
- Website Template: [colorlib](https://themewagon.com/themes/free-bootstrap-ecommerce-template-electro/)


## 📜 License
This project is licensed under the **MIT License**. See the `LICENSE` file for details.
