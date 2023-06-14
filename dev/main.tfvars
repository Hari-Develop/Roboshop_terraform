env = "dev"
bastion_cidr = ["172.31.6.14/32"]
default_vpc_id = "vpc-05f71cf10b08267f1"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_rtb = "rtb-0261695bf0f118fe0"
kms_arn = "abhbbjdudb"

vpc = {
    main = {
      cidr_block = "10.0.0.0/16"

      subnets = {
        public = {
            name = "public"
            cidr_block = ["10.0.0.0/24","10.0.1.0/24"]
            azs = ["us-east-1a", "us-east-1b"]
        }
        web = {
            name = "web"
            cidr_block = ["10.0.2.0/24","10.0.3.0/24"]
            azs = ["us-east-1a", "us-east-1b"]
        }
        app = {
            name = "app"
            cidr_block = ["10.0.4.0/24","10.0.5.0/24"]
            azs = ["us-east-1a", "us-east-1b"]
        } 
        db = {
            name = "db"
            cidr_block = ["10.0.6.0/24","10.0.7.0/24"]
            azs = ["us-east-1a", "us-east-1b"]
        }        
      }
    }
}

app = {

  frontend = {
    instance_type = "t3.small"
    name = "frontend"
    subnet_name = "web"
    all_app_cidr = "public"
    desired_capacity   = 2
    max_size           = 5
    min_size           = 2
}
  catalogue = {
    instance_type = "t3.micro"
    name = "catalogue"
    subnet_name = "app"
    all_app_cidr = "web"
    desired_capacity   = 2
    max_size           = 5
    min_size           = 2
}

}


  docdb = {
    main = {
      subnet_name = "app"
      all_db_cidr = "db"
      engine_version = "4.0.0"
      instance_count = 1
      instance_class = "db.t3.medium"
    }
  }