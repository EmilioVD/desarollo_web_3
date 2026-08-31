import os

from fastapi import FastAPI
from pymongo import MongoClient


app = FastAPI()

mongo_uri = os.getenv("MONGO_URI", "mongodb://admin_user:web3@mongo_container:27017/")
mongo_client = MongoClient(mongo_uri)
database = mongo_client["Web3"]
productos = database["productos"]

@app.get("/")
def default_route():
    return {"message": "Emilio the goat varguez is running!"}

@app.get("/health")
def health_check():
    return {"status": "ok"}

@app.get("/productos")
def get_productos():
    return list(productos.find({}, {"_id": 0}))