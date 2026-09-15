#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "==> Pulling Mongo image"
docker pull --platform linux/amd64 mongo:7.0

echo "==> Building backend image"
docker build -t backend_productos:latest -f backend/Dockerfile ./backend

echo "==> Deleting existing Kind cluster"
kind delete cluster --name web3 >/dev/null 2>&1 || true

echo "==> Creating Kind cluster"
kind create cluster --name web3 --config kind-config.yaml

echo "==> Loading Mongo image into Kind"
if ! kind load docker-image mongo:7.0 --name web3; then
  echo "kind load docker-image failed for mongo:7.0, falling back to image-archive"
  docker save mongo:7.0 -o /tmp/mongo7.tar
  kind load image-archive /tmp/mongo7.tar --name web3
fi

echo "==> Loading backend image into Kind"
if ! kind load docker-image backend_productos:latest --name web3; then
  echo "kind load docker-image failed for backend_productos:latest, falling back to image-archive"
  docker save backend_productos:latest -o /tmp/backend_productos.tar
  kind load image-archive /tmp/backend_productos.tar --name web3
fi

echo "==> Applying manifests"
kubectl apply -f Kubernetes/mongo_statefulset.yaml
kubectl apply -f Kubernetes/backend_deployment.yaml

echo "==> Setup complete"
