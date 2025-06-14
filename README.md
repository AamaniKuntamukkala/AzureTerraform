# AzureTerraform

azure_infra/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── backend.tf
└── modules/
    ├── network/
│ ├── main.tf         # VNet + Subnets using cidrsubnet
│ ├── variables.tf
│ └── outputs.tf
    ├── nsg/
│ ├── main.tf         # NSGs and rules
│ ├── variables.tf
│ └── outputs.tf
    ├── compute/
│ ├── main.tf         # VMSS with SSH using file()
│ ├── variables.tf
│ └── outputs.tf
    ├── appgw/
│ ├── main.tf         # App Gateway with WAF
│ ├── variables.tf
│ └── outputs.tf
    └── database/
├── main.tf         # PostgreSQL with HA and private access
├── variables.tf
└── outputs.tf
