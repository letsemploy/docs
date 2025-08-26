FROM python:3-alpine as builder
RUN apk add git build-base
WORKDIR /app
COPY . .
RUN pip install -U pip wheel
RUN pip install -r requirements.txt
RUN mkdocs build

FROM registry.gitlab.com/ngine/docker-images/caddy:2
COPY --from=builder /app/site/ /usr/share/caddy/
