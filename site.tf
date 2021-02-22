
provider "incapsula" {
  api_id  = var.api_id
  api_key = var.api_key
}

variable "input_file" {}

locals {
  application_information = csvdecode(file(var.input_file))
}

resource "incapsula_site" "devops-sites" {
    count = length(local.application_information)

  domain                 = local.application_information[count.index].domain
  account_id             = local.application_information[count.index].account_id
  ref_id                 = "123456"
  force_ssl              = false //local.application_information[count.index].force_ssl
  data_storage_region    = local.application_information[count.index].data_storage_region
  send_site_setup_emails = local.application_information[count.index].send_site_setup_emails
  site_ip                = local.application_information[count.index].site_ip
  remove_ssl             = true
}
