FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.10.4; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.10.4/terraform_1.10.4_linux_386.zip"; \
            SHA256=5921c37cef9ba29e350b1da70ba0095e05e1e82ad6c5bb45affe8aa0d4c21a4a; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.10.4/terraform_1.10.4_linux_amd64.zip"; \
            SHA256=64b7b60f35eb92e94a046b6c932ce53f632a9eb528e9d0097857f9f27420be3e; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.10.4/terraform_1.10.4_linux_arm.zip"; \
            SHA256=f9fe24acb04707194c82dfcf945509a5fa4ad31a0d95abec519a8aa5cffa1672; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.10.4/terraform_1.10.4_linux_arm.zip"; \
            SHA256=f9fe24acb04707194c82dfcf945509a5fa4ad31a0d95abec519a8aa5cffa1672; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.10.4/terraform_1.10.4_linux_arm64.zip"; \
            SHA256=3c554a8b9ba2b2b03cdfe2b7cfa9b3cc40e98af99e4a52e21e365b97af2b3669; \
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
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^53aec65e45f62a769ff24b7e5384f0c82d62668dd96ed56685f649da114b4dbb '; \
    sops --version

RUN apk add --no-cache gnupg

RUN apk add --no-cache openssh-client sshpass

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
