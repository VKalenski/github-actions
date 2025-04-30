$namespace_test = "test"
$namespace_dev = "dev"
$namespace_val = "val"

kubectl apply -f namespace.yaml

# 🎯 Applying resources to 'test' namespace
Write-Host "🎯 Applying resources to 'test' namespace"
kubectl apply -f deployment.yaml -n $namespace_test
kubectl apply -f service.yaml -n $namespace_test
kubectl apply -f ingress.yaml -n $namespace_test
kubectl apply -f storageclass.yaml -n $namespace_test

Write-Host "✅ Deployment completed successfully in namespace '$namespace_test'"
Write-Host "----------------------------------------------------------------"

# 🎯 Applying resources to 'dev' namespace
Write-Host "🎯 Applying resources to 'dev' namespace"
kubectl apply -f deployment.yaml -n $namespace_dev
kubectl apply -f service.yaml -n $namespace_dev
kubectl apply -f ingress.yaml -n $namespace_dev
kubectl apply -f storageclass.yaml -n $namespace_dev

Write-Host "✅ Deployment completed successfully in namespace '$namespace_dev'"
Write-Host "----------------------------------------------------------------"

# 🎯 Applying resources to 'val' namespace
Write-Host "🎯 Applying resources to 'val' namespace"
kubectl apply -f deployment.yaml -n $namespace_val
kubectl apply -f service.yaml -n $namespace_val
kubectl apply -f ingress.yaml -n $namespace_val
kubectl apply -f storageclass.yaml -n $namespace_val

Write-Host "✅ Deployment completed successfully in namespace '$namespace_val'"
