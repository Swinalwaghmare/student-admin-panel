locals {
  name = "${var.project_name}-${var.environment}"

  # default tags merged with user provided extra-tags
  common_tags = merge({
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }, var.extra_tags)
}

locals {
  az_count = length(var.azs)
}