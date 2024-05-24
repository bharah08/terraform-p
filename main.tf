provider "aws" {
    region="ap-south-1"
}
resource "aws_instance" "my" {
    ami="ami-0f58b397bc5c1f2e8"
    instance_type="t2.medium"
    key_name="aws"
    subnet_id="subnet-06bb28a2e5900658e"
    vpc_security_group_ids=["sg-0d6d89655d54e20db"]
    associate_public_ip_address = true
        provisioner "file" {
source= "C:/Users/lbhar/Downloads/script.sh"
destination= "/home/ubuntu/script.sh"
   }
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("C:/Users/lbhar/Downloads/aws.pem")
      timeout     = "4m"
   }
    provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nodejs -y",
      "sudo apt install npm -y",
      "sudo npm install pm2 -g",
      "git clone https://github.com/bharah08/nodejs-app-mss.git",
      "cd nodejs-app-mss",
      "npm install",
      "pm2 start app.js",
      
    ]
  }
}

