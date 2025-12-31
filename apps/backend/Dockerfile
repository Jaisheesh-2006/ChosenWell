FROM golang:1.21-alpine
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o curated-backend

EXPOSE 8081
CMD ["./curated-backend"]
