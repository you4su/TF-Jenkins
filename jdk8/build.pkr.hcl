source "amazon-ebs" "aws" {
  access_key    = ""
  secret_key    = ""
  subnet_id     = "subnet-0bfc0d4034e3e3fff"
  ami_name      = "Jenkins-Gold-Slave-Image-jdk8-2.5"
  instance_type = "t2.large"
  region        = "us-east-1"
  launch_block_device_mappings {
    device_name = "/dev/sda1"
    volume_size = 40
    volume_type = "gp2"
    delete_on_termination = true
  }
  source_ami_filter {
    filters = {
      name                = "Ubuntu18-Gold-Image-Production-3.4"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["415878142550"]
  }
  ssh_username = "ubuntu"
//  tags = {
//    RESOURCE_GROUP_NAME = "${var.resource_group_name}"
//    Base_AMI_ID         = "{{ .SourceAMI }}"
//    Base_AMI_Name       = "{{ .SourceAMIName }}"
//    App                 = "${var.app_name}"
//    Env                 = "${var.env_name}"
//  }
}

# Build the images
build {
  sources = [
    "source.amazon-ebs.aws",
  ]

  provisioner "file" {
    source = "./install_essentials.sh"
    destination = "/tmp/install_essentials.sh"
  }

  # Update Linux instance to latest packages
  # Add required repos for java and jenkins
  # Install required packages (java and jenkins)
 provisioner "shell" {
    inline = [
      "echo Adding ssh public key",
      "echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDimPnfTY+41Rbz4MSfF4JvsziK+6aAmQ4WX0QVBkWcq8YIhHMHaM/cv23Ip76tiEWopATVC8XW2k19jP3H/A2BDF4ZwPhDTLrew/9aPR14eQl6Wvezc9/pQ7vmAs9q+NhroXY8ihRJSJvAosJKlzYbJEOhQrsq4CtCfamI3RRj8a5dQH4nAtGvDUpurnPlPX1gBRyuIPFCnYrZZIo1KU86NuxmuigGLavVone0bKZRNGIbS8NwJWPfkyjsmnPgDmOoc1tfMkW3RUNkQiBQ6MwK3T2eirbF/GPGfP8IsQWTsLXLNysngNH1XLBF9pxpyMCY9NTQAiOymzqs07ZdN0RT spgs6nf2' >> /home/ubuntu/.ssh/authorized_keys",
      "chmod 700 /home/ubuntu/.ssh",
      "chmod 600 /home/ubuntu/.ssh/authorized_keys",
      "chmod u+x /tmp/install_essentials.sh",
      "sudo bash /tmp/install_essentials.sh"
      ]
  }
}
