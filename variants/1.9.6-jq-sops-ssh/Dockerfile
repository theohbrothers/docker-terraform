FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.9.6; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.9.6/terraform_1.9.6_linux_386.zip"; \
            SHA256=8f7f621ee87df157b50514d4183054ea3696cbaea5a7e2d8e21669112d9674ed; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.9.6/terraform_1.9.6_linux_amd64.zip"; \
            SHA256=f2c90fb1efb2ad411519d1d3ccbaee7489a60e3147f2206fdb824fb35fac9c1c; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.9.6/terraform_1.9.6_linux_arm.zip"; \
            SHA256=bd71d88f37e5a61bb5070d452da5c1c6fad702256b972e499dc8bae8c705131f; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.9.6/terraform_1.9.6_linux_arm.zip"; \
            SHA256=bd71d88f37e5a61bb5070d452da5c1c6fad702256b972e499dc8bae8c705131f; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.9.6/terraform_1.9.6_linux_arm64.zip"; \
            SHA256=625eda48078ab7df18e697909aa6092962ce303a48bf6cf853c6470bb90b99df; \
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
