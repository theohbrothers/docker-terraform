FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.14.1; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.14.1/terraform_1.14.1_linux_386.zip"; \
            SHA256=37c4faebb7c84813717df941a17309add99ae10beb1ea5b7ed28448de272928f; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.14.1/terraform_1.14.1_linux_amd64.zip"; \
            SHA256=9f53070ee626df9e157887c1d3f9af3d8107a1b654371cd99040629eed698b27; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.14.1/terraform_1.14.1_linux_arm.zip"; \
            SHA256=67873a5f35b7d55a57999b10a3ba83438dfd0003b76c81687248cd4105fa78d5; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.14.1/terraform_1.14.1_linux_arm.zip"; \
            SHA256=67873a5f35b7d55a57999b10a3ba83438dfd0003b76c81687248cd4105fa78d5; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.14.1/terraform_1.14.1_linux_arm64.zip"; \
            SHA256=b2bb6aada17e2954d6b6a6f1e615884cacfd94b3879d8b4644f80b1c5020ac75; \
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

CMD [ "terraform" ]
