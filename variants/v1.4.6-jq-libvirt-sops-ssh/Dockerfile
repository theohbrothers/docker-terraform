FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.4.6; \
    case "$( uname -m )" in \
        'x86') \
            URL=https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_386.zip; \
            SHA256=f802ead8d46b90e5b5ec2ef5aaf5a0438bd9a7621fcc80f192b3a93ba25d679c; \
            ;; \
        'x86_64') \
            URL=https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip; \
            SHA256=e079db1a8945e39b1f8ba4e513946b3ab9f32bd5a2bdf19b9b186d22c5a3d53b; \
            ;; \
        'armhf') \
            URL=https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_arm.zip; \
            SHA256=e03fa047d5cd093929c89e261ee0852968c92097e3d575f7b56b1cb3720c82fd; \
            ;; \
        'armv7l') \
            URL=https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_arm.zip; \
            SHA256=e03fa047d5cd093929c89e261ee0852968c92097e3d575f7b56b1cb3720c82fd; \
            ;; \
        'aarch64') \
            URL=https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_arm64.zip; \
            SHA256=b38f5db944ac4942f11ceea465a91e365b0636febd9998c110fbbe95d61c3b26; \
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

RUN apk add --no-cache libvirt-client

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
