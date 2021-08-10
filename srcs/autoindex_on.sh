#!/bin/bash
sed -i 's/autoindex off;/autoindex on;/' /etc/nginx/sites-available/site
service nginx reload
echo "autoindex on"
