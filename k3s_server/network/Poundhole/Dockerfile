FROM pihole/pihole:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y 

RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d

RUN sudo apt-get install unbound -y

#RUN wget -O /home/root.hints https://www.internic.net/domain/named.root
#RUN sudo mv /home/root.hints /var/lib/unbound/

#COPY pi-hole.conf /etc/unbound/unbound.conf.d/pi-hole.conf

#CMD [sudo service unbound start]