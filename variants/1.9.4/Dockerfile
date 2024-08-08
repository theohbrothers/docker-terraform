FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.9.4; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.9.4/terraform_1.9.4_linux_386.zip"; \
            SHA256=59b75d6711dd50384e897c69ab1008fdfb38c0d63592e2ce1e5dcfe62e62a622; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.9.4/terraform_1.9.4_linux_amd64.zip"; \
            SHA256=6e9b2cc741875ab906d800af3134b076489f049565e0a1dbdb6deacd91f5054c; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.9.4/terraform_1.9.4_linux_arm.zip"; \
            SHA256=9755b846b0a57076bed20d1a5fdbddd4f2f74d49ca6f0fc7980b4a7655c424ba; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.9.4/terraform_1.9.4_linux_arm.zip"; \
            SHA256=9755b846b0a57076bed20d1a5fdbddd4f2f74d49ca6f0fc7980b4a7655c424ba; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.9.4/terraform_1.9.4_linux_arm64.zip"; \
            SHA256=ada5a330c09456df091bd2449c80884e3e368b80978d5849c940129047f43d1a; \
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
