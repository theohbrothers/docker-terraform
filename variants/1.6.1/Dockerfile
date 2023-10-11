FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.6.1; \
    case "$( uname -m )" in \
        'x86') \
            URL=https://releases.hashicorp.com/terraform/1.6.1/terraform_1.6.1_linux_386.zip; \
            SHA256=74388441ef44ed1040b32d7aedf0d67e5d3f2662bc4a44f66c5bd7bc30572d3b; \
            ;; \
        'x86_64') \
            URL=https://releases.hashicorp.com/terraform/1.6.1/terraform_1.6.1_linux_amd64.zip; \
            SHA256=d1a778850cc44d9348312c9527f471ea1b7a9213205bb5091ec698f3dc92e2a6; \
            ;; \
        'armhf') \
            URL=https://releases.hashicorp.com/terraform/1.6.1/terraform_1.6.1_linux_arm.zip; \
            SHA256=c21f46aedd581eac1fce2a779bce1fb58d38cf2c4be83ab3a54a216c638df0ee; \
            ;; \
        'armv7l') \
            URL=https://releases.hashicorp.com/terraform/1.6.1/terraform_1.6.1_linux_arm.zip; \
            SHA256=c21f46aedd581eac1fce2a779bce1fb58d38cf2c4be83ab3a54a216c638df0ee; \
            ;; \
        'aarch64') \
            URL=https://releases.hashicorp.com/terraform/1.6.1/terraform_1.6.1_linux_arm64.zip; \
            SHA256=ae328d5733657f35233fd228d9a14fccde3b1d19b99158eff1906888b3ca4935; \
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
