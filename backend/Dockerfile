# Imagen base ligera compatible con el proyecto
FROM python:3.14-slim

# Directorio de trabajo
WORKDIR /app

# Copiamos solo el backend al contenedor
COPY backend/ /app/

# Exponemos el puerto de la app
EXPOSE 8000

# Instalamos dependencias necesarias
RUN pip install --no-cache-dir fastapi pymongo uvicorn

# Arrancamos la app con recarga automática
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]