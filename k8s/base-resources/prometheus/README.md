helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update



kubectl create namespace monitoring

helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring


kubectl port-forward svc/monitoring-grafana 3000:80 -n monitoring


http://localhost:3000
admin / prom-operator


kubectl port-forward svc/monitoring-kube-prometheus-prometheus 9090 -n monitoring

 http://localhost:9090


 Grafana.com/dashboards



 helm install monitoring prometheus-community/kube-prometheus-stack \
  -n monitoring \
  -f monitoring-values.yaml