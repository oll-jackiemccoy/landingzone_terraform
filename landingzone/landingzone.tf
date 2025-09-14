locals {
  # Example manifest: governed regions, centralized logging, access mgmt, KMS.
  # See AWS docs for all supported fields & schemas.
  landing_zone_manifest = {
    governedRegions = var.governed_regions
    organizationStructure = {
      security = { name = "Security" }
    }
    centralizedLogging = {
      accountId      = aws_organizations_account.log_archive.id
      enabled        = true
      configurations = {
        loggingBucket      = { retentionDays = 365 }
        accessLoggingBucket= { retentionDays = 3650 }
        # Example (optional): bring your own KMS
        # kmsKeyArn = "arn:aws:kms:us-east-1:123456789012:key/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
      }
    }
    securityRoles = {
      accountId = aws_organizations_account.audit.id
    }
    accessManagement = {
      enabled = true
    }
  }
}

resource "aws_controltower_landing_zone" "lz" {
  version       = var.landing_zone_version
  manifest_json = jsonencode(local.landing_zone_manifest)

  # Strongly recommended: ignore manifest drift if you manage portions in console
  lifecycle {
    ignore_changes = [manifest_json]
  }

 depends_on = [
  aws_organizations_account.log_archive,
  aws_organizations_account.audit
 ]
}