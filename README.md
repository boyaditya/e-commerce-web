# E-commerce Website for Gaming Peripherals

Welcome to the repository for our **E-commerce Website** that specializes in selling gaming peripherals. This project is built using **Vue.js** for the frontend, **FastAPI** for the backend, and **MySQL** for the database.

## Features

- **Authentication**
  - User Login
  - User Registration
  - Logout

- **User Profile**
  - Add Shipping Address
  - Edit Shipping Address

- **Product Management**
  - Search Products
  - Filter Products by Category
  - Sort Products

- **Wishlist**
  - Add to Wishlist
  - View Wishlist

- **Shopping Cart**
  - Add Products to Cart
  - Remove Products from Cart
  - Adjust Product Quantity in Cart

- **Checkout and Payment**
  - Select Products from Cart for Checkout
  - Choose Payment Method
  - Complete Payment

- **Transaction History**
  - View Transaction History
  - View Transaction Details

## Tech Stack

- **Frontend**: Vue.js
- **Backend**: FastAPI
- **Database**: MySQL

## Installation

Follow these steps to set up the project locally:

### Prerequisites
- Node.js (for Vue.js)
- Python 3.8+ (for FastAPI)
- MySQL Server

### Clone the Repository
```bash
git clone https://github.com/yourusername/ecommerce-website.git
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
   
### Database Setup
1. Ensure MySQL Server is running.
2. Import the provided SQL file as mentioned in the Backend Setup.
3. Update the database configuration in the backend's `database.py` file.

### Frontend Setup
1. Install dependencies:
   ```bash
   npm install
   ```
2. Start the development server:
   ```bash
   npm run serve
   ```


## Usage
1. Open the frontend in your browser at `http://localhost:8080` (default Vue.js port).
2. The backend will be available at `http://127.0.0.1:8000/docs` (default FastAPI port).
3. Register a new account, browse products, add to your wishlist or cart, and complete a purchase.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

