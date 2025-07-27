#!/bin/bash

echo "Starting user data script" 

touch /home/ubuntu/heyyy.txt
sudo apt-get update -y 
sudo apt-get install nginx -y 
sudo systemctl start nginx 
sudo systemctl enable nginx

echo "<h1> Hey Babyy, We will make it big. </h1>" > /var/www/html/index.html
