FROM ubuntu:22.04

RUN apt update
RUN apt install coturn gettext -y

RUN sed -i "s/USER=turnserver/USER=root/" /etc/init.d/coturn
RUN sed -i "s/GROUP=turnserver/GROUP=root/" /etc/init.d/coturn
RUN sed -i "s/#TURNSERVER_ENABLED=1/TURNSERVER_ENABLED=1/" /etc/default/coturn

RUN service coturn stop
#RUN service coturn start

#/etc/default/coturn -> TURNSERVER_ENABLED=1
COPY .env /etc/environment
COPY turnserver.conf /etc/turnserver.conf.template

CMD envsubst < /etc/turnserver.conf.template > /etc/turnserver.conf && service coturn start && tail -f /dev/null
