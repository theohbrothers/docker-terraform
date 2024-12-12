FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.10.2; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.10.2/terraform_1.10.2_linux_386.zip"; \
            SHA256=d86fe3406b27bf054dfdd59a4373933865777614547acbae11f619d82a650e9a; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.10.2/terraform_1.10.2_linux_amd64.zip"; \
            SHA256=c347b0223c12d315baf8c9cc69913d5dbeb4388e96abe17805be4da9b63b5cdd; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.10.2/terraform_1.10.2_linux_arm.zip"; \
            SHA256=95fe2b491d371302d724501d83f872819fc33935423c3177efb3fb0f08d0f0f2; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.10.2/terraform_1.10.2_linux_arm.zip"; \
            SHA256=95fe2b491d371302d724501d83f872819fc33935423c3177efb3fb0f08d0f0f2; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.10.2/terraform_1.10.2_linux_arm64.zip"; \
            SHA256=c170b97362ebf685c616be25f67e5fd7dc1014522595b0c55cd671bd3eb1d589; \
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
