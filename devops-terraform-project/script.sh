#!/bin/bash
yum -y update
ping -c 3 127.0.0.1
echo "OK"