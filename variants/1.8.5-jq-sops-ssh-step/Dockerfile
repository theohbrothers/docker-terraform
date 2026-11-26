FROM alpine:3.24
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# Disable terraform checkpoints. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.8.5; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.8.5/terraform_1.8.5_linux_386.zip"; \
            SHA256=3d3bda809de29295f7b208c12432eb147ea50186b0e1da9082c2db2a3708415b; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.8.5/terraform_1.8.5_linux_amd64.zip"; \
            SHA256=bb1ee3e8314da76658002e2e584f2d8854b6def50b7f124e27b957a42ddacfea; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.8.5/terraform_1.8.5_linux_arm.zip"; \
            SHA256=2cd8cf46c46041c5f46766ec5e96728905df60ef92fd32d9889033ef8c305f46; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.8.5/terraform_1.8.5_linux_arm.zip"; \
            SHA256=2cd8cf46c46041c5f46766ec5e96728905df60ef92fd32d9889033ef8c305f46; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.8.5/terraform_1.8.5_linux_arm64.zip"; \
            SHA256=17b3a243ea24003a58ab324c197da8609fccae136bcb8a424bf61ec475b3a203; \
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

RUN apk add --no-cache jq

# Install sops
RUN set -eux; \
    SOPS_VERSION=3.13.3; \
    case "$( uname -m )" in \
        'x86_64') \
            URL="https://github.com/getsops/sops/releases/download/v3.13.3/sops-v3.13.3.linux.amd64"; \
            SHA256=e5bec3346a873ae91d871550f3e698c1aad962aff462a080e40f25fde17fef6b; \
            ;; \
        'aarch64') \
            URL="https://github.com/getsops/sops/releases/download/v3.13.3/sops-v3.13.3.linux.arm64"; \
            SHA256=53b0abacd38ef1b12a66d6c100956691b9cefce018d91f81e73ddf7438b94d77; \
            ;; \
        *) \
            URL="https://github.com/getsops/sops/releases/download/v3.13.3/sops-v3.13.3.linux.amd64"; \
            SHA256=e5bec3346a873ae91d871550f3e698c1aad962aff462a080e40f25fde17fef6b; \
            ;; \
    esac; \
    FILE=sops; \
    wget -q "$URL" -O "$FILE"; \
    echo "$SHA256  $FILE" | sha256sum -c -; \
    BIN=sops; \
    mkdir -pv /usr/local/bin; \
    mv -v "$BIN" /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sops --version --disable-version-check; \
    :

# Install gnupg for sops
RUN apk add --no-cache gnupg

RUN apk add --no-cache openssh-client sshpass

# Install step
RUN set -eux; \
    STEP_VERSION=0.31.0; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://github.com/smallstep/cli/releases/download/v0.31.0/step_linux_386.tar.gz"; \
            SHA256=9fcee36baf78ba28322f6f1acb852bc25bf25e7aa469b4f2eb163a4683a32a4e; \
            ;; \
        'x86_64') \
            URL="https://github.com/smallstep/cli/releases/download/v0.31.0/step_linux_amd64.tar.gz"; \
            SHA256=2bc654b26ca467848edb764620d6f17febea9d7d3629368b76dd20ce40c6ef32; \
            ;; \
        'armhf') \
            URL="https://github.com/smallstep/cli/releases/download/v0.31.0/step_linux_armv6.tar.gz"; \
            SHA256=76796b127d441b2904eda7d353a43c290b630d3f7a929b92d8b14122a1d7e11e; \
            ;; \
        'armv7l') \
            URL="https://github.com/smallstep/cli/releases/download/v0.31.0/step_linux_armv7.tar.gz"; \
            SHA256=f8e50fa01d406ad385acf728ab82793a9bd852d3489138fc1f062e068724db18; \
            ;; \
        'aarch64') \
            URL="https://github.com/smallstep/cli/releases/download/v0.31.0/step_linux_arm64.tar.gz"; \
            SHA256=3252032aded050abe93a642681995d3e36c66eaf1979da1980bf71b5e8973516; \
            ;; \
        'ppc64le') \
            URL="https://github.com/smallstep/cli/releases/download/v0.31.0/step_linux_ppc64le.tar.gz"; \
            SHA256=d3b0075c3e7f914f27b4601f0d73604b7c4d8543326fd1475af646c9f0b95da4; \
            ;; \
        *) \
            echo "Architecture not supported"; \
            exit 1; \
            ;; \
    esac; \
    FILE=step.tar.gz; \
    wget -q "$URL" -O "$FILE"; \
    echo "$SHA256  $FILE" | sha256sum -c -; \
    mkdir -p extract; \
    tar -C extract -xvf "$FILE" --no-same-owner --no-same-permissions; \
    mkdir -pv /usr/local/bin; \
    BIN=$( find extract -type f -name "step" | head -n1 ); \
    mv -v "$BIN" /usr/local/bin/step; \
    chmod +x /usr/local/bin/step; \
    step version; \
    rm -rf extract; \
    rm -f "$FILE"; \
    :

CMD [ "terraform" ]
