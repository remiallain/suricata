# Suricata - Lightweight Docker image 

Suricata Docker image based on Alpine

## Usage

```bash
docker run --rm \
    --cap-add=sys_nice \
    --cap-add=net_admin \
    --net=host \
    remiallain/suricata:$(VERSION) \
    -i eth0
```

## Audit

### Vulnerabilities (Snyk)

Last run on Mon 08 Nov 2021 04:51:40 PM CET

```
Testing remiallain/suricata:6.0.3...

Package manager:   apk
Project name:      docker-image|remiallain/suricata
Docker image:      remiallain/suricata:6.0.3
Platform:          linux/amd64
Base image:        alpine:3.14.2

✓ Tested 54 dependencies for known vulnerabilities, no vulnerable paths found.

According to our scan, you are currently using the most secure version of the selected base image
```