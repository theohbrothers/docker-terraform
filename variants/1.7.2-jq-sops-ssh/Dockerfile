FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.7.2; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.7.2/terraform_1.7.2_linux_386.zip"; \
            SHA256=edc795aeaad1ba6a1020f14a9a2d5b1a8b587bd9a098e3f33e5a38a8fdcc64be; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.7.2/terraform_1.7.2_linux_amd64.zip"; \
            SHA256=e3965584b2347edd294ca97068af573654716abbb2ce5230d309692dab659267; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.7.2/terraform_1.7.2_linux_arm.zip"; \
            SHA256=9fe80ff9f2637d44dad78a87cc6d97f80c205b43674384ec52ba7dcd7d1e7a44; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.7.2/terraform_1.7.2_linux_arm.zip"; \
            SHA256=9fe80ff9f2637d44dad78a87cc6d97f80c205b43674384ec52ba7dcd7d1e7a44; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.7.2/terraform_1.7.2_linux_arm64.zip"; \
            SHA256=1fe2b047ac8354aca92a8037b57d813f5e60b7b0ba02acbecb899d990663326e; \
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
