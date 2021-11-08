FROM alpine@sha256:69704ef328d05a9f806b6b8502915e6a0a4faa4d72018dc42343f511490daf8a
RUN apk update \
    && apk add suricata=6.0.3-r1 \
    && apk upgrade \
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