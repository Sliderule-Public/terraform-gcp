# Sliderule GCP Ecosystem

## Steps to deploy
- create GCP project
- Enable the services in the `Services to Enable` section below if needed
- create terraform service account for project, add credentials to terraform provider
- create `sliderule_secret` secret in project with POSTGRES_USER and POSTGRES_PASSWORD
- create repos outside of this stack
- apply Terraform

## Services to Enable
- servicemanagement.googleapis.com
- servicecontrol.googleapis.com
- cloudresourcemanager.googleapis.com
- compute.googleapis.com
- container.googleapis.com
- containerregistry.googleapis.com
- servicenetworking.googleapis.com
- artifactregistry.googleapis.com
- cloudkms.googleapis.com
- certificatemanager.googleapis.com
- secretmanager.googleapis.com
- iamcredentials.googleapis.com
- sqladmin.googleapis.com


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.61.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 4.61.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.9.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.19.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.1.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.80.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.11.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.23.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application_storage_bucket"></a> [application\_storage\_bucket](#module\_application\_storage\_bucket) | ./modules/storage_bucket | n/a |
| <a name="module_compute_network"></a> [compute\_network](#module\_compute\_network) | ./modules/compute_network | n/a |
| <a name="module_database"></a> [database](#module\_database) | ./modules/cloud_sql_database_and_instance | n/a |
| <a name="module_gke_cluster"></a> [gke\_cluster](#module\_gke\_cluster) | ./modules/gke | n/a |
| <a name="module_kms_key_main"></a> [kms\_key\_main](#module\_kms\_key\_main) | ./modules/kms_crypto_key | n/a |
| <a name="module_main_pub_sub_topic"></a> [main\_pub\_sub\_topic](#module\_main\_pub\_sub\_topic) | ./modules/pub_sub | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_global_address.api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_global_address.web](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_project_iam_member.secretadmin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.service_account_token_creator](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.sliderule](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.pod_identity](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [helm_release.prerequisites](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.secrets](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.sliderule](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.sliderule_base](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.sliderule](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.sliderule_prerequisites](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.sliderule](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [null_resource.allow_base_to_deploy](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.allow_prerequisites_to_build_crds](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.allow_secrets_to_populate](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.allow_base_to_deploy](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.allow_prerequisites_to_build_crds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.allow_secrets_to_populate](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [google_client_config.provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_image_url"></a> [api\_image\_url](#input\_api\_image\_url) | n/a | `string` | n/a | yes |
| <a name="input_api_url"></a> [api\_url](#input\_api\_url) | n/a | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_google_provider_credential_file"></a> [google\_provider\_credential\_file](#input\_google\_provider\_credential\_file) | n/a | `string` | n/a | yes |
| <a name="input_grpc_url"></a> [grpc\_url](#input\_grpc\_url) | n/a | `string` | n/a | yes |
| <a name="input_helm_chart_repository"></a> [helm\_chart\_repository](#input\_helm\_chart\_repository) | n/a | `string` | `"https://sliderule-public.github.io/helm-charts/"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-central1"` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | n/a | `string` | `""` | no |
| <a name="input_web_image_url"></a> [web\_image\_url](#input\_web\_image\_url) | n/a | `string` | n/a | yes |
| <a name="input_web_url"></a> [web\_url](#input\_web\_url) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->