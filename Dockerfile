FROM golang:alpine3.19 as builder

WORKDIR /app

COPY src .

RUN go build -o graphpg main.go

FROM alpine:3.19.1

ARG HOST

ENV HOST=$HOST
ENV TITLE="GraphQL Playground"
ENV PORT=3000
ENV THEME=dark

WORKDIR /app

COPY --from=builder /app/graphpg .
COPY --from=builder /app/static src/static
COPY --from=builder /app/index.tmpl src/index.tmpl

EXPOSE 3000

ENTRYPOINT  ["./graphpg"]
