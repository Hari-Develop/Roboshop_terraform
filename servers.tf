module "servers" {
  for_each = var.app_server

  source = "./module"
  env = var.env
  app_server_name = each.value["name"]
  password = lookup(each.value,"password","null")
  instance_type = each.value["instance_type"]
}