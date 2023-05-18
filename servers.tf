module "databases_server" {
  for_each = var.databases_server

  source = "./module"
  env = var.env
  app_server_name = each.value["name"]
  password = lookup(each.value,"password","null")
  instance_type = each.value["instance_type"]
  provisioner = true
}

module "app_server" {

  depends_on = [databases_server]

  for_each = var.app_server

  source = "./module"
  env = var.env
  app_server_name = each.value["name"]
  password = lookup(each.value,"password","null")
  instance_type = each.value["instance_type"]
}