output "kube_config" {
  value     = azurerm_kubernetes_cluster.main.kube_config
  sensitive = true
}
