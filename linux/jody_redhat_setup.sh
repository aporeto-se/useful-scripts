#!/bin/sh

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce-3:18.09.0-3.*
sudo systemctl enable docker
sudo systemctl start docker

sudo useradd admin
sudo cp -r /home/ec2-user/.ssh /home/admin
sudo chown -Rf admin:admin /home/admin

cat << EOF | sudo tee /etc/sudoers
Defaults   !visiblepw
Defaults    always_set_home
Defaults    match_group_by_gid
Defaults    always_query_group_plugin
Defaults    env_reset
Defaults    env_keep =  "COLORS DISPLAY HOSTNAME HISTSIZE KDEDIR LS_COLORS"
Defaults    env_keep += "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE"
Defaults    env_keep += "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES"
Defaults    env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"
Defaults    env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY"
Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin

root		ALL=(ALL) 	ALL
%wheel		ALL=(ALL)	NOPASSWD: ALL
EOF

sudo usermod -G docker,wheel admin
sudo dnf -y install jq nmap bind-utils
