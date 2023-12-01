FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.6.5; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.6.5/terraform_1.6.5_linux_386.zip"; \
            SHA256=f82fc45597a574234cbaf2825ac26a02158191d5e581c425bdadde7294a2a120; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.6.5/terraform_1.6.5_linux_amd64.zip"; \
            SHA256=f6404dc264aff75fc1b776670c1abf732cfed3d4a1ce49b64bc5b5d116fe87d5; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.6.5/terraform_1.6.5_linux_arm.zip"; \
            SHA256=abc220cef21d0937878e42de5c3085bdd8b7ca2e135163bfeeac1881da148a4b; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.6.5/terraform_1.6.5_linux_arm.zip"; \
            SHA256=abc220cef21d0937878e42de5c3085bdd8b7ca2e135163bfeeac1881da148a4b; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.6.5/terraform_1.6.5_linux_arm64.zip"; \
            SHA256=bad7aed9df3609599793f8c1f2df3ea6a5b4bf663813023989b9ee35632b6754; \
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
