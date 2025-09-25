terraform {
  backend "gcs" {
    bucket = "tf-state-iac-gcp-473104"
    prefix = "envs/dev"
  }
}
