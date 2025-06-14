# 🌐 Azure 3-Tier Architecture with Terraform (Modular + CI/CD)

## 📌 Problem Statement

You are tasked with replicating a **3-tier infrastructure** typically found in AWS (public, private, and secure subnets, with NAT, VMSS, load balancing, and database services) — but on **Microsoft Azure**. The goal is to:

- Build reusable, modular Terraform code.
- Implement infrastructure-as-code best practices (remote state, CI/CD, variable management).
- Support multi-environment setups (e.g., dev, stage, prod).
- Monitor and secure the infrastructure with Azure-native tools.

---

## 🧠 Architecture Overview

- **Public Subnet**: Contains NAT Gateway and Load Balancer (Application Gateway).
- **Private Subnet**: Hosts VM Scale Sets for web/application layer.
- **Secure Subnet**: Hosts a managed database (Azure PostgreSQL Flexible Server in HA mode).
- **NSGs**: Restrict access per subnet.
- **Remote Backend**: Azure Storage Account.
- **CI/CD**: GitHub Actions and Azure DevOps support.

---

## 📁 Project Structure

```
azure_terraform_3tier/
├── backend.tf               # Remote state configuration
├── locals.tf                # Uses lookup/merge for input abstraction
├── main.tf                  # Composes all modules
├── terraform.tfvars         # Variable values
├── variables.tf             # Input variable definitions
├── outputs.tf               # Exported values
├── state_resources.tf       # Provisions Azure backend for state
├── modules/
│   ├── network/             # VNet and subnets
│   ├── compute/             # VM Scale Sets
│   ├── nsg/                 # NSG rules
│   └── ...                  # Extendable (appgw, db)
└── .github/
    └── workflows/
        └── terraform.yml    # GitHub Actions CI/CD pipeline
azure-pipelines.yml          # Azure DevOps pipeline
```

---

## 🚀 Step-by-Step Setup

### ✅ Prerequisites

- Azure CLI logged in: `az login`
- Terraform installed (`>=1.3.0`)
- Azure Subscription ID, Client ID, Secret, Tenant ID

---

### 1. 📦 Provision Backend (Optional, if not created)

```bash
terraform init -backend=false
terraform apply -target=module.state_storage
```

This creates:
- Storage Account
- Container for state
- Resource Group

---

### 2. ⚙️ Configure `backend.tf`

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstate12345"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
```

---

### 3. 🧠 Update `terraform.tfvars`

```hcl
rg_name     = "rg-prod"
location    = "East US"
vnet_name   = "vnet-prod"
vnet_cidr   = "10.0.0.0/16"
subscription_id = "xxxx"
client_id       = "xxxx"
client_secret   = "xxxx"
tenant_id       = "xxxx"
```

---

### 4. 📥 Initialize and Apply

```bash
terraform init
terraform plan
terraform apply
```

---

### 5. 🤖 GitHub Actions CI/CD

`.github/workflows/terraform.yml` will:

- Run `init`, `plan`, `apply`
- Auto-trigger on push to `main`
- Store Terraform outputs in logs

🔑 **Secrets Required** in GitHub:
- `ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID`

---

### 6. 🛠 Azure DevOps Pipeline (Optional)

```yaml
trigger:
  branches:
    include:
      - main

pool:
  vmImage: ubuntu-latest

steps:
  - task: TerraformInstaller@0
    inputs:
      terraformVersion: 'latest'

  - script: |
      terraform init
      terraform plan
      terraform apply -auto-approve
    env:
      ARM_CLIENT_ID: $(clientId)
      ARM_CLIENT_SECRET: $(clientSecret)
      ARM_SUBSCRIPTION_ID: $(subscriptionId)
      ARM_TENANT_ID: $(tenantId)
```

---

## ✅ Best Practices Followed

- 🔁 Modular design for reuse
- 🔐 Secure credentials via secrets
- 📦 Remote backend using Azure Storage
- 🧩 Uses `locals.tf` with `lookup` and `merge` functions
- 🚀 Integrated GitHub Actions + Azure DevOps CI/CD

---

## 🏁 Next Steps

- Add database and Application Gateway modules
- Use Azure Key Vault for secret injection
- Add Diagnostic and Monitoring settings via `azurerm_monitor_diagnostic_setting`
