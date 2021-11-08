FROM alpine@sha256:c3d45491770c51da4ef58318e3714da686bc7165338b7ab5ac758e75c7455efb
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