#!/bin/bash
sudo apt-get update -y
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo echo "<html><body><h1>Hello Braulio</h1></body></html>" | sudo tee /var/www/html/index.html
