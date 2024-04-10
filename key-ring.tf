resource "google_kms_key_ring" "key_ring" {
  name     = "my-key-ring-5"
  location = var.region
}

resource "google_kms_crypto_key" "vm_key" {
  name            = "vm-key"
  key_ring        = google_kms_key_ring.key_ring.id
  rotation_period = "90000s" # 1 days
  #   lifecycle {
  #     prevent_destroy = false
  #   }
}

resource "google_kms_crypto_key" "sql_key" {
  name            = "sql-key"
  key_ring        = google_kms_key_ring.key_ring.id
  rotation_period = "90000s" # 1 days
  #   lifecycle {
  #     prevent_destroy = false
  #   }
}

resource "google_kms_crypto_key" "storage_key" {
  name            = "storage-key"
  key_ring        = google_kms_key_ring.key_ring.id
  rotation_period = "90000s" # 1 days
  purpose         = "ENCRYPT_DECRYPT"
  #   lifecycle {
  #     prevent_destroy = false
  #   }
}
