resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.vpc_name}-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  project       = var.project_id
}

# SSH qua IAP (không cần IP public)
resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "${var.vpc_name}-allow-iap-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
}

output "network_self_link" {
  value = google_compute_network.vpc.self_link
}

output "subnetwork_self_link" {
  value = google_compute_subnetwork.subnet.self_link
}
