terraform {
  required_providers {
    google-beta = {
      source = "hashicorp/google-beta"
      version = "4.11.0"
    }
  }
}

provider "google-beta" {
  # Configuration options
  // project = "samplesuji"
  project = "petproject-341413"
  region = "europe-west1"
}

/*
terraform {
  
  
}

provider "google" {
    // project = "petproject-341413"
    project = "samplesuji"
    region = "europe-west1"
} 

*/
