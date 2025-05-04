provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "demo" {
  metadata {
    name = "demo-ns"
  }
}

resource "kubernetes_deployment" "myapp" {
  metadata {
    name      = "myapp"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "myapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "myapp"
        }
      }

      spec {
        container {
          name  = "myapp"
          image = "myuser/myapp:latest"
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "myapp" {
  metadata {
    name      = "myapp-service"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }

  spec {
    selector = {
      app = "myapp"
    }
    ports {
      port        = 80
      target_port = 5000
    }
    type = "NodePort"
  }
}

resource "kubernetes_ingress" "myapp-ingress" {
  metadata {
    name      = "myapp-ingress"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }

  spec {
    rules {
      host = "myapp.local"
      http {
        paths {
          path = "/"
          backend {
            service_name = kubernetes_service.myapp.metadata[0].name
            service_port = 80
          }
        }
      }
    }
  }
}
