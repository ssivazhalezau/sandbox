resource "google_compute_firewall" "vpc-db-fw" {
  name    = "vpc-db-rule"
  network = google_compute_network.vpc_network.name
  target_tags = ["mongo"]
  source_ranges = [google_compute_address.static-webapi.address, google_compute_address.static-id.address]

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
}

# we reserve static ip for instance
resource "google_compute_address" "static-db" {
  name = "ipv4-address-db"
}

resource "google_compute_instance" "node-db" {
  name         = "db1"
  description  = "Node with docker where we serve mongodb"
  machine_type = "e2-small"
  tags         = ["mongo"]

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  boot_disk {
    initialize_params {
      image = data.google_compute_image.gc_Centos7_image.self_link
      size  = "20"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
      nat_ip = google_compute_address.static-db.address
    }
  }

  metadata = {
    ssh-keys = var.jenkins_pub_key
  }

  # script that runs on boot
  metadata_startup_script = data.template_file.docker_host.rendered
}

output "db_public_ip" {
  value = google_compute_address.static-db.address
}