FROM alpine:latest as builder

LABEL org.opencontainers.image.authors="Mitch McAffee"
LABEL org.opencontainers.image.source="https://github.com/themcaffee/dnsmasq"
LABEL org.opencontainers.image.description="Dnsmasq is a lightweight, easy to configure DNS forwarder and DHCP server."
LABEL org.opencontainers.image.LICENSE=GPL

ARG VERSION
RUN apk add --no-cache make gcc g++ binutils autoconf automake libtool pkgconfig check-dev file patch git linux-headers
RUN git clone git://thekelleys.org.uk/dnsmasq.git --branch=$VERSION --depth=1
WORKDIR /dnsmasq
RUN make install

FROM alpine:latest
COPY --from=builder /usr /usr
COPY --from=builder /dnsmasq/dnsmasq.conf.example /etc/dnsmasq.conf
CMD ["/usr/local/sbin/dnsmasq", "--no-daemon", "--log-queries", "--log-facility=-", "--conf-file=/etc/dnsmasq.conf"]