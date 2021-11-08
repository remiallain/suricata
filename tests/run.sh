docker run --rm \
    --cap-add=sys_nice \
    --cap-add=net_admin \
    --net=host \
    rallain/suricata:alpine-$(cat VERSION) \
    -i eth0
