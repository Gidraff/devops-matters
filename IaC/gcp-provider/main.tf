resource "google_compute_instance" "backend" {
  name         = "backend"
  machine_type = "e2-small"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "nginx-image-1722491466"
    }
  }

  network_interface {
    network = "default"

    access_config {

    }
  }

  tags = ["web", "dev"]

  metadata = {
    ssh_keys = "user:${file("~/.ssh/id_rsa.pub")}"
  }
}

