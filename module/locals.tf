locals {
  name = var.env != "" ? "${var.app_server_name}-${var.env}" : var.app_server_name

  database_commands = [
    "rm -rf roboshop-shell",
    "git clone https://github.com/Hari-Develop/roboshop-shell.git",
    "cd roboshop-shell",
    "sudo bash ${var.app_server_name}.sh ${var.password}"
    ]

     app_commands = [
      "sudo labauto ansible",
      "ansible-pull -i localhost, -U https://github.com/Hari-Develop/roboshop_ansible roboshop.yml -e env=${var.env} -e role_name=${var.app_server_name}"
    ]

    app_tags = {
      Name = "${var.app_server_name}-${var.env}"
    }

    db_tags = {
      Name = "${var.app_server_name}-${var.env}"
      monitor = true
    }


}