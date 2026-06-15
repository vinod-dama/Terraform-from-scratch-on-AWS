##################################################################
# Application Load Balancer
##################################################################

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "10.5.0"

  name = "${local.name}-alb"
  load_balancer_type = "application"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  # For example only
  enable_deletion_protection = false

  # Security Group
  security_groups = [module.lb_sg.security_group_id]

  listeners = {
    my-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }

    my-https-listeners = {
      port                        = 443
      protocol                    = "HTTPS"
      ssl_policy                  = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn             = module.acm.acm_certificate_arn
    
      fixed_response = {
              content_type = "text/plain"
              status_code  = 200
              message_body = "This is a fixed response for Root context"
            }
          }


      rules = {
        myapp1-rule = {
          actions = [{
            weighted_forward = {
              target_groups = [
                {
                  target_group_key = "my-tg1"
                  weight           = 1
                }
              ]
              stickiness = {
                enabled  = true
                duration = 3600
              }
            }
          }]

          conditions = [
            {
              path_pattern = {
                values = ["/app1*"]
              }
            },
          ]
        }

        myapp1-rule = {
          actions = [{
            weighted_forward = {
              target_groups = [
                {
                  target_group_key = "my-tg2"
                  weight           = 1
                }
              ]
              stickiness = {
                enabled  = true
                duration = 3600
              }
            }
          }]

          conditions = [
            {
              path_pattern = {
                values = ["/app2*"]
              }
            }
          ]
        }
      }
    }

    target_groups = {
    my-tg1 = {
      create_attachment = false
      name_prefix                       = "my-tg1"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

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
      }

      tags = local.common_tags
    }
    

    my-tg2 = {
      name_prefix                       = "my-tg2"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app2/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      tags = local.common_tags
    }

  }
  tags = local.common_tags
}



# mytg1: LB Target Group Attachment
resource "aws_lb_target_group_attachment" "mytg1" {
  for_each = {for k,v in module.ec2_private_app1: k => v}
  target_group_arn = module.alb.target_groups["mytg1"].arn
  target_id        = each.value.id
  port             = 80
}


# mytg2: LB Target Group Attachment
resource "aws_lb_target_group_attachment" "mytg1" {
  for_each = {for k,v in module.ec2_private_app1: k => v}
  target_group_arn = module.alb.target_groups["mytg1"].arn
  target_id        = each.value.id
  port             = 80
}





