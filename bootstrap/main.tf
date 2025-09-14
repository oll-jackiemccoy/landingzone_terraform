#
# 1) Service-linked role for Control Tower (if not present)
#
resource "aws_iam_service_linked_role" "controltower" {
  aws_service_name = "controltower.amazonaws.com"
  # Will be a no-op if it already exists.
}

#
# 2) AWSControlTowerAdmin role (must be exactly this name and path)
#
data "aws_iam_policy" "ct_service_role" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSControlTowerServiceRolePolicy"
}

resource "aws_iam_role" "aws_controltower_admin" {
  name = "AWSControlTowerAdmin"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = { Service = "controltower.amazonaws.com" },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

# Optional tiny inline permission (mirrors doc examples; harmless if kept)
resource "aws_iam_role_policy" "aws_controltower_admin_inline" {
  name = "AWSControlTowerAdminPolicy"
  role = aws_iam_role.aws_controltower_admin.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = ["ec2:DescribeAvailabilityZones"],
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "aws_controltower_admin_attach" {
  role       = aws_iam_role.aws_controltower_admin.name
  policy_arn = data.aws_iam_policy.ct_service_role.arn
}

#
# 3) StackSets admin role that Control Tower uses in the management account
#
resource "aws_iam_role" "aws_controltower_stackset_role" {
  name = "AWSControlTowerStackSetRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "cloudformation.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "aws_controltower_stackset_role_inline" {
  name = "AssumeExecutionInMembers"
  role = aws_iam_role.aws_controltower_stackset_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = ["sts:AssumeRole"],
      Resource = "arn:aws:iam::*:role/AWSControlTowerExecution"
    }]
  })
}
