FROM golang:latest as build

WORKDIR /go/src/github.com/Ars2014/MyProxy

RUN go get -v github.com/armon/go-socks5

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a --installsuffix cgo -o app .

FROM alpine:3.6 as production

RUN adduser -D proxy

WORKDIR /home/proxy

COPY --from=build /go/src/github.com/Ars2014/MyProxy/app .

RUN chmod -R 777 ./
RUN chown -R proxy:proxy ./
USER proxy

EXPOSE 8000
ENTRYPOINT ["./app"]