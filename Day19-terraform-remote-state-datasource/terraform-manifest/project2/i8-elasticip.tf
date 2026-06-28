# Create Elastic IP for Bastion Host
# Resource - depends_on Meta-Argument
resource "aws_eip" "bastion_eip" {
  depends_on = [module.bastion_ec2]
  tags       = local.common_tags
  # COMMENTED
  #instance = module.ec2_public.id[0]
  #vpc      = true

  # UPDATED
  instance = module.bastion_ec2.id
  domain   = "vpc"
  ## Local Exec Provisioner:  local-exec provisioner (Destroy-Time Provisioner - Triggered during deletion of Resource)
  provisioner "local-exec" {
    command     = "echo Destroy time prov `date` >> destroy-time-prov.txt"
    working_dir = "local-exec-output-files/"
    when        = destroy
    #on_failure = continue
  }
}