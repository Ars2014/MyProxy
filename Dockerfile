FROM alpine:3.6

RUN adduser -D proxy

WORKDIR /home/proxy

COPY dist/myproxy_linux .

RUN chown -R proxy:proxy ./
USER proxy

EXPOSE 8000
ENTRYPOINT ["./myproxy_linux"]