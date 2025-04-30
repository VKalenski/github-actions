$namespace = "test"

kubectl apply -f namespace.yaml
kubectl apply -f deployment.yaml -n $namespace
kubectl apply -f service.yaml -n $namespace
kubectl apply -f ingress.yaml -n $namespace
kubectl apply -f storageclass.yaml -n $namespace

Write-Host "✅ Deployment completed successfully in namespace '$namespace'"
