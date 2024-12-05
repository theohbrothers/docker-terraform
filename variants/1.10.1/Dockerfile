FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.10.1; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.10.1/terraform_1.10.1_linux_386.zip"; \
            SHA256=2ac3b1648d7bc5054c81d2db5cc6c0922cf4474113702a76bccb2dd172be243d; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.10.1/terraform_1.10.1_linux_amd64.zip"; \
            SHA256=d49d4d08ed092a8dec335f1fe3e127d1a285f160557323dd5a84ddc0c8472e1a; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.10.1/terraform_1.10.1_linux_arm.zip"; \
            SHA256=be437778a3b9c59d5de1cbcc70873a40b07d5fc6ae52c09c9bc5adb93a9c1b84; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.10.1/terraform_1.10.1_linux_arm.zip"; \
            SHA256=be437778a3b9c59d5de1cbcc70873a40b07d5fc6ae52c09c9bc5adb93a9c1b84; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.10.1/terraform_1.10.1_linux_arm64.zip"; \
            SHA256=6375a763b7784e47b4314e939a8c15f357db718d932e82825d87392abb5d1e09; \
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
