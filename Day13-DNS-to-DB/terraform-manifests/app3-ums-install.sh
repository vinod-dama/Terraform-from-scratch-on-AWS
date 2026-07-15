sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start  
export DB_HOSTNAME=rdsdbinstance.c9wug8awoxg2.ap-south-1.rds.amazonaws.com
export DB_PORT=3306
export DB_NAME=webappdb
export DB_USERNAME=dbadmin
export DB_PASSWORD=dbpassword11
sudo echo '<h1>Welcome to Vinod Project - Build Terrform from scratch on AWS - APP3</h1>' | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/app3
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Bulding Path based routing in in ALB using Teraform - APP-3</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app3/index.html
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
sudo curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app3/metadata.html
# AWS Documentation to retrieve EC2 Instance Data
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html


#sudo java -jar /home/ec2-user/app3-usermgmt/usermgmt-webapp.war \
#> /home/ec2-user/app3-usermgmt/ums-start.log 2>&1 &




