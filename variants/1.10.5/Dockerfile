FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.10.5; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_386.zip"; \
            SHA256=b88293a2ee2ee2aa805fb216229ab06ecd3485cf783dd525379af0faa3ab0789; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_amd64.zip"; \
            SHA256=0566a24f5332098b15716ebc394be503f4094acba5ba529bf5eb0698ed5e2a90; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_arm.zip"; \
            SHA256=c446cbafed29342c9d7d71b8ce977cfc8be45352d9172dab50abac1da3cf0b89; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_arm.zip"; \
            SHA256=c446cbafed29342c9d7d71b8ce977cfc8be45352d9172dab50abac1da3cf0b89; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_arm64.zip"; \
            SHA256=0ca5d6977c7c46bfa4bbe030030b911e897cf0cb72bff5525fb76c10f1c3409a; \
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
