variable "app_server" {
default = {
    frontend = {
        name = "frontend"
        instance_type = "t3.micro"
    }
    catalogue = {
        name = "catalogue"
        instance_type = "t3.micro"
    }
    cart = {
        name = "cart"
        instance_type = "t3.micro"
    }
    user = {
        name = "user"
        instance_type = "t3.micro"
    }
    payment = {
        name = "payment"
        instance_type = "t3.micro"
    }
    shipping = {
        name = "shipping"
        instance_type = "t3.micro"
    }
}
    }

resource "aws_instance" "instance" {
    for_each = var.app_server
    ami = "ami-0b5a2b5b8f2be4ec2"
    instance_type = each.value["instance_type"]
    vpc_security_group_ids = [data.aws_security_group.allow-all.id]

    tags = {
        Name = each.value["name"]
    }
}

resource "aws_route53_record" "records" {
    for_each = var.app_server
    zone_id = "Z087200837M4TMDK3PVWB"
    name = "${each.value["name"]}-dev.unlockers.online"
    records = [aws_instance.instance.private_ip]
}





