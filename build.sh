#!/usr/bin/env sh
set -e

apk add --no-cache openssh
ssh-keygen -A

# SSHD configuration
echo -e "ClientAliveInterval 1" >> /etc/ssh/sshd_config
echo -e "LoginGraceTime 120" >> /etc/ssh/sshd_config
echo -e "GatewayPorts yes" >> /etc/ssh/sshd_config
echo -e "Port 8022" >> /etc/ssh/sshd_config
echo -e "ClientAliveCountMax 10" >> /etc/ssh/sshd_config
echo -e "PermitEmptyPasswords no" >> /etc/ssh/sshd_config
echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_config
echo -e "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config
echo -e "AllowUsers ssh" >> /etc/ssh/sshd_config
echo -e "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
echo -e "PermitRootLogin no" >> /etc/ssh/sshd_config

# This makes sshd accept our authorized_keys file with the wrong ownership / permissions, in a
# directory with the wrong ownership / permissions
# TODO: Check if this is unsafe or not
echo -e "StrictModes no" >> /etc/ssh/sshd_config

# Enable to better debug sshd
# echo -e "LogLevel DEBUG" >> /etc/ssh/sshd_config

# Permit root group for all relevant files, since we're not root when running
chmod -R g+wr /etc/ssh
chmod g+w /etc/passwd
chmod -R g+w /run/
chmod -R g+wr /home/
chmod -R g+rwx /usr/src/app
