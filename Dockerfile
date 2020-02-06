FROM alpine

ENV MAX_MESSAGE_SIZE=8k
ENV QUEUE_WORKER_THREADS=2
ENV QUEUE_DEQUEUE_BATCH_SIZE=1000
ENV QUEUE_SIZE=10000

RUN apk add --no-cache rsyslog
COPY ./rsyslog/rsyslogd.conf /etc/rsyslogd.conf
COPY ./inject_envs.sh /usr/local/bin/inject_envs.sh
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 514/tcp 514/udp
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["rsyslogd", "-n", "-f", "/etc/rsyslogd.conf"]