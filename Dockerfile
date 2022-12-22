FROM alpine:latest as builder

ARG VERSION
RUN apk add --no-cache make gcc g++ binutils autoconf automake libtool pkgconfig check-dev file patch git linux-headers
RUN git clone git://thekelleys.org.uk/dnsmasq.git --branch=$VERSION --depth=1
WORKDIR /dnsmasq
RUN make install

FROM alpine:latest
COPY --from=builder /usr /usr
COPY --from=builder /dnsmasq/dnsmasq.conf.example /etc/dnsmasq.conf
CMD ["/usr/local/sbin/dnsmasq", "--no-daemon", "--log-queries", "--log-facility=-", "--conf-file=/etc/dnsmasq.conf"]