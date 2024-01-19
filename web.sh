#!/bin/bash
echo "Hii kaviya" > index.html
nohup busybox httpd -f -p 80 &
EOF