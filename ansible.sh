ssh_username=$(aws ssm get-parameter --name "ssh_username" --with-decryption --query "Parameter.Value" --output text)
ssh_password=$(aws ssm get-parameter --name "ssh.ssh_password" --with-decryption --query "Parameter.Value" --output text)

ansible-playbook -i 172.31.35.165, prometheus.yml -e ansible_user=$ssh_username -e ansible_password=$ssh_password



# this we are using for fetching passwords for aws ssm parameters