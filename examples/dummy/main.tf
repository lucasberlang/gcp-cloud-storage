
provider "google" {
  project = var.project_id
  region  = var.region
}

module "cloud_storage" {
  source = "../.."

  name           = var.name
  offset         = var.offset
  project_id     = var.project_id
  force_destroy  = var.force_destroy
  iam            = var.iam
  lifecycle_rule = var.lifecycle_rule
  folders        = ["pipelines/", "dataset/"]

  tags = var.tags
}
