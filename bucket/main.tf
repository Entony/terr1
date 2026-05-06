resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = "aje7jd0rnpj5cihksvis"
}

module "s3_bucket" {
  source = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git?ref=v1.0.3"

  bucket_name = "my-bucket06052026"

  max_size = 1073741824

}
