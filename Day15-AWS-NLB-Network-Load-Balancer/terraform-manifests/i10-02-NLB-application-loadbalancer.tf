##################################################################
# Application Load Balancer
##################################################################

module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "10.5.0"

  name               = "${local.name}-nlb"
  load_balancer_type = "network"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets

  # For example only
  enable_deletion_protection = false

  # Security Group
  security_groups = [module.lb_sg.security_group_id]

  # Listeners
  listeners = {
    # Listener-1: my-tcp-listener
    my-tcp-listener = {
      port     = 80
      protocol = "TCP"
      forward = {
        target_group_key = "mytg1"
      }
    } # End of my-tcp-listener


    # Listener-1: my-tcp-listener
    my-tls-listener = {
      port     = 443
      protocol = "TLS"
      certificate_arn = module.acm.acm_certificate_arn
      forward = {
        target_group_key = "mytg1"
      }
    } # End of my-tls-listener

  } # End Listeners Block

  # Target Groups
  target_groups = {
    # Target Group-1: mytg1     
    mytg1 = {
      # VERY IMPORTANT: We will create aws_lb_target_group_attachment resource separately when we use create_attachment = false, refer above GitHub issue URL.
      ## Github ISSUE: https://github.com/terraform-aws-modules/terraform-aws-alb/issues/316
      ## Search for "create_attachment" to jump to that Github issue solution
      create_attachment                 = false
      name_prefix                       = "mytg1-"
      protocol                          = "TCP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }                        # End of health_check Block
      tags = local.common_tags # Target Group Tags 
    }                          # END of Target Group: mytg1
  }                            # END OF target_groups Block
  tags = local.common_tags     # LB Tags
}



