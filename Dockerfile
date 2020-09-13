FROM arm32v7/golang:alpine as build

WORKDIR /opt/app

COPY go.mod go.sum ./
RUN go mod download

COPY main.go .
RUN CGO_ENABLED=0 go build -a -o prometheus-am-executor .

FROM scratch

COPY --from=build /opt/app/prometheus-am-executor ./
ENTRYPOINT [ "./prometheus-am-executor" ]
