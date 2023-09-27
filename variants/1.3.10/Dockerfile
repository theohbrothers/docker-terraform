FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.3.10; \
    case "$( uname -m )" in \
        'x86') \
            URL=https://releases.hashicorp.com/terraform/1.3.10/terraform_1.3.10_linux_386.zip; \
            SHA256=b8a3db560c9b7369066c423f302d00bf0643b7a89748948b778476e3dad5dcd2; \
            ;; \
        'x86_64') \
            URL=https://releases.hashicorp.com/terraform/1.3.10/terraform_1.3.10_linux_amd64.zip; \
            SHA256=2e3931c3db6999cdd4c7e55227cb877c6946d1f52923d7d057036d2827311402; \
            ;; \
        'armhf') \
            URL=https://releases.hashicorp.com/terraform/1.3.10/terraform_1.3.10_linux_arm.zip; \
            SHA256=5b51a3a601af0c7b3e2bac88fb01e9127d47e241d8b16e52831c3a20e79e1c39; \
            ;; \
        'armv7l') \
            URL=https://releases.hashicorp.com/terraform/1.3.10/terraform_1.3.10_linux_arm.zip; \
            SHA256=5b51a3a601af0c7b3e2bac88fb01e9127d47e241d8b16e52831c3a20e79e1c39; \
            ;; \
        'aarch64') \
            URL=https://releases.hashicorp.com/terraform/1.3.10/terraform_1.3.10_linux_arm64.zip; \
            SHA256=26dbff9a7d5de4ae0b3972fd62ff4784af6d5887833a91a88a013255c9069117; \
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

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
