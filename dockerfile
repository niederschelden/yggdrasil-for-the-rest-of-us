FROM alpine

RUN \
  apk add \
  --no-cache \
  --no-check-certificate \
  --allow-untrusted \
  --no-scripts \
  yggdrasil

RUN \
  apk add \
  --no-cache \
  bash \
  lynx \
  curl

# Entrypoint-Skript kopieren und ausführbar machen
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]