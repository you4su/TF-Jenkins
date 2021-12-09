source "amazon-ebs" "aws" {
  access_key    = ""
  secret_key    = ""
  subnet_id     = "subnet-0bfc0d4034e3e3fff"
  ami_name      = "Jenkins-Gold-Slave-Image-jdk8-1.7"
  instance_type = "t2.large"
  region        = "us-east-1"
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
    source = "./install_new2_essentials.sh.sh"
    destination = "/tmp/install_new2_essentials.sh.sh"
  }

  # Update Linux instance to latest packages
  # Add required repos for java and jenkins
  # Install required packages (java and jenkins)
 provisioner "shell" {
    inline = [
      "echo Adding ssh public key",
      "echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiYiVFXOkOAHTbi+zk+MlZBnteDUj0g9u9jZsSu398ApHfH/5sgihtWm6wwD3UuGLT0vtZIS2lihSmcNH4IHn+XHl9xP/ohYg4wdN4RujnxeIcpn0q9oyCp7VOlxxodAEm+TPeW3pPQFh+hmzlpoqIFZrwNsmQiFKKLLt/bi7WFc0gTcrkW8mSiKHj4SkgOQsXvOmT0/Sn3SVUejs6IjTIRHSPuwU+aHEvJwbJrc1uC8dxp433qRZy07DU48+8tsc4a2SxZ3XgTEAMQzPS9wPJY4p2ZAq9Vr1Lai4fMlAYtygGx5AayDUxzIISPdqbCOkV7PRzDPSKUBIWJXh0iifD jenkins-master-2-slave' >> /home/ubuntu/.ssh/authorized_keys",
      "sudo chmod 700 /home/ubuntu/.ssh",
      "sudo chmod 600 /home/ubuntu/.ssh/authorized_keys",
      "sudo chmod u+x /tmp/install_new2_essentials.sh.sh",
      "sudo bash /tmp/install_new2_essentials.sh.sh"
      ]
  }
}
