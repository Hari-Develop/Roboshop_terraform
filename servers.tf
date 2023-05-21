module "databases_server" {
  for_each = var.databases_server

  source = "./module"
  env = var.env
  app_server_name = each.value["name"]
  password = lookup(each.value,"password","null")
  instance_type = each.value["instance_type"]
  provisioner = true
  app_type = "database"
}

module "app_server" {

  depends_on = [module.databases_server]

  for_each = var.app_server

  source = "./module"
  env = var.env
  app_server_name = each.value["name"]
  password = lookup(each.value,"password","null")
  instance_type = each.value["instance_type"]
  provisioner = true
  app_type = "Application"
}