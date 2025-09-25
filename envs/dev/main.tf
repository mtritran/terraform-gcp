provider "google" {
  project = var.project_id
  region  = var.region
  # Không cần credentials nếu đã set GOOGLE_APPLICATION_CREDENTIALS
}

module "network" {
  source      = "../../modules/network"
  project_id  = var.project_id
  region      = var.region
  vpc_name    = "dev-vpc"
  subnet_cidr = "10.10.0.0/24"
}

module "vm" {
  source     = "../../modules/compute"
  project_id = var.project_id
  zone       = var.zone
  subnetwork = module.network.subnetwork_self_link
  name       = "dev-vm-1"
  public_ip  = true
}

output "ssh_hint_public" {
  value = module.vm.vm_external_ip != null ? "ssh debian@${module.vm.vm_external_ip}" : null
}

output "ssh_hint_iap" {
  value = "gcloud compute ssh dev-vm-1 --zone=${var.zone} --tunnel-through-iap"
}
