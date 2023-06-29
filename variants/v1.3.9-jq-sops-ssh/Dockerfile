FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.3.9; \
    case "$( uname -m )" in \
        'x86') \
            URL=https://releases.hashicorp.com/terraform/1.3.9/terraform_1.3.9_linux_386.zip; \
            SHA256=d321b0ef810a3f972b031176e329006644c8915b83ecfcf506099952c5fbaccc; \
            ;; \
        'x86_64') \
            URL=https://releases.hashicorp.com/terraform/1.3.9/terraform_1.3.9_linux_amd64.zip; \
            SHA256=53048fa573effdd8f2a59b726234c6f450491fe0ded6931e9f4c6e3df6eece56; \
            ;; \
        'armhf') \
            URL=https://releases.hashicorp.com/terraform/1.3.9/terraform_1.3.9_linux_arm.zip; \
            SHA256=58203da8e5468ab5c22d26d242bf64e305c038d99717199f6783a3686130b60e; \
            ;; \
        'armv7l') \
            URL=https://releases.hashicorp.com/terraform/1.3.9/terraform_1.3.9_linux_arm.zip; \
            SHA256=58203da8e5468ab5c22d26d242bf64e305c038d99717199f6783a3686130b60e; \
            ;; \
        'aarch64') \
            URL=https://releases.hashicorp.com/terraform/1.3.9/terraform_1.3.9_linux_arm64.zip; \
            SHA256=da571087268c5faf884912c4239c6b9c8e1ed8e8401ab1dcb45712df70f42f1b; \
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
