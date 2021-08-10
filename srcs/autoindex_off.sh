#!/bin/bash
sed -i 's/autoindex on;/autoindex off;/' /etc/nginx/sites-available/site
service nginx reload
echo "autoindex off"
