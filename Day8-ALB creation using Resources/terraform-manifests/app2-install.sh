#!/bin/bash

sudo yum update -y
sudo yum install -y httpd


# Create a simple HTML file with the portfolio content and display the images
sudo cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>My Portfolio</title>
  <style>
    /* Add animation and styling for the text */
    @keyframes colorChange {
      0% { color: red; }
      50% { color: green; }
      100% { color: blue; }
    }
    h1 {
      animation: colorChange 2s infinite;
    }
  </style>
</head>
<body>
  <h1>Terraform Project Server 2</h1>
  <h2>Instance ID: <span style="color:green">$INSTANCE_ID</span></h2>
  <p>Welcome to vinod's Terraform Project-1</p>
  
</body>
</html>
EOF

# Start Apache and enable it on boot
sudo systemctl start httpd
sudo systemctl enable httpd