FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.14.3; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.14.3/terraform_1.14.3_linux_386.zip"; \
            SHA256=ab250da58dd7e6040bb65cd3aecaac8d2e42984ccb819296fb1147690b181847; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.14.3/terraform_1.14.3_linux_amd64.zip"; \
            SHA256=178b2a602251bb68b94732aceca2cc1023d87597cb83dba92cab31b6689edb4d; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.14.3/terraform_1.14.3_linux_arm.zip"; \
            SHA256=649034c7594bae11cf367ce362c793f69e6433207c5e35c849e2a68f5b404016; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.14.3/terraform_1.14.3_linux_arm.zip"; \
            SHA256=649034c7594bae11cf367ce362c793f69e6433207c5e35c849e2a68f5b404016; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.14.3/terraform_1.14.3_linux_arm64.zip"; \
            SHA256=fb5b004070e5e438214a74ddca321c22246f799e5cbe1ee9df582528e953f8cc; \
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
