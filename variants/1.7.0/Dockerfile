FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.7.0; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.7.0/terraform_1.7.0_linux_386.zip"; \
            SHA256=8144e49a59c64755c159def15a51c424f0993e2cb16f87bcdcd4f434dc84d592; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.7.0/terraform_1.7.0_linux_amd64.zip"; \
            SHA256=2bac080244845ebd434baf5e8557bd06d53b3c8bc01b7e496b390a56cb40ac5c; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.7.0/terraform_1.7.0_linux_arm.zip"; \
            SHA256=ee7f75ed10e6f37e93d6ea23728d724def42082af909c7ab3886c19d0cfa9652; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.7.0/terraform_1.7.0_linux_arm.zip"; \
            SHA256=ee7f75ed10e6f37e93d6ea23728d724def42082af909c7ab3886c19d0cfa9652; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.7.0/terraform_1.7.0_linux_arm64.zip"; \
            SHA256=33094b8c677460e7c6496a89770ae702bb8d9c6613d4a8485897da006d1919b5; \
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
