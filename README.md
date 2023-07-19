# Cluster API

This repository provides the source code for setting up Cluster API on Microsoft Azure using Terraform and Flux: You can use this repository to create a fully automated and scalable workflow for deploying and managing Kubernetes clusters on Azure.

The purpose of the repository is to:

- Deploy the management cluster with Terraform
- Bootstrap it with Flux to pull in the Kubernetes manifests and apply them
- Install Cluster API on top of the management cluster
- Start deploying additional AKS clusters using Cluster API

Through the use of Flux, we’re able to deploy workload clusters quickly after pull requests are merged. You can use this repository as a template or a reference for your own Cluster API projects on Azure.

## Repository structure

- `clusters` - Kustomize manifests for cluster components
  - `management` - Platform management cluster
  - `workloads` - Distributed workload clusters
- `manifests` - Re-usable Kubernetes manifests for all clusters
- `resources` - Terraform files for deploying the management cluster

## Getting Started

### Deploy Management Cluster*

1. Navigate to the `resources` directory
2. Update the `resource_name` and `location` properties in `locals.tf` file
3. Update the `url` property in the `providers.tf` file
4. Authenticate Azure session `az login`
5. Select desired Azure Subscription `az account set -s '{SubscriptionName}'`
6. Initialize Terraform `terraform init`
7. Deploy Terraform resources `terraform deploy`
8. Authenticate Kubernetes context `az aks get-credentials -g '{ResourceGroup}' -n {Name}`

*Configuring Terraform State Storage has been omitted for brevity

### Create Cluster Federation

1. Browse to the [Entra admin center](https://entra.microsoft.com/)
2. Create App registration
3. Navigate to "Certificates & Secrets"
4. Add Federated credential “Kubernetes accessing Azure resources”
5. Update cluster details:
   - Cluster issuer URL `az aks show -g '{ResourceGroup}' -n '{Name}' --query 'oidcIssuerProfile.issuerUrl'`
   - Namespace "capi-azure-system"
   - Service account name "capz-manager"
6. Create Role Assignment for the Application at the Subscription scope with 'Owner' permissions

### Provision Workload Clusters*

1. Navigate to the `manifest/config` directory
2. Update the `data` properties with desired values
3. Deploy Kubernetes manifest `kubectl apply -f workloads.yaml`

*Configuration of Workloads settings can also be deployed by Flux

__Please note this repository is under development and subject to change.__