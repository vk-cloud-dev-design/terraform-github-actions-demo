variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "github-actions-tf-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "West US"
}
