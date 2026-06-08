resource "null_resource" "cluster" {
  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  depends_on = [ module.bastion_ec2 ]
  connection {
    host = aws_eip.bastion_eip.public_ip   
    user = "ec2-user"
    password = ""
    private_key = file("${path.module}/my-ssh-key.pem")
  }

  provisioner "file" {
    # Bootstrap script called with private_ip of each node in the cluster
      source = "private-key/south-keypai-21052026.pem"
      destination = "/tmp/south-keypai-21052026"
  }
   provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "sudo chmod 400 /tmp/terraform-key.pem"
    ]
  }

  provisioner "local-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    command     = "VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
  }

}


 