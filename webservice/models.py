import datetime
from database import BaseDB
from sqlalchemy import Boolean, Column, ForeignKey, Integer, String, Date, Float, Text, Enum, Time, DateTime, DECIMAL
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from enum import Enum as PyEnum
# from sqlalchemy.orm import Mapped
# from typing import List
# from sqlalchemy import Table
# from sqlalchemy import DateTime

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
    # id_dokter = Column(Integer, primary_key=True, index=True)
    # nama_lengkap_dokter = Column(String(127), nullable=False)
    # spesialisasi_dokter = Column(String(32), nullable=False)
    # lama_pengalaman_dokter = Column(Integer, nullable=False)
    # alumnus_dokter = Column(String(64), nullable=False)
    # harga_dokter = Column(Integer, nullable=False)
    # minat_klinis_dokter = Column(String(255), nullable=False)
    # foto_dokter = Column(String(512), nullable=False)
    # rating_dokter = Column(Float, nullable=False)
    # id_poli = Column(Integer, ForeignKey('poli.id_poli'), nullable=False)
    # janji_temu = relationship("JanjiTemu",back_populates="dokter")
    # poli = relationship("Poli", back_populates="dokter")

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
    # id_user = Column(Integer, primary_key=True, index=True)
    # nama_lengkap_user = Column(String(127), nullable=False)
    # tgl_lahir_user = Column(Date, nullable=False)
    # gender_user = Column(String(1), nullable=False)
    # alamat_user = Column(String(255), nullable=False)
    # no_bpjs_user = Column(String(18), nullable=False)
    # no_telp_user = Column(String(16), nullable=False)
    # email_user = Column(String(127), nullable=False)
    # password_user = Column(String(128), nullable=False)
    # foto_user = Column(String(512), nullable=False)
    # janji_temu = relationship("JanjiTemu", back_populates="user")
    # pengingat_minum_obat = relationship("PengingatMinumObat", back_populates="user")


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