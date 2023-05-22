
resource "aws_instance" "instance" {
    ami = "ami-0b5a2b5b8f2be4ec2"
    instance_type = var.instance_type
    vpc_security_group_ids = [data.aws_security_group.allow-all.id]
    iam_instance_profile = aws_iam_instance_profile.instance_profile.name


    tags = {
        Name = local.name
    }
}

resource "null_resource" "provisioner" {
depends_on = [ aws_instance.instance,aws_route53_record.records ]
provisioner "remote-exec" {

     connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host = aws_instance.instance.private_ip
  }

  inline = var.app_type == "database" ? local.database_commands : local.app_commands
}

}

resource "aws_route53_record" "records" {
    zone_id = "Z087200837M4TMDK3PVWB"
    name = "${var.app_server_name}-dev.unlockers.online"
    records = [aws_instance.instance.private_ip]
    type = "A"
    ttl = "30"
}

resource "aws_iam_role" "instance_role" {
  name = "${var.app_server_name}-${var.env}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.app_server_name}-${var.env}-role"
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.app_server_name}-${var.env}-role"
  role = aws_iam_role.instance_role.name
}


resource "aws_iam_role_policy" "ssm-ps-policy" {
  name        = "${var.app_server_name}-${var.env}-role-policy"
  role        = aws_iam_role.instance_role.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameterHistory",
                "ssm:GetParametersByPath",
                "ssm:GetParameters",
                "ssm:GetParameter"
            ],
            "Resource": "arn:aws:ssm:us-east-1:655343820221:parameter/${var.env}.${var.app_server_name}.*"
        }
    ]
})
}

