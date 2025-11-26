# 📌 AKS Infrastructure Deployment using Terraform                           
This repository contains the complete Infrastructure-as-Code (IaC) setup for deploying Azure Kubernetes Service (AKS) along with its dependent Azure resources using Terraform. 
The infra is designed to be scalable, secure, modular, and production-ready.

## 🌐 Infrastructure Components
This infrastructure provisions a complete production-ready Azure environment using Terraform.
The setup includes the following Azure services:
Resource Group
Virtual Network (VNet) & Subnets
Public IP Address
Application Gateway (WAF)
Azure Kubernetes Service (AKS) Cluster
Azure Container Registry (ACR)
Azure SQL Server
Azure SQL Database
Identity & Role Assignments (optional)

All components are deployed using modular Terraform code following Azure best practices for security, scalability, and network segmentation.

## 📂 Project Structure
aks-infra-terraform/
│
├── modules/
│   ├── azure_resource_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── azure_virtual_network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── azure_public_ip/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── azure_application_gateway/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── azure_container_registry/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── azurerm_kubernetes_service/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── azurerm_mssql_server/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── azurerm_mssql_db/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── README.md
│
├── env/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── backend.tf
│   │   └── variables.tf
│   │
│   ├── qa/
│   │   ├── main.tf
│   │   ├── backend.tf
│   │   └── variables.tf
│   │
│   └── prod/
│       ├── main.tf
│       ├── backend.tf
        └── variables.tf


                          **🏗️ Azure AKS Infrastructure Architecture**

                           +------------------------------------+
                           |            Resource Group          |
                           |        (aks-infra-rg / etc.)       |
                           +----------------------+--------------+
                                                  |
                                                  |
                   +------------------------------+-------------------------------+
                   |                                                              |
                   |                                                              |
        +----------v-----------+                                      +-----------v-----------+
        |   Virtual Network    |                                      |     Public IP         |
        |  (VNet + Subnets)    |                                      |  (For App Gateway)    |
        +----------+-----------+                                      +-----------+-----------+
                   |                                                              |
          +--------+---------+                                            +-------+--------+
          |      Subnet 1    |                                            |   App Gateway  |
          | (AKS Node Pools) |                                            |     (WAF)      |
          +--------+---------+                                            +-------+--------+
                   |                                                              |
                   |                                                              |
     +-------------+------------------+                               +-----------+-----------+
     |      Azure Kubernetes Service  |                               |        ACR           |
     |         (AKS Cluster)          |                               |  Azure Container Reg |
     +------------------+-------------+                               +----------------------+
                          |
                          |
           +--------------+--------------+
           |     Managed Identity        |
           +--------------+--------------+
                          |
                          |
                  +-------+--------+
                  |    Key Vault   |
                  |  (Secrets/RBAC)|
                  +-------+--------+
                          |
                          |
                +---------+----------+
                |   MSSQL Server     |
                |    (azurerm)       |
                +---------+----------+
                          |
                          |
                +---------+----------+
                |    MSSQL DB        |
                +--------------------+



