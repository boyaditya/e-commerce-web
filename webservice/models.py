import datetime
from database import BaseDB
from sqlalchemy import Boolean, Column, ForeignKey, Integer, String, Date, Float, Text, Enum, Time, DateTime, DECIMAL
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from enum import Enum as PyEnum

class Products(BaseDB):
    __tablename__ = 'products'

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    description = Column(String(255), nullable=False)
    price = Column(Integer, nullable=False)
    stock = Column(Integer, nullable=False)
    category_id = Column(Integer, ForeignKey('categories.id'), nullable=False)
    category = relationship("Categories", back_populates="product")
    image_url = Column(String(255), nullable=False)
    created_at = Column(DateTime, nullable=False)
    updated_at = Column(DateTime, nullable=False)
    cart = relationship("Carts", back_populates="product")
    wishlist = relationship("Wishlists", back_populates="product")

class Categories(BaseDB):
    __tablename__ = 'categories'

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    description = Column(String(255), nullable=False)
    product = relationship("Products", back_populates="category")

class Users(BaseDB):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), nullable=False)
    email = Column(String(100), nullable=False)
    password = Column(String(255), nullable=False)
    is_admin = Column(Boolean, nullable=False, default=False)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())

class Address(BaseDB):
    __tablename__ = "addresses"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    recipients_name = Column(String(100), nullable=False)
    phone_number = Column(String(20), nullable=False)
    street_address = Column(String(255), nullable=False)
    city = Column(String(100), nullable=False)
    state = Column(String(100), nullable=True)
    postal_code = Column(String(20), nullable=False)
    country = Column(String(100), nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=func.now())    
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())

    transaction = relationship("Transaction", back_populates="address")


class Carts(BaseDB):
    __tablename__ = "carts"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey('users.id'), nullable=False)
    product_id = Column(Integer, ForeignKey('products.id'), nullable=False)
    product = relationship("Products", back_populates="cart")
    quantity = Column(Integer, nullable=False)
    created_at = Column(DateTime, nullable=False)
    updated_at = Column(DateTime, nullable=False)

class Wishlists(BaseDB):
    __tablename__ = "wishlists"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey('users.id'), nullable=False)
    product_id = Column(Integer, ForeignKey('products.id'), nullable=False)
    product = relationship("Products", back_populates="wishlist")
    created_at = Column(DateTime, nullable=False)
    updated_at = Column(DateTime, nullable=False)

class TransactionStatus(PyEnum):
    pending = "pending"
    paid = "paid"
    shipped = "shipped"
    completed = "completed"
    cancelled = "cancelled"


class Transaction(BaseDB):
    __tablename__ = "transactions"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    user_id = Column(Integer, nullable=True)
    address_id = Column(Integer, ForeignKey('addresses.id'), nullable=True)
    total = Column(DECIMAL(10, 2), nullable=False)
    transaction_date = Column(DateTime, server_default=func.now(), nullable=False)
    status = Column(String(255), default="Menunggu Pembayaran")
    invoice = Column(String(255), nullable=False)
    number = Column(Integer, nullable=False)
    payment_id = Column(Integer, nullable=True)
    approved_by = Column(Integer, nullable=True)
    approved_at = Column(DateTime, nullable=True)
    created_at = Column(DateTime, server_default=func.now(), nullable=False)

    details = relationship("TransactionDetail", back_populates="transaction")
    address = relationship("Address", back_populates="transaction")
    payments = relationship("Payments", back_populates="transaction")


class TransactionDetail(BaseDB):
    __tablename__ = "transaction_details"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    transaction_id = Column(Integer, ForeignKey("transactions.id"), nullable=True)
    product_id = Column(Integer, nullable=True)
    product_name = Column(String(255), nullable=True)
    product_price = Column(DECIMAL(10, 2), nullable=True)
    product_image_url = Column(String(255), nullable=True)
    product_category_id = Column(Integer, nullable=True)
    quantity = Column(Integer, nullable=False)
    total_price = Column(DECIMAL(10, 2), nullable=True)

    transaction = relationship("Transaction", back_populates="details")

class PaymentMethod(PyEnum):
    cod = "cod"
    va_bca = "va_bca"
    va_bni = "va_bni"
    va_mandiri = "va_mandiri"
    va_bri = "va_bri"
    va_permata = "va_permata"
    store_alfamart = "store_alfamart"
    store_indomaret = "store_indomaret"
class PaymentStatus(PyEnum):
    pending = "pending"
    verified = "verified"
    rejected = "rejected"

class Payments(BaseDB):
    __tablename__ = "payments"

    id = Column(Integer, primary_key=True, index=True)
    transaction_id = Column(Integer, ForeignKey("transactions.id"), nullable=True)
    amount = Column(DECIMAL(10, 2), nullable=False)
    payment_date = Column(DateTime, nullable=False, server_default=func.now())
    payment_method = Column(String(255), nullable=False)
    status = Column(String(255), nullable=True, default="pending")
    verified_by = Column(Integer, ForeignKey("users.id"), nullable=True)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())

    transaction = relationship("Transaction", back_populates="payments")