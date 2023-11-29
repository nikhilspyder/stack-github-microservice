# syntax=docker/dockerfile:1
FROM golang:1.19-alpine
ENV PORT 8080
ENV HOSTDIR 0.0.0.0

EXPOSE 8080
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod tidy
COPY . ./

# Install the necessary dependencies
RUN go get cloud.google.com/go/secretmanager/apiv1
RUN go get cloud.google.com/go/secretmanager/apiv1/secretmanagerpb

RUN go build -o /main
CMD [ "/main" ]