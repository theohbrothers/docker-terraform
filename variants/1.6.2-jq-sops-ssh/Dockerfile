FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.6.2; \
    case "$( uname -m )" in \
        'x86') \
            URL=https://releases.hashicorp.com/terraform/1.6.2/terraform_1.6.2_linux_386.zip; \
            SHA256=38d7e0bd50684c35e087e2de436d2e27a3f8f63f4df473a2ce08e81a1cab302a; \
            ;; \
        'x86_64') \
            URL=https://releases.hashicorp.com/terraform/1.6.2/terraform_1.6.2_linux_amd64.zip; \
            SHA256=107142241b12ff78b6eb9c419757d406a8714704f7928750a662ba19de055e98; \
            ;; \
        'armhf') \
            URL=https://releases.hashicorp.com/terraform/1.6.2/terraform_1.6.2_linux_arm.zip; \
            SHA256=b0a5f94cc36b71d0eced8f82ac6a6db7a0e8c9753bf392ab0ddc7cddcd18035f; \
            ;; \
        'armv7l') \
            URL=https://releases.hashicorp.com/terraform/1.6.2/terraform_1.6.2_linux_arm.zip; \
            SHA256=b0a5f94cc36b71d0eced8f82ac6a6db7a0e8c9753bf392ab0ddc7cddcd18035f; \
            ;; \
        'aarch64') \
            URL=https://releases.hashicorp.com/terraform/1.6.2/terraform_1.6.2_linux_arm64.zip; \
            SHA256=ac70f54865d1c0a945d3efa221074e32a3818c666a412148ee5f9f0b14fd330d; \
            ;; \
        *) \
            echo "Architecture not supported"; \
            exit 1; \
            ;; \
    esac; \
    FILE=terraform.zip; \
    wget -q "$URL" -O "$FILE"; \
    echo "$SHA256  $FILE" | sha256sum -c -; \
    unzip "$FILE" terraform; \
    mkdir -pv /usr/local/bin; \
    mv -v terraform /usr/local/bin/terraform; \
    chmod +x /usr/local/bin/terraform; \
    CHECKPOINT_DISABLE=1 terraform version; \
    :

RUN apk add --no-cache ca-certificates

RUN apk add --no-cache jq

RUN set -eux; \
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^185348fd77fc160d5bdf3cd20ecbc796163504fd3df196d7cb29000773657b74 '; \
    sops --version

RUN apk add --no-cache gnupg

RUN apk add --no-cache openssh-client sshpass

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
