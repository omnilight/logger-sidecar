FROM alpine

ENV MAX_MESSAGE_SIZE=8k

RUN apk add --no-cache rsyslog
COPY ./rsyslog/rsyslogd.conf /etc/rsyslogd.conf
COPY ./inject_envs.sh /usr/local/bin/inject_envs.sh
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 514/tcp 514/udp
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["rsyslogd", "-n", "-f", "/etc/rsyslogd.conf"]