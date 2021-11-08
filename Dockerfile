FROM alpine@sha256:5f82c1806d60592b747d6a53d35164b0c8f40e7ccf5425c1d59ae86ec8b3c0bc
RUN apk update \
    && apk add suricata=4.1.4-r5 \
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