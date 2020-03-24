#!/usr/bin/env sh
set -e
USER_ID="$(id -u)"
GROUP_ID="$(id -g)"

echo "ssh::${USER_ID}:${GROUP_ID}:SSH User:/usr/src/app:/bin/ash" >> /etc/passwd
echo $KEYS >> /etc/ssh/authorized-keys

exec /usr/sbin/sshd -De
