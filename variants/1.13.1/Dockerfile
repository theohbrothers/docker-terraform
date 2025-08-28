FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.13.1; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.13.1/terraform_1.13.1_linux_386.zip"; \
            SHA256=c5b006ffea002ff5080e3038c670be472a76db2626dc36dd5aca72955103ef2d; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.13.1/terraform_1.13.1_linux_amd64.zip"; \
            SHA256=4449e2ddc0dee283f0909dd603eaf98edeebaa950f4635cea94f2caf0ffacc5a; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.13.1/terraform_1.13.1_linux_arm.zip"; \
            SHA256=dc983c8178c8cbe174a8265c0073092deb3704f767571a1a3254927284de982f; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.13.1/terraform_1.13.1_linux_arm.zip"; \
            SHA256=dc983c8178c8cbe174a8265c0073092deb3704f767571a1a3254927284de982f; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.13.1/terraform_1.13.1_linux_arm64.zip"; \
            SHA256=2bb0787c2da1ad94d6a495a848aad4e9b572adb02bfc7361afeee80f07fd90ac; \
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
