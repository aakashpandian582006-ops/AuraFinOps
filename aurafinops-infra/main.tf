# Core infrastructure for AuraFinOps

# Define the AWS Provider for the primary region
provider "aws" {
  region = var.primary_region
  alias  = "primary"

  default_tags {
    tags = var.project_tags
  }
}

# Define the AWS Provider for the secondary region
provider "aws" {
  region = var.secondary_region
  alias  = "secondary"

  default_tags {
    tags = var.project_tags
  }
}

# Centralized FinOps Data Lake
# This S3 bucket will store our cost and billing data
resource "aws_s3_bucket" "cost_lake" {
  provider = aws.primary
  bucket   = "aurafinops-global-cost-lake"
}

# Block all public access to the FinOps Data Lake to ensure enterprise compliance
resource "aws_s3_bucket_public_access_block" "cost_lake_access" {
  provider                = aws.primary
  bucket                  = aws_s3_bucket.cost_lake.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable server-side encryption for the S3 bucket by default
resource "aws_s3_bucket_server_side_encryption_configuration" "cost_lake_encryption" {
  provider = aws.primary
  bucket   = aws_s3_bucket.cost_lake.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# CloudWatch Log Group for billing metrics and server resource utilization
resource "aws_cloudwatch_log_group" "billing_metrics" {
  provider          = aws.primary
  name              = "/aurafinops/billing-metrics"
  retention_in_days = 90
}

# CloudWatch Log Group for server resource utilization logs
resource "aws_cloudwatch_log_group" "resource_utilization" {
  provider          = aws.primary
  name              = "/aurafinops/resource-utilization"
  retention_in_days = 90
}

# ---------------------------------------------------------
# Compute Layer
# ---------------------------------------------------------

# AWS Launch Template tracking compute nodes
resource "aws_launch_template" "compute_node" {
  provider      = aws.primary
  name_prefix   = "aurafinops-node-"
  image_id      = "ami-0abcdef1234567890" # Example AMI ID
  instance_type = "t3.medium"

  tag_specifications {
    resource_type = "instance"
    tags          = var.project_tags
  }
}

# AWS Auto Scaling Group tracking compute nodes
resource "aws_autoscaling_group" "compute_asg" {
  provider            = aws.primary
  name                = "aurafinops-compute-asg"
  availability_zones  = ["${var.primary_region}a", "${var.primary_region}b"]
  desired_capacity    = 2
  max_size            = 5
  min_size            = 1

  launch_template {
    id      = aws_launch_template.compute_node.id
    version = "$Latest"
  }
}

# ---------------------------------------------------------
# Query & Analytics Layer
# ---------------------------------------------------------

# Amazon Athena Database tracking query schemas mapped directly over our S3 cost data lake bucket
resource "aws_athena_database" "finops_lake_db" {
  provider = aws.primary
  name     = "aurafinops_cost_db"
  bucket   = aws_s3_bucket.cost_lake.bucket
  comment  = "AuraFinOps Athena database tracking query schemas over the S3 cost data lake"
}
