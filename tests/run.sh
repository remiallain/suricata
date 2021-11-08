docker run --rm \
    --cap-add=sys_nice \
    --cap-add=net_admin \
    --net=host \
    remiallain/suricata:$(cat VERSION) \
    -i eth0
