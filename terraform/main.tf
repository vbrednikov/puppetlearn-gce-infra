provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "puppetmaster" {
  name         = "puppet"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"

  metadata {
    sshKeys = "appuser:${file(var.public_key_path)}"
  }

  boot_disk {
    initialize_params {
      image = "puppetmaster-base"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }


}

resource "google_compute_instance" "puppetnode" {
  name         = "node${count.index + 1}"
  count=4
  machine_type = "g1-small"
  zone         = "europe-west1-b"

  metadata {
    sshKeys = "appuser:${file(var.public_key_path)}"
  }

  boot_disk {
    initialize_params {
      image = "puppetnode-base"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }


}
