
locals {
  subnet_cidrs = {
    public  = "10.0.1.0/24"
    private = "10.0.2.0/24"
    db      = "10.0.3.0/24"
  }

  environment = lookup(var.tags, "environment", "dev")

  common_tags = merge({
    project     = "3tier-app"
    managed_by  = "terraform"
  }, var.tags)
}
