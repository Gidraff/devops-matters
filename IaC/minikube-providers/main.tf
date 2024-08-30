resource "kubernetes_namespace" "web-test" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = var.name
    namespace = kubernetes_namespace.web-test.metadata.0.name
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = var.metadata_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.metadata_name
        }
      }
      spec {
        container {
          image = var.image_name
          name  = var.container_name
          port {
            container_port = var.nginx_ports
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name      = var.metadata_name
    namespace = kubernetes_namespace.web-test.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.nginx.spec.0.template.0.metadata.0.labels.app
    }
    port {
      port = var.nginx_ports
    }
  }
}
