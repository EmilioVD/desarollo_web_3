#!/bin/bash

kind load docker-image mongo:7.0 --name web3
kind load docker-image backend_productos:latest --name web3

kubectl apply -f ./mongo_statefulset.yaml
kubectl apply -f ./backend_deployment.yaml