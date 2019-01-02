provider "google" {
 credentials = "${file("~/.gcp/projects/group-iam-test/terraform.json")}"
 project     = "group-iam-test"
 region      = "us-west1"
 zone        = "us-west1-c"
 version     = "1.20"
}

resource "google_project_iam_policy" "project" {
  project     = "group-iam-test"
  policy_data = "${data.google_iam_policy.admin.policy_data}"
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/compute.instanceAdmin"

    members = [
      "group:developers@tothetest.tv",
    ]
  }

  binding {
    role = "roles/storage.objectViewer"

    members = [
      "group:developers@tothetest.tv",
    ]
  }
}

