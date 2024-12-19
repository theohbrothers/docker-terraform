FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.10.3; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.10.3/terraform_1.10.3_linux_386.zip"; \
            SHA256=f255e91b6d18ed7fdfffc32beff3877583ccce19d239685e9521e49c36b88f14; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.10.3/terraform_1.10.3_linux_amd64.zip"; \
            SHA256=ea3020db6b53c25a4a84e40cdc36c1a86df26967d718219ab4c71b44435da81e; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.10.3/terraform_1.10.3_linux_arm.zip"; \
            SHA256=829bf0965dbae58e88fc885159889908583220b5fff4ca8ff34326534a824dbd; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.10.3/terraform_1.10.3_linux_arm.zip"; \
            SHA256=829bf0965dbae58e88fc885159889908583220b5fff4ca8ff34326534a824dbd; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.10.3/terraform_1.10.3_linux_arm64.zip"; \
            SHA256=b92d8245c67d4f7193245bc9d534048a63520302b6edb3c7764277b00c96ed31; \
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

RUN apk add --no-cache libvirt-client

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
