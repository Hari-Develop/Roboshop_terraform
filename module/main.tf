
resource "aws_instance" "instance" {
    ami = "ami-0b5a2b5b8f2be4ec2"
    instance_type = var.instance_type
    vpc_security_group_ids = [data.aws_security_group.allow-all.id]

    tags = {
        Name = local.name
    }
}

resource "null_resource" "provisioner" {

depends_on = [ aws_instance.instance,aws_route53_record.records ]

connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = "[aws_instance.instance.private_ip]"
  }

provisioner "remote-exec" {
  inline = [
    "rm -rf roboshop-shell",
    "git clone https://github.com/Hari-Develop/roboshop-shell.git",
    "sudo bash ${var.app_server_name}.sh ${var.password}"
    ]
}

}


resource "aws_route53_record" "records" {
    zone_id = "Z087200837M4TMDK3PVWB"
    name = "${var.app_server_name}-dev.unlockers.online"
    records = [aws_instance.instance.private_ip]
    type = "A"
    ttl = "30"
}





