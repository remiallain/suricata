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