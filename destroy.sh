#!/bin/bash

read -p "Destory All EC2...Is this ok?[y/n]: " ans
[[ $ans == 'y' ]] && terraform destroy --auto-approve