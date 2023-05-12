app_server = {
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

env = "prod"