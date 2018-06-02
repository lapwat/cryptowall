FROM alpine:latest

RUN apk add --update alpine-sdk bash

WORKDIR /build
RUN git clone https://github.com/maandree/libkeccak.git && \
    cd libkeccak && \
    make install

RUN git clone https://github.com/maandree/sha3sum.git && \
    cd sha3sum && \
    make keccak-256sum

RUN addgroup -S app && adduser -S -G app app
USER app
WORKDIR /home/app

RUN cp /build/sha3sum/keccak-256sum .

COPY . .

ENTRYPOINT ["/home/app/entrypoint.sh"]
