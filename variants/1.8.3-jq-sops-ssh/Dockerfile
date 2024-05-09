FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.8.3; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.8.3/terraform_1.8.3_linux_386.zip"; \
            SHA256=c09db0acdf8b52eb4f328d469ff4f32d5d22c0dfa503a7568cb323def63d95cd; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.8.3/terraform_1.8.3_linux_amd64.zip"; \
            SHA256=4ff78474d0407ba6e8c3fb9ef798f2822326d121e045577f80e2a637ec33f553; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.8.3/terraform_1.8.3_linux_arm.zip"; \
            SHA256=26ff2b06d13272999d56c8ca57446d51d6fdba483e385f401ad26cebd44b196a; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.8.3/terraform_1.8.3_linux_arm.zip"; \
            SHA256=26ff2b06d13272999d56c8ca57446d51d6fdba483e385f401ad26cebd44b196a; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.8.3/terraform_1.8.3_linux_arm64.zip"; \
            SHA256=5fd3c4ee4cf23f79641f77006d29544b41fbcde5d22202566322266e6fca2607; \
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

RUN apk add --no-cache jq

RUN set -eux; \
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^185348fd77fc160d5bdf3cd20ecbc796163504fd3df196d7cb29000773657b74 '; \
    sops --version

RUN apk add --no-cache gnupg

RUN apk add --no-cache openssh-client sshpass

# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]
