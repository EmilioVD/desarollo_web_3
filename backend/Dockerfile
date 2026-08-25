# Imagen base ligera de Python 3.9
FROM python:3.9-slim

# Directorio de trabajo
WORKDIR /app

# Copiamos solo el backend al contenedor
COPY backend/ /app/

# Exponemos el puerto de la app
EXPOSE 8000

# Instalamos dependencias necesarias
RUN pip install --no-cache-dir fastapi pymongo uvicorn

# Arrancamos la app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]