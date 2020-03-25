#!/usr/bin/env sh
set -e

# Create new user `ssh` for current UID/GID
USER_ID="$(id -u)"
GROUP_ID="$(id -g)"
echo "ssh::${USER_ID}:${GROUP_ID}:SSH User:/usr/src/app:/bin/ash" >> /etc/passwd

# Add authorized ssh keys from env var
mkdir -p /usr/src/app/.ssh/
echo $KEYS >> /usr/src/app/.ssh/authorized_keys

# Start sshd synchronously, logging to STDOUT
exec /usr/sbin/sshd -De
