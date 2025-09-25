resource "google_compute_instance" "vm" {
  name         = var.name
  machine_type = "e2-micro"
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = var.subnetwork

    dynamic "access_config" {
      for_each = var.public_ip ? [1] : []
      content {}
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}

output "vm_internal_ip" {
  value = google_compute_instance.vm.network_interface[0].network_ip
}

output "vm_external_ip" {
  value = try(google_compute_instance.vm.network_interface[0].access_config[0].nat_ip, null)
}
