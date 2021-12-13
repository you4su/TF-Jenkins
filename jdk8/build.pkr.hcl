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
      #"echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiYiVFXOkOAHTbi+zk+MlZBnteDUj0g9u9jZsSu398ApHfH/5sgihtWm6wwD3UuGLT0vtZIS2lihSmcNH4IHn+XHl9xP/ohYg4wdN4RujnxeIcpn0q9oyCp7VOlxxodAEm+TPeW3pPQFh+hmzlpoqIFZrwNsmQiFKKLLt/bi7WFc0gTcrkW8mSiKHj4SkgOQsXvOmT0/Sn3SVUejs6IjTIRHSPuwU+aHEvJwbJrc1uC8dxp433qRZy07DU48+8tsc4a2SxZ3XgTEAMQzPS9wPJY4p2ZAq9Vr1Lai4fMlAYtygGx5AayDUxzIISPdqbCOkV7PRzDPSKUBIWJXh0iifD jenkins-master-2-slave' >> /home/ubuntu/.ssh/authorized_keys",
      #"echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUcULR2jDqG/6vVFLzRyDhlSwd0ufh0SM/r5GxnDhj+bf39kmPS4uL/mzEkbbYOyPJ6Y539Jt5ipP5WyUFZWrg4e2l/Usf/W70fzP1gBfHZEQuouHSQir0yux0aJGZJjtUKHx29c/IX+ib3sToZRrNXBNyZrhL7HFHAiIgyOUsK8lpYBxY31d6Nfjp38LCnobqkLyUzWNCi68Ovi7WbfewAhTT3DDZq5fJBkOd4hDv/1XuMgA8c8HgkuXCC5asrlqlkUNB32mGvEzHw861RMnC9GxGuY+Pgs63oJXDL72eKnRo1BqmtsC7H+SDK30hL3tsUvSrnopv7eYWnuH0YfBB ltxpi6h7' >> /home/ubuntu/.ssh/authorized_keys",
      #"echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWHsL1iEeBQZlqmQbGnW7kD7peXfYMXXcECs+JL4z0KBmJ72UgiJ1Ce93VEHrSrAuTuM0P2Y4/f0C0FR2PoF3lM6U1aqbBUSR1Cts7+PmLcdI6dUlvr3J9ec7G+fbFhN9zri5HY8HMH+Rl3fintdONAMOgjjD1xB88kNmH63zQU6C8eG40ecd2MVMqU9YXb0M3yvcXabI/5kNnYLDn8j/r8FD51itaa9TJRBYtF38GUqqPKxUH7Po2L1H1Qy8p/ljAXaw59yRYnevUVGY0XttUckk2GLWT/RV0QF6J+kMFuvf/LL+fozdrqSOIR6U7k/DPOYdiadowa+iW+ZiV7BZj'>> /home/ubuntu/.ssh/authorized_keys",
       "echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDimPnfTY+41Rbz4MSfF4JvsziK+6aAmQ4WX0QVBkWcq8YIhHMHaM/cv23Ip76tiEWopATVC8XW2k19jP3H/A2BDF4ZwPhDTLrew/9aPR14eQl6Wvezc9/pQ7vmAs9q+NhroXY8ihRJSJvAosJKlzYbJEOhQrsq4CtCfamI3RRj8a5dQH4nAtGvDUpurnPlPX1gBRyuIPFCnYrZZIo1KU86NuxmuigGLavVone0bKZRNGIbS8NwJWPfkyjsmnPgDmOoc1tfMkW3RUNkQiBQ6MwK3T2eirbF/GPGfP8IsQWTsLXLNysngNH1XLBF9pxpyMCY9NTQAiOymzqs07ZdN0RT imported-openssh-key' >> /home/ubuntu/.ssh/authorized_keys",
      "sudo chmod 700 /home/ubuntu/.ssh",
      "sudo chmod 600 /home/ubuntu/.ssh/authorized_keys",
      "sudo chmod u+x /tmp/install_essentials.sh",
      "sudo bash /tmp/install_essentials.sh"
      ]
  }
}
