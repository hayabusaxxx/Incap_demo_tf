terraform {
  required_providers {
    incapsula = {
      source = "imperva/incapsula"
      version = "2.7.1"
    }
  }
}

provider "incapsula" {
  api_id = "35609"
  api_key = "67a7731e-0fb5-4f4d-a13d-83fad154c240"
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
  ignore_ssl            = true
  remove_ssl            = true
}
