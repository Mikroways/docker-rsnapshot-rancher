FROM alpine:3.4
MAINTAINER Mikroways <christian.rodriguez@mikroways.net>

RUN apk add --update --no-cache rsnapshot gettext
ENV RSNAPSHOT_HOURLY_RETAIN ${RSNAPSHOT_HOURLY_RETAIN:-11}
ENV RSNAPSHOT_DAILY_RETAIN ${RSNAPSHOT_DAILY_RETAIN:-6}
ENV RSNAPSHOT_WEEKLY_RETAIN ${RSNAPSHOT_WEEKLY_RETAIN:-4}
ENV RSNAPSHOT_MONTHLY_RETAIN ${RSNAPSHOT_MONTHLY_RETAIN:-11}
ENV RSNAPSHOT_YEARLY_RETAIN ${RSNAPSHOT_YEARLY_RETAIN:-4}
ENV PREFIX ""

COPY rsnapshot.conf /etc/rsnapshot.conf.tpl
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
RUN sed -i  's@print LOG@print@' /usr/bin/rsnapshot 
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["hourly"]
