FROM alpine:3.4
MAINTAINER Mikroways <christian.rodriguez@mikroways.net>

RUN apk add --update --no-cache rsnapshot gettext
ENV RETAIN_HOURLY ${RETAIN:-23}
ENV RETAIN_DAILY ${RETAIN:-6}
ENV RETAIN_WEEKLY ${RETAIN:-3}
ENV RETAIN_MONTHLY ${RETAIN:-11}
ENV RETAIN_YEARLY ${RETAIN:-2}
ENV PREFIX ""

COPY rsnapshot.conf /etc/rsnapshot.conf.tpl
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
RUN sed -i  's@print LOG@print@' /usr/bin/rsnapshot
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["hourly"]
