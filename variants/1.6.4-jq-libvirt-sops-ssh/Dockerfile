FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.6.4; \
    case "$( uname -m )" in \
        'x86') \
            URL=https://releases.hashicorp.com/terraform/1.6.4/terraform_1.6.4_linux_386.zip; \
            SHA256=9204af46f2a0e12bccc0cdaa2077bf4bbce5090033b97c1978c92b9e88eb9f86; \
            ;; \
        'x86_64') \
            URL=https://releases.hashicorp.com/terraform/1.6.4/terraform_1.6.4_linux_amd64.zip; \
            SHA256=569fc3d526dcf57eb5af4764843b87b36a7cb590fc50f94a07757c1189256775; \
            ;; \
        'armhf') \
            URL=https://releases.hashicorp.com/terraform/1.6.4/terraform_1.6.4_linux_arm.zip; \
            SHA256=98a9dbe23cdee6b9a89f2c474eb2e1077f64e4e1e74e4356bc7539cc7d31985c; \
            ;; \
        'armv7l') \
            URL=https://releases.hashicorp.com/terraform/1.6.4/terraform_1.6.4_linux_arm.zip; \
            SHA256=98a9dbe23cdee6b9a89f2c474eb2e1077f64e4e1e74e4356bc7539cc7d31985c; \
            ;; \
        'aarch64') \
            URL=https://releases.hashicorp.com/terraform/1.6.4/terraform_1.6.4_linux_arm64.zip; \
            SHA256=823606826b03c333689152c539892edb6ea81c085e4b3b7482ba7aa4b216b762; \
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
