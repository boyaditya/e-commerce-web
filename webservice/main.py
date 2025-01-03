from os import path
from fastapi import Depends, Request, FastAPI, HTTPException

from fastapi.responses import FileResponse, JSONResponse
from fastapi.security import OAuth2PasswordRequestForm,OAuth2PasswordBearer
from pydantic import BaseModel

from sqlalchemy.orm import Session
from sqlalchemy import cast, Date

import crud, models, schemas
from database import SessionLocal, engine
models.BaseDB.metadata.create_all(bind=engine)

import jwt
import datetime
import httpx

from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI


app = FastAPI(title="Web service ArdhiCom",
    version="0.0.1",)

app.add_middleware(
 CORSMiddleware,
 allow_origins=["*"],
 allow_credentials=True,
 allow_methods=["*"],
 allow_headers=["*"],
)

# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

@app.get("/")
async def root():
    return {"message": "Dokumentasi API: [url]:8000/docs"}

# create user
@app.post("/register_email/", response_model=schemas.User)
def register_email(user: schemas.UserCreate, db: Session = Depends(get_db)):
    db_user_email = crud.get_user_by_email(db, email=user.email)
    if db_user_email:
        raise HTTPException(status_code=400, detail="Email sudah digunakan")

    return crud.register_email(db=db, user=user)


# hasil adalah akses token
@app.post("/login_email")
async def login_email(user: schemas.UserLoginEmail, db: Session = Depends(get_db)):
    if not authenticate_by_email(db,user):
        raise HTTPException(status_code=400, detail="Username atau password tidak cocok")

    # ambil informasi username
    user_login = crud.get_user_by_email(db,user.email)
    if user_login:
        access_token  = create_access_token(user.email)
        user_id = user_login.id
        return {"user_id":user_id,"access_token": access_token}
    else:
        raise HTTPException(status_code=400, detail="User tidak ditemukan, kontak admin")


@app.get("/get_user/{user_id}", response_model=schemas.User)
def read_user(
    user_id: int, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)
):
    try:
        usr =  verify_token(token)
    except HTTPException as e:
        raise e
    user = crud.get_user(db, user_id)
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user


@app.get("/addresses/{user_id}", response_model=list[schemas.Address])
def get_addresses(
    user_id: int, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)
):
    try:
        usr = verify_token(token)
    except HTTPException as e:
        raise e
    addresses = crud.get_addresses_by_user_id(db, user_id)
    if addresses is None:
        raise HTTPException(status_code=404, detail="Addresses not found")
    return addresses


@app.post("/addresses/", response_model=schemas.Address)
def create_address(
    address: schemas.AddressCreate,
    db: Session = Depends(get_db),
):
    return crud.create_address(db=db, address=address)

# payments


@app.post("/payments/", response_model=schemas.Payments)
def create_payment(payment: schemas.PaymentsCreate, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    try:
        usr = verify_token(token)
    except HTTPException as e:
        raise e
    return crud.create_payment(db=db, payment=payment)

@app.get("/payments/{payment_id}", response_model=schemas.Payments)
def get_payment(payment_id: int, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    try:
        usr = verify_token(token)
    except HTTPException as e:
        raise e
    payment = crud.get_payment_by_id(db, payment_id)
    if payment is None:
        raise HTTPException(status_code=404, detail="Payment not found")
    return payment

@app.get("/payments/transaction/{transaction_id}", response_model=list[schemas.Payments])
def get_payments_by_transaction(transaction_id: int, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    try:
        usr = verify_token(token)
    except HTTPException as e:
        raise e
    payments = crud.get_payments_by_transaction_id(db, transaction_id)
    if payments is None:
        raise HTTPException(status_code=404, detail="Payments not found")
    return payments

@app.put("/payments/{payment_id}", response_model=schemas.Payments)
def update_payment_status(payment_id: int, status: str, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    try:
        usr = verify_token(token)
    except HTTPException as e:
        raise e
    payment = crud.update_payment_status(db, payment_id, status)
    if payment is None:
        raise HTTPException(status_code=404, detail="Payment not found")
    return payment

@app.delete("/payments/{payment_id}", response_model=schemas.Payments)
def delete_payment(payment_id: int, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    try:
        usr = verify_token(token)
    except HTTPException as e:
        raise e
    payment = crud.delete_payment(db, payment_id)
    if payment is None:
        raise HTTPException(status_code=404, detail="Payment not found")
    return payment

# ambil isi cart milik user
@app.get("/get_cart/{user_id}", response_model=list[schemas.Carts])
def read_cart(user_id: int, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    usr =  verify_token(token)
    cart = crud.get_cart(db, user_id)
    return cart

@app.post("/add_cart_item", response_model=schemas.Carts)
def add_cart_item(carts: schemas.CartsCreate, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    usr =  verify_token(token)
    cart = crud.add_cart_item(db, carts)
    return cart

@app.delete("/delete_cart_item/{cart_id}")
def delete_cart_item(cart_id:int,db: Session = Depends(get_db),token: str = Depends(oauth2_scheme) ):
    usr =  verify_token(token)
    return crud.delete_cart_item(db,cart_id)

@app.put("/update_cart_item/{cart_id}", response_model=schemas.Carts)
def update_cart_quantity(cart_id: int, cart: schemas.CartsCreate, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    print(cart.quantity)
    usr =  verify_token(token)
    result = crud.get_cart_by_id(db, cart_id)
    return crud.update_cart_item(db, result, cart.quantity)

@app.get("/get_wishlist/{user_id}", response_model=list[schemas.Wishlists])
def read_wishlist(user_id: int, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    usr =  verify_token(token)
    wishlist = crud.get_wishlist(db, user_id)
    return wishlist

@app.post("/add_wishlist_item", response_model=schemas.Wishlists)
def add_wishlist_item(wishlists: schemas.WishlistsCreate, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    usr =  verify_token(token)
    wishlist = crud.add_wishlist_item(db, wishlists)
    return wishlist

@app.delete("/delete_wishlist_item/{wishlist_id}")
def delete_wishlist_item(wishlist_id:int,db: Session = Depends(get_db),token: str = Depends(oauth2_scheme) ):
    usr =  verify_token(token)
    return crud.delete_wishlist_item(db,wishlist_id)

@app.post("/add_transaction", response_model=schemas.Transaction)
def add_transaction(transaction: schemas.TransactionCreate, details: list[schemas.TransactionDetailCreate], cart_items: list[schemas.Carts], db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    usr =  verify_token(token)
    now = datetime.datetime.now()
    date_part = now.strftime("%Y%m%d")
    date_only = now.date()
    
    last_data = db.query(models.Transaction).filter(cast(models.Transaction.created_at, Date) == date_only).order_by(models.Transaction.number.desc()).first()
    new_number = 1
    if last_data is not None:
        new_number = last_data.number+1

    invoice_number = f"INV/{date_part}/{new_number:06}"

    transaction.invoice = invoice_number
    transaction.number = new_number

    result = crud.add_transaction(db, transaction, details)
    if result is not None:
        try:
            with httpx.Client(headers={"Authorization": f"Bearer {token}"}) as client:
                for item in cart_items:
                    response = client.delete(f"http://127.0.0.1:8000/delete_cart_item/{item.id}")
                    if response.status_code != 200:
                        raise HTTPException(
                            status_code=response.status_code,
                            detail=f"Failed to delete cart item with ID {item.id}.",
                        )
        except Exception as e:
            raise HTTPException(status_code=500, detail=f"Error while deleting cart items: {str(e)}")
        
    return result

@app.get("/get_transactions/{user_id}", response_model=list[schemas.Transaction])
def read_transactions(user_id: int, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    usr =  verify_token(token)
    transactions = crud.get_transactions(db, user_id)
    return transactions

@app.get("/get_transaction_by_invoice", response_model=schemas.Transaction)
def read_transaction_by_invoice(invoice: str, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    usr =  verify_token(token)
    transaction_by_invoice = crud.get_transaction_by_invoice(db, invoice)
    return transaction_by_invoice

@app.get("/get_transaction_details/{transaction_id}", response_model=list[schemas.TransactionDetail])
def read_transaction_details(transaction_id: int, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    usr =  verify_token(token)
    transaction_details = crud.get_transaction_details(db, transaction_id)
    return transaction_details

@app.get("/get_all_transaction_details/{user_id}", response_model=list[schemas.TransactionDetail])
def read_all_transaction_details(user_id: int, db: Session = Depends(get_db), token: str = Depends(oauth2_scheme)):
    usr =  verify_token(token)
    all_transaction_details = crud.get_all_transaction_details(db, user_id)
    return all_transaction_details


@app.put("/transactions/{transaction_id}", response_model=schemas.Transaction)
def update_transaction(
    transaction_id: int,
    transaction: schemas.TransactionUpdate,
    db: Session = Depends(get_db),
    token: str = Depends(oauth2_scheme),
):
    try:
        usr = verify_token(token)
    except HTTPException as e:
        raise e

    db_transaction = crud.get_transaction_by_id(db, transaction_id)
    if db_transaction is None:
        raise HTTPException(status_code=404, detail="Transaction not found")

    updated_transaction = crud.update_transaction(db, db_transaction, transaction)
    return updated_transaction



@app.get("/get_products/", response_model=list[schemas.Products])
def read_products(db: Session = Depends(get_db), skip: int = 0, limit: int = 100):
    products = crud.get_products(db, skip, limit)
    return products

@app.get("/product/{product_id}", response_model=schemas.Products)
async def read_products(
    product_id: int, db: Session = Depends(get_db)
):
    products = crud.get_product_by_id(db, product_id)
    if products is None:
        raise HTTPException(status_code=404, detail="Products not found")
    return products


@app.get("/get_categories/", response_model=list[schemas.Categories])
def read_categories(db: Session = Depends(get_db)):
    categories = crud.get_categories(db)
    return categories


@app.get("/get_category/{category_id}", response_model=schemas.Categories)
def read_category(category_id: int, db: Session = Depends(get_db)):
    category = crud.get_category_by_id(db, category_id)
    if category is None:
        raise HTTPException(status_code=404, detail="Category not found")
    return category


@app.get(
    "/get_products_by_category/{category_id}", response_model=list[schemas.Products]
)
def read_products_by_category(
    category_id: int, db: Session = Depends(get_db), skip: int = 0, limit: int = 100
):
    products = crud.get_products_by_category(db, category_id, skip, limit)
    if not products:
        raise HTTPException(
            status_code=404, detail="No products found for this category"
        )
    return products

# ######################## AUTH

def authenticate_by_email(db,user: schemas.UserCreate):
    user_cari = crud.get_user_by_email(db=db, email=user.email)
    if user_cari:
        print(f'{user_cari.password} {crud.hashPassword(user.password)}')
        return (user_cari.password == crud.hashPassword(user.password))
    else:
        return False  

def match_password(db, id, typedPassword: schemas.Password):
    user = crud.get_user(db, id)
    if user:
        return user.password == crud.hashPassword(typedPassword)
    else:
        return False

SECRET_KEY = "arDhicOm_gacorRrRR"

def create_access_token(email):
    expiration_time = datetime.datetime.now(datetime.UTC) + datetime.timedelta(hours=24)    # .now(datetime.UTC)
    access_token = jwt.encode({"email":email,"exp":expiration_time},SECRET_KEY,algorithm="HS256")
    return access_token    


def verify_token(token: str):
    try:
        payload = jwt.decode(token,SECRET_KEY,algorithms=["HS256"])
        email = payload["email"]  
     
    # exception jika token invalid
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Unauthorize token, expired signature, harap login")
    except jwt.PyJWKError:
        raise HTTPException(status_code=401, detail="Unauthorize token, JWS Error")
    except Exception as e:
        raise HTTPException(status_code=401, detail="Unauthorize token, unknown error"+str(e))
    
    return {"email": email}

@app.post("/token", response_model=schemas.Token)
async def token(req: Request, form_data: OAuth2PasswordRequestForm = Depends(),db: Session = Depends(get_db)):

    f = schemas.UserCreate
    f.email = form_data.username
    f.password = form_data.password
    if not authenticate_by_email(db,f):
        raise HTTPException(status_code=400, detail="email or password tidak cocok")

    email  = form_data.username
    access_token  = create_access_token(email)

    return {"access_token": access_token, "token_type": "bearer"}
