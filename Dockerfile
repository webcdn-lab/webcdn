FROM alpine:3.20

ARG SING_BOX_VERSION=1.12.9
ARG SING_BOX_SHA256=519bc521e6b25f779b37738c5fca0fa3f68175b3d8e434fcacd8ea42da9e70ef

RUN apk add --no-cache ca-certificates curl tar \
 && curl -fsSL -o /tmp/sing-box.tar.gz \
      "https://github.com/SagerNet/sing-box/releases/download/v${SING_BOX_VERSION}/sing-box-${SING_BOX_VERSION}-linux-amd64.tar.gz" \
 && echo "${SING_BOX_SHA256}  /tmp/sing-box.tar.gz" | sha256sum -c - \
 && tar -xzf /tmp/sing-box.tar.gz -C /tmp \
 && install -m 0755 "/tmp/sing-box-${SING_BOX_VERSION}-linux-amd64/sing-box" /usr/local/bin/sing-box \
 && rm -rf /tmp/sing-box*

WORKDIR /app
COPY config.template.json /app/config.template.json
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Render sets PORT; sing-box binds it via entrypoint substitution.
ENTRYPOINT ["/app/entrypoint.sh"]
