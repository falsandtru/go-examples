# Build
FROM golang:1.12.5 as build
WORKDIR $HOME/workspace/
COPY . .
RUN go build -tags netgo -ldflags="-s -w -extldflags \"-static\"" -o bin/main .

# Production
FROM alpine:3.9.4 as production
COPY --from=build workspace/bin /usr/local/bin
ENTRYPOINT ["main"]
