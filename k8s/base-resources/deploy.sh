#!/bin/bash

NAMESPACE=test

kubectl apply -f namespace.yaml
kubectl apply -f deployment.yaml -n $NAMESPACE
kubectl apply -f service.yaml -n $NAMESPACE
kubectl apply -f ingress.yaml -n $NAMESPACE
kubectl apply -f storageclass.yaml -n $NAMESPACE

echo "✅ Deployment completed successfully in namespace '$NAMESPACE'"