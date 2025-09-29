module "acr" {
  source              = "../../modules/acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  acr_name            = var.acr_name
}

module "aks" {
  source              = "../../modules/aks"
  resource_group_name = var.resource_group_name
  location            = var.location
  cluster_name        = var.cluster_name
  node_count          = var.node_count
  acr_id              = module.acr.acr_id
}
