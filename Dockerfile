FROM golang:1.14 as go-builder
WORKDIR /
ENV GO111MODULE=on
RUN apt-get update && apt-get install -yq build-essential git
RUN git clone -b "v0" https://github.com/erdii/go-get-s3-object-version \
	&& cd go-get-s3-object-version \
	&& make build


FROM debian:10-slim
RUN apt-get -y update && \
	apt-get -y install squid netcat-openbsd
COPY --chown=root:root --from=go-builder /go-get-s3-object-version/build/go-get-s3-object-version /usr/local/bin
