FROM node:22-alpine

RUN apk add --no-cache \
    bash \
    git \
    curl \
    jq \
    python3 \
    py3-pip \
    build-base \
    docker-cli \
    ripgrep \
    && apk del build-base \
    && rm -rf /var/cache/apk/* /tmp/* /var/tmp/* \
      && addgroup -S docker \
      && adduser -D -h /home/claude -s /bin/bash claude \
      && addgroup claude docker \
      && addgroup claude root \
    && npm install -g @anthropic-ai/claude-code \
    && npm cache clean --force

USER claude

CMD ["claude","--dangerously-skip-permissions"]