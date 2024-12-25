from database import BaseDB
from sqlalchemy import Boolean, Column, ForeignKey, Integer, String, Date, Float, Text, Enum, Time, DateTime
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

# class JadwalDokter(BaseDB):
#     __tablename__ = 'jadwal_dokter'

#     id_jadwal_dokter = Column(Integer, primary_key=True, index=True)
#     id_dokter = Column(Integer, ForeignKey('dokter.id_dokter'), nullable=False)
#     tanggal_jadwal_dokter = Column(Date, nullable=False)
#     is_full = Column(Integer, nullable=False)
#     start_time = Column(Time, nullable=False)
#     end_time = Column(Time, nullable=False)

# class PengingatMinumObat(BaseDB):
#     __tablename__ = 'pengingat_minum_obat'

#     id_pengingat = Column(Integer, primary_key=True, index=True)
#     id_obat = Column(Integer, ForeignKey('obat.id_obat'), nullable=False)
#     id_user = Column(Integer, ForeignKey('user.id_user'), nullable=False)
#     dosis = Column(Integer, nullable=False)
#     sendok = Column(String(50), nullable=False)
#     jadwal = Column(String(50), nullable=False)
#     aturan = Column(String(255), nullable=False)
#     obat = relationship("Obat", back_populates="pengingat_minum_obat")
#     user = relationship("User", back_populates="pengingat_minum_obat")
#     # nama_obat = relationship("Obat", back_populates="pengingat_minum_obat")
#     # foto_obat = relationship("Obat", back_populates="pengingat_minum_obat")

# class StatusEnum(PyEnum):
#     MENUNGGU_AMBIL_ANTRIAN = "Menunggu Ambil Antrian"
#     MENUNGGU_ANTRIAN = "Menunggu Antrian"
#     DALAM_SESI = "Dalam Sesi"
#     MENUNGGU_PEMBAYARAN = "Menunggu Pembayaran"
#     SELESAI = "Selesai"

# class JanjiTemu(BaseDB):
#     __tablename__ = 'janji_temu'

#     id_janji_temu = Column(Integer, primary_key=True, index=True)
#     kode_janji_temu = Column(String(255), nullable=False)
#     tgl_janji_temu = Column(Date, nullable=False)
#     id_dokter = Column(Integer, ForeignKey('dokter.id_dokter'), nullable=False)
#     id_user = Column(Integer, ForeignKey('user.id_user'), nullable=False)
#     is_relasi = Column(Boolean, nullable=False)
#     id_relasi = Column(Integer, ForeignKey('relasi.id_relasi'), nullable=False)
#     biaya_janji_temu = Column(Integer, nullable=False)
#     id_janji_temu_as_orang_lain = Column(Integer, ForeignKey('janji_temu_as_orang_lain.id_janji_temu_as_orang_lain'), nullable=False)
#     status = Column(Enum(StatusEnum, native_enum=False, values_callable=lambda x: [e.value for e in x]), nullable=False)
#     dokter = relationship("Dokter",back_populates="janji_temu")
#     user = relationship("User", back_populates="janji_temu")
#     relasi = relationship("Relasi", back_populates="janji_temu")
#     janji_temu_as_orang_lain = relationship("JanjiTemuAsOrangLain", back_populates="janji_temu")
#     rekam_medis = relationship("RekamMedis", back_populates="janji_temu")

# class JanjiTemuAsOrangLain(BaseDB):
#     __tablename__ = 'janji_temu_as_orang_lain'

#     id_janji_temu_as_orang_lain = Column(Integer, primary_key=True, index=True)
#     nama_lengkap_orang_lain = Column(String(127), nullable=False)
#     no_bpjs_orang_lain = Column(String(18), nullable=False)
#     tgl_lahir_orang_lain = Column(Date, nullable=False)
#     gender_orang_lain = Column(String(1), nullable=False)
#     no_telp_orang_lain = Column(String(18), nullable=False)
#     alamat_orang_lain = Column(String(255), nullable=False)
#     janji_temu = relationship("JanjiTemu", back_populates="janji_temu_as_orang_lain")

# class JenisObat(BaseDB):
#     __tablename__ = 'jenis_obat'

#     id_jenis_obat = Column(Integer, primary_key=True, index=True)
#     jenis_obat = Column(String(16), nullable=False)
#     obat = relationship("Obat",back_populates="jenis_obat")

# class Obat(BaseDB):
#     __tablename__ = 'obat'

#     id_obat = Column(Integer, primary_key=True, index=True)
#     nama_obat = Column(String(128), nullable=False)
#     deskripsi_obat = Column(String(128), nullable=False)
#     komposisi_obat = Column(Text, nullable=False)
#     dosis_obat = Column(String(128), nullable=False)
#     peringatan_obat = Column(Text, nullable=False)
#     efek_samping_obat = Column(Text, nullable=False)
#     foto_obat = Column(String(255), nullable=False)
#     id_jenis_obat = Column(Integer, ForeignKey('jenis_obat.id_jenis_obat'), nullable=False)
#     jenis_obat = relationship("JenisObat",back_populates="obat")
#     pengingat_minum_obat = relationship("PengingatMinumObat", back_populates="obat")
#     rekam_medis = relationship("RekamMedis", back_populates="obat")

# class Poli(BaseDB):
#     __tablename__ = 'poli'

#     id_poli = Column(Integer, primary_key=True, index=True)
#     nama_poli = Column(String(16), nullable=False)
#     dokter = relationship("Dokter", back_populates="poli")

# class Relasi(BaseDB):
#     __tablename__ = 'relasi'

#     id_relasi = Column(Integer, primary_key=True, index=True)
#     id_user = Column(Integer, ForeignKey('user.id_user'), nullable=False)
#     nama_lengkap_relasi = Column(String(128), nullable=False)
#     no_bpjs_relasi = Column(String(18), nullable=False)
#     tgl_lahir_relasi = Column(Date, nullable=False)
#     gender_relasi = Column(String(1), nullable=False)
#     no_telp_relasi = Column(String(18), nullable=False)
#     alamat_relasi = Column(String(128), nullable=False)
#     foto_relasi = Column(String(255), nullable=False)
#     tipe_relasi = Column(String(16), nullable=False)
#     janji_temu = relationship("JanjiTemu", back_populates="relasi")

# class Review(BaseDB):
#     __tablename__ = 'review'

#     id_review = Column(Integer, primary_key=True, index=True)
#     id_user = Column(Integer, ForeignKey('user.id_user'), nullable=False)
#     id_dokter = Column(Integer, ForeignKey('dokter.id_dokter'), nullable=False)
#     rating = Column(Integer, nullable=False)
#     review_content = Column(Text)

# class User(BaseDB):
#     __tablename__ = 'user'

#     id_user = Column(Integer, primary_key=True, index=True)
#     nama_lengkap_user = Column(String(127), nullable=False)
#     tgl_lahir_user = Column(Date, nullable=False)
#     gender_user = Column(String(1), nullable=False)
#     alamat_user = Column(String(255), nullable=False)
#     no_bpjs_user = Column(String(18), nullable=False)
#     no_telp_user = Column(String(16), nullable=False)
#     email_user = Column(String(127), nullable=False)
#     password_user = Column(String(128), nullable=False)
#     foto_user = Column(String(512), nullable=False)
#     janji_temu = relationship("JanjiTemu", back_populates="user")
#     pengingat_minum_obat = relationship("PengingatMinumObat", back_populates="user")
    
# class RekamMedis(BaseDB):
#     __tablename__ = 'rekam_medis'
    
#     id_rekam_medis = Column(Integer, primary_key=True, index=True)
#     id_janji_temu = Column(Integer, ForeignKey('janji_temu.id_janji_temu'), nullable=False)
#     id_obat = Column(Integer, ForeignKey('obat.id_obat'), nullable=False)
#     hasil_diagnosis = Column(Text, nullable=False)
#     pengobatan = Column(Text, nullable=False)
#     dosis_obat = Column(Text, nullable=False)
#     catatan = Column(Text, nullable=False)
    
#     janji_temu = relationship("JanjiTemu", back_populates="rekam_medis")
#     obat = relationship("Obat", back_populates="rekam_medis")