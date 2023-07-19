terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    flux = {
      source = "fluxcd/flux"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "flux" {
  git = {
    url          = "ssh://git@github.com/ljtill/terraform-cluster-api.git"
    author_email = "fluxcdbot@users.noreply.github.com"
    author_name  = "fluxcdbot"
    ssh = {
      username    = "git"
      private_key = file("../.ssh/id_ed25519")
    }
  }

  kubernetes = {
    host                   = module.cluster.kube_config.0.host
    client_certificate     = base64decode(module.cluster.kube_config.0.client_certificate)
    client_key             = base64decode(module.cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(module.cluster.kube_config.0.cluster_ca_certificate)
  }
}
