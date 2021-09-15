FROM alpine:3.5
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache terraform=0.8.1-r0

# Fix generic certification validation errors in alpine 3.5: https://github.com/docker-library/official-images/issues/2773#issuecomment-350431934
RUN apk add --no-cache ca-certificates

# Fix wget not working in alpine:3.6 and below. https://github.com/gliderlabs/docker-alpine/issues/423
# RUN apk add --no-cache libressl

# Fix wget error 'wget: SSL/TLS certificate is not being validated!' in alpine:3.5, use curl instead: https://github.com/docker-library/official-images/issues/2773
RUN apk add --no-cache curl \
    && curl -sL https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux > /usr/local/bin/sops && chmod +x /usr/local/bin/sops \
    && apk del curl

RUN apk add --no-cache gnupg

RUN apk add --no-cache openssh-client

CMD [ "terraform" ]
