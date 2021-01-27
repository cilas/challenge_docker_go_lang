# Get image that is build our app
FROM golang:1.8.3 as builder

# select directory to work
WORKDIR /go/src/app

# copying our go file
COPY main.go .

# building our binary file
RUN go install
RUN ldd /go/bin/app | grep -q "not a dynamic executable"

# Getting scratch image to lean our container
FROM scratch

# copying our binary from builder to scratch container
COPY --from=builder /go/bin/app /app

# running app
CMD [ "/app" ]