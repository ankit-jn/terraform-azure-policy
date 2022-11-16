terraform {
    ## Remote Backend - Storage Account
    # backend "azurerm" {
    #     resource_group_name   = "<stg-rg>"
    #     storage_account_name  = "<stg-name>"
    #     container_name        = "<stg-container-name>"
    #     key                   = "<terraform State File Name>" #e.g. terraforn.tfstate
    # }
    
    backend "local" {
        path = "terraform.tfstate"
    }
}
