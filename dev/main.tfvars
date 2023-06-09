env = "dev"
bastion_cidr = ["172.31.6.14/32"]
default_vpc_id = "vpc-05f71cf10b08267f1"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_rtb = "rtb-0261695bf0f118fe0"
kms_arn = "arn:aws:kms:us-east-1:513840145359:key/7c7c9941-f247-48e3-87d9-479971eb6ac6"
domain_name = "unlockers.online" 
domain_id   = "Z09407433C3HCTSY5GY69"

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
    app_port           = 80
    listener_priority  = 1
    al_type             = "public"
    dns_name            = "dev"
}
  catalogue = {
    instance_type = "t3.micro"
    name = "catalogue"
    subnet_name = "app"
    all_app_cidr = "web"
    desired_capacity   = 2
    max_size           = 5
    min_size           = 2
    app_port           = 8080
    listener_priority  = 2
    al_type             = "private"
}

}


  docdb = {
    main = {
      subnet_name = "db"
      all_db_cidr = "app"
      engine_version = "4.0.0"
      instance_count = 1
      instance_class = "db.t3.medium"
    }
  }

  rds = {
    main = {
      subnet_name = "db"
      all_db_cidr = "app"
      engine_version = "5.7.mysql_aurora.2.11.2"
      instance_count = 1
      instance_class = "db.t3.small"
    }
  }


  elasticache = {
    main = {
      subnet_name = "db"
      all_db_cidr = "app"
      engine_version = "6.x"
      num_node_groups = 1
      node_type = "cache.t3.small"
      replicas_per_node_group = 1
    }
  }

  rabbitmq = {
    main = {
      subnet_name = "db"
      all_db_cidr = "app"
      instance_type = "t3.small"
    }
  }

  alb = {
    public = {
      name = "public"
      subnet_name = "public"
      all_alb_cidr = null
      internal = false
    }
    private = {
      name = "private"
      subnet_name = "app"
      all_alb_cidr = "web"
      internal = true
  }
}