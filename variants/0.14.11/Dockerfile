FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=0.14.11; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/0.14.11/terraform_0.14.11_linux_386.zip"; \
            SHA256=27aa3d1aacaa1aa64ed743b44995b47e3eebe2ded14b221f4dee9f98dd8350ff; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/0.14.11/terraform_0.14.11_linux_amd64.zip"; \
            SHA256=171ef5a4691b6f86eab524feaf9a52d5221c875478bd63dd7e55fef3939f7fd4; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/0.14.11/terraform_0.14.11_linux_arm.zip"; \
            SHA256=4f9f628e58998f50d8c8bc96b4f8feb3bf13fc7ae54c47c234526ee48f7514d9; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/0.14.11/terraform_0.14.11_linux_arm.zip"; \
            SHA256=4f9f628e58998f50d8c8bc96b4f8feb3bf13fc7ae54c47c234526ee48f7514d9; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/0.14.11/terraform_0.14.11_linux_arm64.zip"; \
            SHA256=602813ce2afe1e874807a66fc2e28b7cb90d9381b76a5d7b7f0ec9aa768eb2bc; \
            ;; \
        *) \
            echo "Architecture not supported"; \
            exit 1; \
            ;; \
    esac; \
    FILE=terraform.zip; \
    wget -q "$URL" -O "$FILE"; \
    echo "$SHA256  $FILE" | sha256sum -c -; \
    unzip "$FILE" -d extract; \
    mkdir -pv /usr/local/bin; \
    BIN=$( find extract -type f -name "terraform" | head -n1 ); \
    mv -v "$BIN" /usr/local/bin/terraform; \
    chmod +x /usr/local/bin/terraform; \
    CHECKPOINT_DISABLE=1 terraform version; \
    rm -rf extract; \
    rm -f "$FILE"; \
    :

RUN apk add --no-cache ca-certificates

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
