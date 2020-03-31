# Purpose

Simple SSH server allowing connections by public key authorization, intended as a jump host into an OpenShift infrastructure.

# How to use

```bash
# Build locally
docker build . -t zeilenwerk/openssh-server

# Run locally with random UID, mapping port 8022 and authorizing given keys
docker run --rm -u 10001:0 -p 8022:8022 --env "KEYS=SSH_KEY_ONE:SSH_KEY_TWO" zeilenwerk/openssh-server

# Push any changes to docker hub
docker push zeilenwerk/openssh-server
```
