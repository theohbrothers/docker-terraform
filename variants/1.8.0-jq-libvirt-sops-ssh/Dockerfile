FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.8.0; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.8.0/terraform_1.8.0_linux_386.zip"; \
            SHA256=858e2ca2d38ce3644607af68eb5184a91493feecf82346deb386fd6cfbfad785; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.8.0/terraform_1.8.0_linux_amd64.zip"; \
            SHA256=dcc4670379a22213e72faa6cb709b3391e7e54967e40288ecf591e2b83cfd39e; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.8.0/terraform_1.8.0_linux_arm.zip"; \
            SHA256=25ecd729af5cf2774625521833cfd17ad92cd418f2342732b08bbcd1107026ed; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.8.0/terraform_1.8.0_linux_arm.zip"; \
            SHA256=25ecd729af5cf2774625521833cfd17ad92cd418f2342732b08bbcd1107026ed; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.8.0/terraform_1.8.0_linux_arm64.zip"; \
            SHA256=47cbde7184ce260160ff0355065d454ffa5628a2259ba325736dbcf740351193; \
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
