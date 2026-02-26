FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.14.6; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.14.6/terraform_1.14.6_linux_386.zip"; \
            SHA256=58b00cfefd16451277b146b01aac77b4aa533bb75e2f054b7bbebbac5c7538bb; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.14.6/terraform_1.14.6_linux_amd64.zip"; \
            SHA256=364c6ee08b0cb8fcbb28a115aacb2aa48e88abc56c149170bd65c2f75d98ea8d; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.14.6/terraform_1.14.6_linux_arm.zip"; \
            SHA256=8c750fb16d2bb12a41449f0dadac6dea67535c66a05a6def13f28f97538e60c5; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.14.6/terraform_1.14.6_linux_arm.zip"; \
            SHA256=8c750fb16d2bb12a41449f0dadac6dea67535c66a05a6def13f28f97538e60c5; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.14.6/terraform_1.14.6_linux_arm64.zip"; \
            SHA256=190037f64695556ac75965c00da5d85b3663f38553d909e9a51c4490cba4b6c1; \
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
