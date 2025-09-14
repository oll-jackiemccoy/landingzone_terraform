# Create (or ensure) an AWS Organization
data "aws_organizations_organization" "current" {}
locals {
  root_id = data.aws_organizations_organization.current.roots[0].id
}
resource "aws_organizations_account" "log_archive" {
  name      = "Log-Archive"
  email     = var.log_archive_email
  role_name = "OrganizationAccountAccessRole"
  depends_on = [local.root_id]
}

resource "aws_organizations_account" "audit" {
  name      = "Audit"
  email     = var.audit_email
  role_name = "OrganizationAccountAccessRole"
  depends_on = [local.root_id]
}

resource "aws_organizations_organizational_unit" "Shared_Services" {
  name      = "Shared Services"
  parent_id = local.root_id
}