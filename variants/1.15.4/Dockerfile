FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.15.4; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.15.4/terraform_1.15.4_linux_386.zip"; \
            SHA256=ec458b2b8baa914734beed2275760ea5e5acaf99cadb74c68cd3ecc72bdbcfa2; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.15.4/terraform_1.15.4_linux_amd64.zip"; \
            SHA256=a71695fa6db9344db02ff1adb69cce891c1b2b4dc31c08df0dd4a12101a33b26; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.15.4/terraform_1.15.4_linux_arm.zip"; \
            SHA256=4e8a52160bbc8db128e0b9cf9f3a4e64f7788f94e2803b14489085a13ece03fb; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.15.4/terraform_1.15.4_linux_arm.zip"; \
            SHA256=4e8a52160bbc8db128e0b9cf9f3a4e64f7788f94e2803b14489085a13ece03fb; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.15.4/terraform_1.15.4_linux_arm64.zip"; \
            SHA256=87da14c6700fee1bdaffedc943c4aca7bb078aad1f3eeccbdaae0484f90e1bec; \
            ;; \
        's390x') \
            URL="https://releases.hashicorp.com/terraform/1.15.4/terraform_1.15.4_linux_s390x.zip"; \
            SHA256=765e74a54ffc20580ea22e5825819459dbcec504326ccdb7de4781598c82216a; \
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
