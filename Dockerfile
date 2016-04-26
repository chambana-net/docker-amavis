FROM chambana/base:latest

MAINTAINER Josh King <jking@chambana.net>

RUN apt-get -qq update && \
    apt-get install -y --no-install-recommends amavisd-new \
                                               spamassassin \
                                               clamav \
                                               clamav-daemon \
                                               clamav-freshclam \
                                               pyzor \
                                               razor \
                                               cron \
                                               rsyslog \
                                               supervisor && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV AMAVIS_REINJECTION_HOST postfix
ENV AMAVIS_REINJECTION_PORT 10025

RUN gpasswd -a clamav amavis
RUN gpasswd -a amavis clamav

ADD files/amavis/50-user /etc/amavis/conf.d/50-user
ADD files/clamav/clamd.conf /etc/clamav/clamd.conf
ADD files/rsyslog/rsyslog.conf /etc/rsyslog.conf
RUN freshclam

ADD files/supervisor/supervisord.conf /etc/supervisor/supervisord.conf

EXPOSE 10024

## Add startup script.
ADD bin/init.sh /opt/chambana/bin/init.sh
RUN chmod 0755 /opt/chambana/bin/init.sh

CMD ["/opt/chambana/bin/init.sh"]
