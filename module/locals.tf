locals {
  name = var.env != "" ? "${var.app_server_name}-${var.env}" : var.app_server_name
}