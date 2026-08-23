resource "null_resource" "key_name_copy" {
  depends_on = [module.bastion_ec2_instance]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_eip.elasticip.public_ip
    password    = ""
    private_key = file("private-key/south-keypai-21052026.pem")
  }

  provisioner "file" {
    source      = "private-key/south-keypai-21052026.pem"
    destination = "/tmp/south-keypai-21052026.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /tmp/south-keypai-21052026.pem"
    ]
  }

}
