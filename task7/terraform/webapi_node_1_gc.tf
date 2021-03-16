resource "google_compute_firewall" "vpc-api-fw" {
  name    = "vpc-api-rule"
  network = google_compute_network.vpc_network.name
  target_tags = ["webapi"]

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8001", "9000", "9001"]
  }
}

# we reserve static ip for instance
resource "google_compute_address" "static-webapi" {
  name = "ipv4-address-webapi"
}

resource "google_compute_instance" "node-webapi" {
  name         = "webapi1"
  description  = "Node with docker where we test webapi image"
  machine_type = "e2-medium"
  tags         = ["webapi"]

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  boot_disk {
    initialize_params {
      image = data.google_compute_image.gc_Centos7_image.self_link
      size  = "30"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
      nat_ip = google_compute_address.static-webapi.address
    }
  }

  metadata = {
    ssh-keys = var.jenkins_pub_key
  }

  # script that runs on boot
  metadata_startup_script = data.template_file.docker_host.rendered
}

output "api_public_ip" {
  value = google_compute_address.static-webapi.address
}