FROM kong/kong-gateway:latest

COPY kong.yaml /tmp/kong.yaml.template

ENV KONG_DATABASE=off
ENV KONG_DECLARATIVE_CONFIG=/tmp/kong.yaml
ENV KONG_LOG_LEVEL=warn
ENV KONG_PROXY_LISTEN=0.0.0.0:8000
ENV KONG_PROXY_ACCESS_LOG=/dev/stdout
ENV KONG_ADMIN_ACCESS_LOG=/dev/stdout
ENV KONG_PROXY_ERROR_LOG=/dev/stderr
ENV KONG_ADMIN_ERROR_LOG=/dev/stderr
ENV KONG_NGINX_DAEMON=off

CMD ["sh", "-c", "sed 's|{vault://env/JWT_SECRET}|'\"$JWT_SECRET\"'|g' /tmp/kong.yaml.template > /tmp/kong.yaml && kong start"]
