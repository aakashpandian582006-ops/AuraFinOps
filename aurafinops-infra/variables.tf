# Core variables for AuraFinOps infrastructure

variable "primary_region" {
  description = "The primary AWS region for infrastructure deployment (Mumbai)"
  type        = string
  default     = "ap-south-1"
}

variable "secondary_region" {
  description = "The secondary AWS region for infrastructure deployment (Singapore)"
  type        = string
  default     = "ap-southeast-1"
}

variable "project_tags" {
  description = "Standard tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "AuraFinOps"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
