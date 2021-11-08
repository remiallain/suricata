FROM alpine@sha256:a721d672be3cdaaf1285c2b60b76d81ab4a8a3cf5a7180a966f2c545305ad6de
RUN apk update \
    && apk --no-cache add suricata=5.0.3-r0 \
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