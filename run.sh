#!/bin/bash

echo "Terraform Play Time ~~"
export pub=`cat ~/.ssh/id_rsa.pub`
terraform init -var "key_devops=${pub}"
terraform apply -auto-approve -var "key_devops=${pub}"
echo "CHECK ALL EC2 UP..."
while true
do
    ansible all -m ping > /dev/null
    if [[ "$?" == "0" ]] 
    then
        echo "Ansible Play Time ~~"
        break
    fi
done
ansible-playbook playbook.yml
