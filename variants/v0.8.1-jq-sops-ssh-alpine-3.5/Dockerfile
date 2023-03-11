FROM alpine:3.5
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache terraform=0.8.1-r0

RUN apk add --no-cache jq

# Fix generic certification validation errors in alpine 3.5: https://github.com/docker-library/official-images/issues/2773#issuecomment-350431934
RUN apk add --no-cache ca-certificates

# Fix wget not working in alpine:3.6 and below. https://github.com/gliderlabs/docker-alpine/issues/423
# RUN apk add --no-cache libressl

# Fix wget error 'wget: SSL/TLS certificate is not being validated!' in alpine:3.5, use curl instead: https://github.com/docker-library/official-images/issues/2773
RUN set -eux; \
    apk add --no-cache curl; \
    curl -sSL https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^185348fd77fc160d5bdf3cd20ecbc796163504fd3df196d7cb29000773657b74 '; \
    sops --version; \
    apk del curl

RUN apk add --no-cache gnupg

RUN apk add --no-cache openssh-client sshpass

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
