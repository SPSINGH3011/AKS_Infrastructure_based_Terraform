resource_groups = {
  rg1 = {
    name     = "qa-aks-rg"
    location = "West US"
  }
}

container_registries = {
  acr1 = {
    name                = "qaaksacr"
    resource_group_name = "qa-aks-rg"
    location            = "West US"
    sku                 = "Standard"
  }
}

public_ips = {
  pip1 = {
    name                = "qa-aks-pip"
    resource_group_name = "qa-aks-rg"
    location            = "West US"
    allocation_method   = "Static"
  }
}

virtual_networks = {
  vnet1 = {
    name                = "qa-aks-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = "West US"
    resource_group_name = "qa-aks-rg"
    subnets = {
      subnet1 = {
        name             = "qa-aks-subnet"
        address_prefixes = ["10.0.1.0/24"]
      }
      subnet2 = {
        name             = "appgw-subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
    }
  }
}

application_gateways = {
  appgw1 = {
    name                = "qa-aks-appgw"
    resource_group_name = "qa-aks-rg"
    location            = "West US"
    sku = {
      name     = "Standard_v2"
      tier     = "Standard_v2"
      capacity = 2
    }

    gateway_ip_configuration = {
      name        = "appgw-ipconfig"
      subnet_name = "appgw-subnet"
    }

    virtual_network_name = "qa-aks-vnet"
    public_ip_name       = "qa-aks-pip"
    frontend_ports = {
      port1 = {
        name = "frontendPort1"
        port = 80
      }
    }
    frontend_ip_configurations = {
      config1 = {
        name = "frontendIPConfig1"
      }
    }
    backend_address_pools = {
      pool1 = {
        name = "backendPool1"
      }
    }
    backend_http_settings = {
      setting1 = {
        name                  = "httpSetting1"
        cookie_based_affinity = "Disabled"
        path                  = "/"
        port                  = 80
        protocol              = "Http"
        request_timeout       = 60
      }
    }
    http_listeners = {
      listener1 = {
        name                           = "httpListener1"
        frontend_ip_configuration_name = "frontendIPConfig1"
        frontend_port_name             = "frontendPort1"
        protocol                       = "Http"
      }
    }
    request_routing_rules = {
      rule1 = {
        name                       = "rule1"
        priority                   = 9
        rule_type                  = "Basic"
        http_listener_name         = "httpListener1"
        backend_address_pool_name  = "backendPool1"
        backend_http_settings_name = "httpSetting1"
      }
    }
  }
}


kubernetes_clusters = {
  aks1 = {
    ingress_application_gateway_name = "qa-aks-appgw"
    resource_group_name              = "qa-aks-rg"
    container_registry_name          = "qaaksacr"
    acr_pull_role_name               = "AcrPull"
    skip_aad_check                   = true
    name                             = "qa-aks-aks"
    location                         = "West US"
    dns_prefix                       = "qa-aks"
    kubernetes_version               = "1.32.5"
    default_node_pool = {
      name                 = "default"
      node_count           = 1
      vm_size              = "Standard_a2_v2"
      max_pods             = 80
      auto_scaling_enabled = true
      min_count            = 1
      max_count            = 2
    }
    identity = {
      type = "SystemAssigned"
    }
    network_profile = {
      network_plugin = "azure"
      network_policy = "calico"
    }
  }
}

mssql_servers = {
  mssql1 = {
    name                         = "qa-aksmssqlserver007"
    resource_group_name          = "qa-aks-rg"
    location                     = "West US"
    version                      = "12.0"
    administrator_login          = "achinta"
    administrator_login_password = "Raju@834068"
  }
}

mssql_databases = {
  mysqldb1 = {
    name                = "qa-aksmssqldb007"
    resource_group_name = "qa-aks-rg"
    server_name         = "qa-aksmssqlserver007"
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    license_type        = "LicenseIncluded"
    max_size_gb         = 2
    sku_name            = "S0"
    enclave_type        = "VBS"
  }
}
