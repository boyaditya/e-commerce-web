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

def get_relasi_by_id(db: Session, id_relasi: int):
    return db.query(models.Relasi).filter(models.Relasi.id_relasi == id_relasi).first()

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

## transaction
def add_transaction(db: Session, transaction: schemas.TransactionCreate, details: list[schemas.TransactionDetailCreate]):
    db_transaction = models.Transaction(
        user_id=transaction.user_id,
        address_id=transaction.address_id,
        total=transaction.total,
        status=transaction.status,
        invoice=transaction.invoice,
        number=transaction.number,
        payment_id=transaction.payment_id,
    )
    db.add(db_transaction)
    db.commit()
    db.refresh(db_transaction)

    # Add transaction details
    for detail in details:
        db_detail = models.TransactionDetail(
            transaction_id=db_transaction.id,
            product_id=detail.product_id,
            product_name=detail.product_name,
            product_price=detail.product_price,
            product_image_url=detail.product_image_url,
            product_category_id=detail.product_category_id,
            quantity=detail.quantity,
            total_price=detail.total_price,
        )
        db.add(db_detail)

    db.commit()
    return db_transaction

def get_transaction_by_invoice(db: Session, invoice: int):
    return db.query(models.Transaction).filter(models.Transaction.invoice == invoice).first()

def get_transactions(db: Session, user_id: int):
    return db.query(models.Transaction).filter(models.Transaction.user_id == user_id).order_by(models.Transaction.created_at.desc()).all()

def get_transaction_details(db: Session, transaction_id: int):
    return db.query(models.TransactionDetail).filter(models.TransactionDetail.transaction_id == transaction_id).all()

def get_all_transaction_details(db: Session, user_id: int):
    return db.query(models.TransactionDetail).join(models.Transaction).filter(models.Transaction.user_id == user_id).all()


def get_transaction_by_id(db: Session, transaction_id: int):
    return (
        db.query(models.Transaction)
        .filter(models.Transaction.id == transaction_id)
        .first()
    )


def update_transaction(
    db: Session,
    db_transaction: models.Transaction,
    transaction_update: schemas.TransactionUpdate,
):
    if transaction_update.payment_id is not None:
        db_transaction.payment_id = transaction_update.payment_id
    if transaction_update.status is not None:
        db_transaction.status = transaction_update.status
    db.commit()
    db.refresh(db_transaction)
    return db_transaction


## payment


def create_payment(db: Session, payment: schemas.PaymentsCreate):
    db_payment = models.Payments(
        transaction_id=payment.transaction_id,
        amount=payment.amount,
        payment_date=payment.payment_date,
        payment_method=payment.payment_method,
        status=payment.status,
        verified_by=payment.verified_by,
    )
    db.add(db_payment)
    db.commit()
    db.refresh(db_payment)
    return db_payment


def get_payment_by_id(db: Session, payment_id: int):
    return db.query(models.Payments).filter(models.Payments.id == payment_id).first()


def get_payments_by_transaction_id(db: Session, transaction_id: int):
    return (
        db.query(models.Payments)
        .filter(models.Payments.transaction_id == transaction_id)
        .all()
    )


def update_payment_status(db: Session, payment_id: int, status: str):
    db_payment = (
        db.query(models.Payments).filter(models.Payments.id == payment_id).first()
    )
    if db_payment:
        db_payment.status = status
        db.commit()
        db.refresh(db_payment)
    return db_payment