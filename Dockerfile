# build stage
FROM golang:1.22.5 AS build

WORKDIR /app

COPY go.mod .
# to download go packages if the app has it.
RUN go mod download

COPY . .

RUN go build -o main

# final stage 
FROM gcr.io/distroless/base

COPY --from=build /app/main .
COPY --from=build /app/static ./static

EXPOSE 8080

CMD [ "./main" ]

