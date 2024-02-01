# main.tf
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Cipher API Deployment
resource "kubernetes_deployment" "cipher_api" {
  metadata {
    name      = "cipher-api"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "cipher-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "cipher-api"
        }
      }

      spec {
        container {
          name  = "cipher-api-container"
          image = "registry.gitlab.com/pba_consonance1/cipher-api:pba_api_14122023_v1"
          # Add other container configuration
        }
      }
    }
  }
}

# UI Deployment
resource "kubernetes_deployment" "ui" {
  metadata {
    name      = "cipher-ui"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "cipher-ui"
      }
    }

    template {
      metadata {
        labels = {
          app = "cipher-ui"
        }
      }

      spec {
        container {
          name  = "cipher-ui-container"
          image = "registry.gitlab.com/pba_consonance1/cipher-ui:pba_ui_14122023"
          # Add other container configuration
        }
      }
    }
  }
}

# MongoDB StatefulSet
resource "kubernetes_stateful_set" "mongo" {
  metadata {
    name      = "cipher-mongo"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "cipher-mongo"
      }
    }

    service_name = "mongo-service"  # Add the service name for MongoDB

    template {
      metadata {
        labels = {
          app = "cipher-mongo"
        }
      }

      spec {
        container {
          name  = "cipher-mongo-container"
          image = "registry.gitlab.com/pba_consonance1/cipher-mongo:5.0"
          # Add other container configuration
        }
      }
    }
  }
}
 

# Vault Deployment
resource "kubernetes_deployment" "vault" {
  metadata {
    name      = "cipher-vault"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "cipher-vault"
      }
    }

    template {
      metadata {
        labels = {
          app = "cipher-vault"
        }
      }

      spec {
        container {
          name  = "cipher-vault-container"
          image = "registry.gitlab.com/pba_consonance1/cipher-vault:vault_version"  # Add the actual version
          # Add other container configuration
        }
      }
    }
  }
}

# PostgreSQL StatefulSet
resource "kubernetes_stateful_set" "postgres" {
  metadata {
    name      = "cipher-postgres"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "cipher-postgres"
      }
    }

    service_name = "postgres-service"  # Add the service name for PostgreSQL

    template {
      metadata {
        labels = {
          app = "cipher-postgres"
        }
      }

      spec {
        container {
          name  = "cipher-postgres-container"
          image = "registry.gitlab.com/pba_consonance1/cipher-pg:alpine-gen-1"
          # Add other container configuration
        }
      }
    }
  }
}
