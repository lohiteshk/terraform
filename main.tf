// PROVIDER DEFINED HERE "GOOGLE"
provider "google" {
  credentials = "${file("account.json")}"
  project     = "testproj-263607"
  region      = "us-central1"
  zone        = "us-central1-a"
}


// RESOURCE DEFINED TO CREATE VM
resource "google_compute_instance" "default" {
  name         = "${var.instance_name}"
  machine_type = "${var.machine_type}"

  tags                = ["env", "test"]
  deletion_protection = "false"
  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }
  network_interface {
    # A default network is created for all GCP projects
    network = "${google_compute_network.default.self_link}"
    access_config {
    }
  }
}



// NETWORK PART STARTS HERE
resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "8080", "8000", "898"]
  }

   allow {
    protocol = "udp"
    ports    = ["22", "8080", "8000"]
  }
}

resource "google_compute_network" "default" {
  name                    = "${var.VPC_name}"
  auto_create_subnetworks = "true"
}

output "public_ip" {
  //value = "${google_compute_instance.default.instance_id}"
  value = "${google_compute_instance.default.network_interface[0].access_config[0].nat_ip}"

}
