# dnsmasq

Builds dnsmasq from source and publishes it as a docker image using Github actions. An action runs daily to sync tags with the source
dnsmasq [repo](https://thekelleys.org.uk/dnsmasq/doc.html). New tags are then built and deployed to the following platforms:

```
linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x
```

## Usage

To use this image install it from the command line and use directly:

```
docker pull ghcr.io/themcaffee/dnsmasq:v2.89
```

or use as a base for a Dockerfile:

```
FROM ghcr.io/themcaffee/dnsmasq:v2.89
```