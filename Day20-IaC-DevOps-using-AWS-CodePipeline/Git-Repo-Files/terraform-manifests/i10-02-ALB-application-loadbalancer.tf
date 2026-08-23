module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "10.5.0"

  name               = "${local.name}-alb"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  security_groups    = [module.lb_sg.id]
  load_balancer_type = "application" #default type is application lb

  # For example only
  enable_deletion_protection = false

  listeners = {
    my-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    } # End my-http-https-redirect Listener

    # Listener-2: my-https-listener
    my-https-listener = {
      port            = 443
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn = module.acm.acm_certificate_arn

      # Fixed Response for Root Context 
      fixed_response = {
        content_type = "text/plain"
        status_code  = 200
        message_body = "This is a fixed response"
      } # End of Fixed Response

      rules = {
        myapp1-rule = {
          actions = [{
            weighted_forward = {
              target_groups = [
                {
                  target_group_key = "mytg1"
                  weight           = 1
                }
              ]
              stickiness = {
                enabled  = true
                duration = 3600
              }
            }
          }]

          conditions = [{
            path_pattern = {
              values = ["/*"]
            }
          }]
        } #End of myapp1-rule
      }   #End Rules Block
    }     #End my-https-listener Block
  }       # End Listeners Block

  target_groups = {
    mytg1 = {
      # VERY IMPORTANT: We will create aws_lb_target_group_attachment resource separately when we use create_attachment = false, refer below GitHub issue URL.
      ## Github ISSUE: https://github.com/terraform-aws-modules/terraform-aws-alb/issues/316
      ## Search for "create_attachment" to jump to that Github issue solution
      create_attachment                 = false
      name_prefix                       = "mytg1-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = "use_load_balancer_configuration"
      protocol_version                  = "HTTP1"

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
      } # End of Health Check Block

      tags = local.common_tags

    }                      # END of Target Group-1: mytg1
  }                        # END OF target_groups
  tags = local.common_tags # ALB Tags
}                          # End of alb module