module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "5.16.0"

  name = "project-alb"
  load_balancer_type = "application"
  vpc_id = module.vpc.vpc_id
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]
  security_groups = [module.loadbalancer_sg.this_security_group_id]
  # Listeners
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      action_type = "fixed-response"
      fixed_response = {
        content_type = "text/plain"
        message_body = "Welcome to devops"
        status_code  = "200"
      }

    }
  ] 

  
  target_groups = [
    {
      name_prefix          = "app-tg"
      backend_protocol     = "HTTP"
      backend_port         = 8080
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {

        enabled             = true
        interval            = 30
        path                = "/app/*"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      # app Target Group - Targets
      targets = {
        app-tg = {
          target_id = module.ec2_private_app.id[0]
          port      = 8080
        }
      }
    }, 

    {
      name_prefix          = "j-tg"
      backend_protocol     = "HTTP"
      backend_port         = 8080
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
      
        enabled             = true
        interval            = 30
        path                = "/jenkins/*"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      # jenkins Target Group - Targets
      targets = {
        j-tg = {
          target_id = module.ec2_private_jenkins.id[0]
          port      = 8080
        },
      }
    }  
  ]

}

