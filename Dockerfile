FROM alpine@sha256:2d2b87c1842e1205589c87fd5319c8297c32bc0c85278bbc968fb9f9381bd708
RUN apk update \
    && apk add suricata=6.0.3-r1 \
    && rm -rf /var/cache/apk/*
VOLUME /var/log/suricata
VOLUME /var/lib/suricata
VOLUME /etc/suricata
RUN addgroup -g 2000 suricata && \
        adduser -S -H -u 2000 -D -g 2000 suricata && \
        chown -R suricata:suricata /etc/suricata && \
        chown -R suricata:suricata /var/log/suricata && \
        chown -R suricata:suricata /var/lib/suricata && \
        chown -R suricata:suricata /var/run/suricata
COPY ./docker-entrypoint.sh /
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD (ps cax | grep suricata > /dev/null)
ENTRYPOINT [ "/bin/sh", "/docker-entrypoint.sh" ]