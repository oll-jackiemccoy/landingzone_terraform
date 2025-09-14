variable "management_region" {
  description = "Home region for your Control Tower management account"
  type        = string
  default     = "us-east-1"
}

variable "governed_regions" {
  description = "Regions governed by Control Tower"
  type        = list(string)
  default     = ["us-east-1", "us-east-2"]
}

# Provide unique root emails for accounts (must not be already in use)
variable "log_archive_email" { type = string }
variable "audit_email"       { type = string }


# Use current LZ version; adjust if AWS publishes newer version
variable "landing_zone_version" {
  type    = string
  default = "3.3"
}
