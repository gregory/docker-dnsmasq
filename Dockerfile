FROM debian:wheezy

RUN apt-get update && apt-get install -y \
    dnsmasq \
    dnsutils

RUN echo 'resolv-file=/etc/resolv.dnsmasq.conf' >> /etc/dnsmasq.conf &&\
    echo 'conf-dir=/etc/dnsmasq.d' >> /etc/dnsmasq.conf &&\
    echo 'user=root' >> /etc/dnsmasq.conf &&\
    echo 'nameserver 8.8.8.8' >> /etc/resolv.dnsmasq.conf &&\
    echo 'nameserver 8.8.4.4' >> /etc/resolv.dnsmasq.conf

EXPOSE 53/udp

CMD echo "address=\"/.$TARGET_DOMAIN/$TARGET_IP\"" > /etc/dnsmasq.d/0hosts && /usr/sbin/dnsmasq -k -C /etc/dnsmasq.conf
