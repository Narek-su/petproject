#!/bin/bash
apt update
apt install -y nginx

echo "Hello World from $(hostname -f)" > /var/www/html/index.html