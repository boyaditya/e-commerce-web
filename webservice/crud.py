from sqlalchemy.orm import Session
import models, schemas
import bcrypt
from sqlalchemy import desc

SALT = b'$2b$12$0nFckzktMD0Fb16a8JsNA.'

def get_user(db: Session, id_user: int):
    return db.query(models.Users).filter(models.Users.id == id_user).first()

def get_user_by_email(db: Session, email: str):
    return db.query(models.Users).filter(models.Users.email == email).first()


def get_addresses_by_user_id(db: Session, user_id: int):
    return db.query(models.Address).filter(models.Address.user_id == user_id).all()


def create_address(db: Session, address: schemas.AddressCreate):
    db_address = models.Address(
        user_id=address.user_id,
        recipients_name=address.recipients_name,
        phone_number=address.phone_number,
        street_address=address.street_address,
        city=address.city,
        state=address.state,
        postal_code=address.postal_code,
        country=address.country,
    )
    db.add(db_address)
    db.commit()
    db.refresh(db_address)
    return db_address


# def get_user_by_no_telp(db: Session, no_telp: str):
#     return db.query(models.Users).filter(models.Users.no_telp_user == no_telp).first()

# def get_users(db: Session, skip: int = 0, limit: int = 100):
#     return db.query(models.Users).offset(skip).limit(limit).all()

def get_products(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Products).offset(skip).limit(limit).all()

def get_product_by_id(db: Session, product_id: int):
    return db.query(models.Products).filter(models.Products.id == product_id).first()

def get_cart(db: Session, user_id: int):
    return db.query(models.Carts).filter(models.Carts.user_id == user_id).all()

def get_wishlist(db: Session, user_id: int):
    return db.query(models.Wishlists).filter(models.Wishlists.user_id == user_id).all()

def get_categories(db: Session):
    return db.query(models.Categories).all()

def get_category_by_id(db: Session, category_id: int):
    return (
        db.query(models.Categories).filter(models.Categories.id == category_id).first()
    )


def get_products_by_category(
    db: Session, category_id: int, skip: int = 0, limit: int = 100
):
    return (
        db.query(models.Products)
        .filter(models.Products.category_id == category_id)
        .offset(skip)
        .limit(limit)
        .all()
    )


# def get_item(db: Session, id_user: int):
#     return db.query(models.Relasi).filter(models.Relasi.id_user == id_user).all()

def get_relasi_by_id(db: Session, id_relasi: int):
    return db.query(models.Relasi).filter(models.Relasi.id_relasi == id_relasi).first()

# def get_dokter(db: Session, skip: int = 0, limit: int = 100):
#     return db.query(models.Dokter).offset(skip).limit(limit).all()

# def get_dokter_by_id(db: Session, id_dokter: int):
#     return db.query(models.Dokter).filter(models.Dokter.id_dokter == id_dokter).first()

# def get_obat(db: Session, skip: int = 0, limit: int = 100):
#     return db.query(models.Obat).offset(skip).limit(limit).all()

# def get_obat_by_id(db: Session, id_obat: int):
#     return db.query(models.Obat).join(models.JenisObat).filter(models.Obat.id_obat == id_obat).first()

# def get_jenis_obat_by_id(db: Session, id_jenis_obat: int):
#     return db.query(models.JenisObat).filter(models.JenisObat.id_jenis_obat == id_jenis_obat).first()

# def get_jadwal_dokter(db: Session, skip: int = 0, limit: int = 100):
#     return db.query(models.JadwalDokter).offset(skip).limit(limit).all()

# def get_jadwal_dokter_by_id(db: Session, id_dokter: int):
#     return db.query(models.JadwalDokter).filter(models.JadwalDokter.id_dokter == id_dokter).order_by(models.JadwalDokter.tanggal_jadwal_dokter).all()

# def get_janji_temu(db: Session, id_user: int):
#     return db.query(models.JanjiTemu).filter(models.JanjiTemu.id_user == id_user).filter(models.JanjiTemu.status != "Selesai").order_by(models.JanjiTemu.tgl_janji_temu).all()

# def get_janji_temu_by_id(db: Session, id_janji_temu: int):
#     return db.query(models.JanjiTemu).filter(models.JanjiTemu.id_janji_temu == id_janji_temu).first()

# def alter_status(db: Session, id_janji_temu: int):
#     return db.query(models.JanjiTemu).filter(models.JanjiTemu.id_janji_temu == id_janji_temu)

# def get_pengingat_minum_obat(db: Session, skip: int = 0, limit: int = 100):
#     return db.query(models.PengingatMinumObat).join(models.Obat).join(models.User).offset(skip).limit(limit).all()
def get_pengingat_minum_obat(db: Session, id_user: int):
    return db.query(models.PengingatMinumObat).filter(models.PengingatMinumObat.id_user == id_user).all()

def get_pengingat_minum_obat_by_id(db: Session, id_pengingat: int):
    return db.query(models.PengingatMinumObat).filter(models.PengingatMinumObat.id_pengingat == id_pengingat).first()

def hashPassword(passwd: str):
    bytePwd = passwd.encode('utf-8')
    pwd_hash = bcrypt.hashpw(bytePwd, SALT).decode('utf-8')
    print(pwd_hash)
    return pwd_hash


# #==============

######### user

def register_email(db: Session, user: schemas.UserCreate):
    hashed_password = hashPassword(user.password)
    db_user = models.Users(
        username = user.username,
        email = user.email,
        password = hashed_password
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

# def update_user(db: Session, id_user: int, user_update: schemas.UserBase):
#     db_user = db.query(models.User).filter(models.User.id_user == id_user).first()

#     if not db_user:
#         return None

#     update_data = user_update.model_dump()

#     for key, value in update_data.items():
#         setattr(db_user, key, value)

#     db.commit()
#     db.refresh(db_user)

#     return db_user

# def update_password(db: Session, id_user: int, newPassword: str):
#     db_user = db.query(models.User).filter(models.User.id_user == id_user).first()
#     if not db_user:
#         return None

#     hashed_password = hashPassword(newPassword)
#     db_user.password_user = hashed_password
#     db.commit()
#     db.refresh(db_user)
#     return db_user

## cart
def add_cart_item(db: Session, carts: schemas.CartsCreate):
    db_carts = models.Carts(
        user_id = carts.user_id,
        product_id = carts.product_id,
        quantity = carts.quantity,
    )
    db.add(db_carts)
    db.commit()
    db.refresh(db_carts)
    return db_carts

def delete_cart_item(db: Session, cart_id: int):
    deleted = db.query(models.Carts).filter(models.Carts.id == cart_id).delete()
    db.commit()
    return deleted

def update_cart_item(db: Session, cart: models.Carts, quantity):
    cart.quantity = quantity
    db.commit()
    db.refresh(cart)
    return cart

def get_cart_by_id(db: Session, id: int):
    return db.query(models.Carts).filter(models.Carts.id == id).first()

## wishlist
def add_wishlist_item(db: Session, wishlists: schemas.WishlistsCreate):
    db_wishlists = models.Wishlists(
        user_id = wishlists.user_id,
        product_id = wishlists.product_id,
    )
    db.add(db_wishlists)
    db.commit()
    db.refresh(db_wishlists)
    return db_wishlists

def delete_wishlist_item(db: Session, wishlist_id: int):
    deleted = db.query(models.Wishlists).filter(models.Wishlists.id == wishlist_id).delete()
    db.commit()
    return deleted

# ## dokter
# def create_dokter(db: Session, dokter: schemas.DokterCreate):
#     db_dokter = models.Dokter(
#         nama_lengkap_dokter=dokter.nama_lengkap_dokter,
#         spesialisasi_dokter=dokter.spesialisasi_dokter,
#         lama_pengalaman_dokter=dokter.lama_pengalaman_dokter,
#         alumnus_dokter=dokter.alumnus_dokter,
#         harga_dokter=dokter.harga_dokter,
#         minat_klinis_dokter=dokter.minat_klinis_dokter,
#         foto_dokter=dokter.foto_dokter,
#         rating_dokter=dokter.rating_dokter,
#         id_poli=dokter.id_poli,
#     )
#     db.add(db_dokter)
#     db.commit()
#     db.refresh(db_dokter)
#     return db_dokter

# def delete_dokter_by_id(db: Session, id_dokter: int):
#     hasil = db.query(models.Dokter).filter(models.Dokter.id_dokter == id_dokter).delete()
#     db.commit()
#     return {"record_dihapus":hasil}

# ## obat
# def create_obat(db: Session, obat: schemas.ObatCreate):
#     db_obat = models.Obat(
#         nama_obat=obat.nama_obat,
#         deskripsi_obat=obat.deskripsi_obat,
#         komposisi_obat=obat.komposisi_obat,
#         dosis_obat=obat.dosis_obat,
#         peringatan_obat=obat.peringatan_obat,
#         efek_samping_obat=obat.efek_samping_obat,
#         foto_obat=obat.foto_obat,
#         id_jenis_obat=obat.id_jenis_obat,
#     )
#     db.add(db_obat)
#     db.commit()
#     db.refresh(db_obat)
#     return db_obat

# def delete_obat_by_id(db: Session, id_obat: int):
#     hasil = db.query(models.Obat).filter(models.Obat.id_obat == id_obat).delete()
#     db.commit()
#     return {"record_dihapus":hasil}

# ## janji_temu
# def create_janji_temu(db: Session, janji_temu: schemas.JanjiTemuCreate):
#     db_janji_temu = models.JanjiTemu(
#         kode_janji_temu = janji_temu.kode_janji_temu,
#         tgl_janji_temu = janji_temu.tgl_janji_temu,
#         id_dokter = janji_temu.id_dokter,
#         id_user = janji_temu.id_user,
#         is_relasi = janji_temu.is_relasi,
#         id_relasi = janji_temu.id_relasi,
#         biaya_janji_temu = janji_temu.biaya_janji_temu,
#         id_janji_temu_as_orang_lain = janji_temu.id_janji_temu_as_orang_lain,
#         status = janji_temu.status
#     )
#     db.add(db_janji_temu)
#     db.commit()
#     db.refresh(db_janji_temu)
#     return db_janji_temu

# def alter_status(db: Session, id_janji_temu: int):
#     # Fetch the current JanjiTemu record
#     janji_temu = db.query(models.JanjiTemu).filter(models.JanjiTemu.id_janji_temu == id_janji_temu).one()

#     # Define the sequence of status values
#     status_sequence = [
#         models.StatusEnum.MENUNGGU_AMBIL_ANTRIAN,
#         models.StatusEnum.MENUNGGU_ANTRIAN,
#         models.StatusEnum.DALAM_SESI,
#         models.StatusEnum.MENUNGGU_PEMBAYARAN,
#         models.StatusEnum.SELESAI
#     ]

#     # Get the current status
#     current_status = janji_temu.status

#     # Determine the next status value
#     if current_status in status_sequence:
#         current_index = status_sequence.index(current_status)
#         if current_index < len(status_sequence) - 1:
#             new_status = status_sequence[current_index + 1]
#         else:
#             new_status = status_sequence[current_index]  # Already at the last status, no change
#     else:
#         new_status = status_sequence[0]  # Default to the first status if current status is invalid

#     # Update the status
#     janji_temu.status = new_status

#     # Commit the transaction
#     db.commit()

#     # Refresh the instance to reflect changes
#     db.refresh(janji_temu)

#     return janji_temu

# ## janji_temu
# def create_janji_temu_as_orang_lain(db: Session, janji_temu_as_orang_lain: schemas.JanjiTemuAsOrangLainCreate):
#     db_janji_temu_as_orang_lain = models.JanjiTemuAsOrangLain(
#         nama_lengkap_orang_lain = janji_temu_as_orang_lain.nama_lengkap_orang_lain,
#         no_bpjs_orang_lain = janji_temu_as_orang_lain.no_bpjs_orang_lain,
#         tgl_lahir_orang_lain = janji_temu_as_orang_lain.tgl_lahir_orang_lain,
#         gender_orang_lain = janji_temu_as_orang_lain.gender_orang_lain,
#         no_telp_orang_lain = janji_temu_as_orang_lain.no_telp_orang_lain,
#         alamat_orang_lain = janji_temu_as_orang_lain.alamat_orang_lain,
#     )
#     db.add(db_janji_temu_as_orang_lain)
#     db.commit()
#     db.refresh(db_janji_temu_as_orang_lain)
#     return db_janji_temu_as_orang_lain

# def delete_janji_temu_by_id(db: Session, id_janji_temu: int):
#     hasil = db.query(models.JanjiTemu).filter(models.JanjiTemu.id_janji_temu == id_janji_temu).delete()
#     db.commit()
#     return {"record_dihapus":hasil}

# ## pengingat_minum_obat
# def create_pengingat_minum_obat(db: Session, pengingat_minum_obat: schemas.PengingatMinumObatCreate):
#     db_pengingat_minum_obat = models.PengingatMinumObat(
#         id_obat = pengingat_minum_obat.id_obat,
#         id_user = pengingat_minum_obat.id_user,
#         dosis = pengingat_minum_obat.dosis,
#         sendok = pengingat_minum_obat.sendok,
#         jadwal = pengingat_minum_obat.jadwal,
#         aturan = pengingat_minum_obat.aturan,
#     )
#     db.add(db_pengingat_minum_obat)
#     db.commit()
#     db.refresh(db_pengingat_minum_obat)
#     return db_pengingat_minum_obat


# def get_rekam_medis_by_id(db: Session, rekam_medis_id: int):
#     return db.query(models.RekamMedis).filter(models.RekamMedis.id_rekam_medis == rekam_medis_id).first()

# def get_rekam_medis_selesai_by_user(db: Session, user_id: int):
#     return db.query(models.RekamMedis).join(models.RekamMedis.janji_temu).filter(models.JanjiTemu.id_user == user_id, models.JanjiTemu.status == "Selesai").all()

# # def get_rekam_medis_selesai_by_user(db: Session, user_id: int):
# #     return db.query(models.RekamMedis).join(models.JanjiTemu, models.JanjiTemu.id_janji_temu == models.RekamMedis.id_janji_temu).filter(
# #         models.JanjiTemu.id_user == user_id,
# #         models.JanjiTemu.status == 'Selesai'
# #     ).all()

# # ##==================== item

# # # ambil semua item
# # def get_items(db: Session, skip: int = 0, limit: int = 100):
# #     return db.query(models.Item).offset(skip).limit(limit).all()

# # # ambil item dengan id tertentu
# # def get_item_by_id(db: Session, item_id: int):
# #     return db.query(models.Item).filter(models.Item.id == item_id).first()


# # # ambil item yang cocok dengan keyword di deskripsi
# # def get_item_by_keyword(db: Session, keyword: str):
# #     #Artikel.Benennung.like("%"+prop+"%")
# #     return db.query(models.Item).filter(models.Item.description.ilike("%"+keyword+"%")).all()
# #     #return db.query(models.Item).filter(models.Item.like("%"+keyword+"%")).first()


# # # tambah item
# # def create_item(db: Session, item: schemas.ItemBase):
# #     db_item = models.Item(title=item.title, description = item.description, price = item.price, img_name = item.img_name )
# #     db.add(db_item)
# #     db.commit()
# #     db.refresh(db_item)
# #     return db_item


# # # delete semua item
# # def delete_all_item(db: Session):
# #     jum_rec = db.query(models.Item).delete()
# #     db.commit()
# #     return jum_rec


# # # gagal euy
# # # def insert_cart(db:Session, cart: schemas.CartBase ):
# # #     #cart_record = models.Cart(user_id=cart.user_id, item_id=cart.item_id, quantity = cart.quantity)
# # #     user = db.query(models.User).filter_by(id=cart.user_id).first()
# # #     # Next, fetch the item from the database
# # #     item = db.query(models.Item).filter_by(id=cart.item_id).first()
# # #     # Append the item to the user's cart
# # #     user.cart.append(item)
# # #     #db.add(cart_record)
# # #     db.commit()
# # #     #db.refresh(cart_record)
# # #     return user
