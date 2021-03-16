resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "vpc" {
  name    = "vpc-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "1000-2000"]
  }
}

# we reserve static ip for instance
resource "google_compute_address" "static-ja" {
  name = "ipv4-address"
}

# # adding SSH Public Key in Project Meta Data
# resource "google_compute_project_metadata_item" "ssh-keys" {
#   key   = "ssh-keys"
#   value = var.deployer_pub_key
# }

resource "google_compute_instance" "jenkins-agent" {
  name         = "agent01"
  description  = "Jenkins agent managed over ssh"
  machine_type = "e2-medium"

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
      nat_ip = google_compute_address.static-ja.address
    }
  }

  metadata = {
    ssh-keys = var.jenkins_pub_key
  }

  # script that runs on boot
  metadata_startup_script = data.template_file.docker_host.rendered
}

output "jenkins_agent_public_ip" {
  value = google_compute_address.static-ja.address
}