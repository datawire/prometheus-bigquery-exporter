FROM golang:1.20 as builder

ADD go.mod go.sum /usr/src/prometheus-bigquery-exporter/
WORKDIR /usr/src/prometheus-bigquery-exporter
RUN go mod download

ADD . /usr/src/prometheus-bigquery-exporter/
ENV CGO_ENABLED 0
RUN go install .

FROM alpine:3.15
COPY --from=builder /go/bin/prometheus-bigquery-exporter /bin/prometheus-bigquery-exporter
EXPOSE 9348
ENTRYPOINT  [ "/bin/prometheus-bigquery-exporter" ]
