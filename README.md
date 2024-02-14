# tf-gcp-infra

Terraform template for GCP

This repository contains Terraform templates for setting up infrastructure on Google Cloud Platform (GCP). It's structured to facilitate easy and manageable deployments of cloud resources.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Git](https://git-scm.com/downloads)
- [Terraform](https://www.terraform.io/downloads.html) (version 0.12+ recommended)
- [Google Cloud SDK (gcloud)](https://cloud.google.com/sdk/docs/install)

Additionally, you should have:

- A GCP account
- A configured GCP project
- Necessary permissions to create and manage GCP resources [Steps](#enabling-gcp-services)

## Getting Started

Follow these steps to get started with deploying your GCP infrastructure using Terraform.

### 1. Clone the Repository

First, fork this repository into your namespace. Then, clone your forked repository locally:

```bash
git clone https://github.com/<your-username>/tf-gcp-infra.git
cd tf-gcp-infra
```

### 2. GCP Authentication

Authenticate with GCP using the gcloud tool:

```bash
gcloud auth login
gcloud auth application-default login
```

Set your GCP project:

```bash
gcloud config set project YOUR_PROJECT_ID
```

### 3. Terraform Initialization

Initialize Terraform to download necessary providers and modules:

```bash
terraform init
```

### 4. Terraform Plan

Preview the changes Terraform will make to your infrastructure:

```bash
terraform plan
```

### 5. Terraform Apply

Apply the changes to create your infrastructure:

```bash
terraform apply
```

### 6. Manage Your Infrastructure

After applying, your infrastructure will be up and running. Use Terraform to manage and adjust your resources as needed:

- To change your infrastructure, edit the Terraform configuration files and repeat the plan and apply steps.

- To destroy your Terraform-managed infrastructure:

```bash
terraform destroy
```

## Enabling GCP Services

Before deploying the infrastructure with Terraform, ensure the following GCP services are enabled for your project:

- Compute Engine API (`compute.googleapis.com`)
- Cloud Storage API (`storage-component.googleapis.com`)
- Cloud SQL Admin API (`sqladmin.googleapis.com`)
- Identity and Access Management (IAM) API (`iam.googleapis.com`)

To enable these services:

1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Select your project.
3. Navigate to "APIs & Services" > "Dashboard".
4. Click "+ ENABLE APIS AND SERVICES".
5. Search for each of the services listed above and enable them.

Note: After enabling the services, it may take 10-15 minutes for them to become fully active.

test workflow commit
