
resource "google_service_account" "sp-name" {
  project = var.project
  account_id = "sp-name"
  display_name = "SPasum"
}

resource "google_project_iam_member" "artifact_registry_admin" {  
  project = var.project  
  role = "roles/artifactregistry.admin"  
  member = "serviceAccount:${google_service_account.sp-name.email}" 
  }

/*

resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.sp-name.name
  // public_key_type    = "TYPE_X509_PEM_FILE"
} 


resource "local_file" "myaccountjson" {
    content     = "${base64decode(google_service_account_key.mykey.private_key)}"
    filename = "${path.module}/sp-name.json"
}

 resource "google_service_account_iam_policy" "admin-account-iam" {
  service_account_id = google_service_account.sp-name.name
  policy_data        = data.google_iam_policy.admin.policy_data
} 

data "google_iam_policy" "admin" {
  binding {
   // role = "roles/iam.serviceAccountUser"
  role = "roles/artifactregistry.repoAdmin"
    members = [
      "serviceAccount:${google_service_account.sp-name.email}",
      ]
  }
  binding {
   
  role = "roles/artifactregistry.repoAdmin"
    members = [
      "serviceAccount:${google_service_account.sp-name.email}",
      ]
  }
 
  binding {
  role = "roles/iam.serviceAccountKeyAdmin"
    members = [
      "serviceAccount:${google_service_account.sp-name.email}",
      ]
  }
  
}

 */
resource "google_artifact_registry_repository" "my-repo" {
  project = var.project
  provider = google-beta
  location = "europe-west1"
  repository_id = "my-repository"
  description = "example docker repository with cmek"
  format = "DOCKER"
  // kms_key_name = "kms-key"
}

resource "google_artifact_registry_repository_iam_member" "test-iam" {
  project = var.project
  provider = google-beta
  location = google_artifact_registry_repository.my-repo.location
  repository = google_artifact_registry_repository.my-repo.name
  role   = "roles/artifactregistry.reader"
  member = "serviceAccount:${google_service_account.sp-name.email}"
}