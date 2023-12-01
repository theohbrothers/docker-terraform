FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"
# Install terraform
RUN set -eux; \
    TERRAFORM_VERSION=1.5.7; \
    case "$( uname -m )" in \
        'x86') \
            URL="https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_386.zip"; \
            SHA256=106e4a9a237aea70f9dd2d4f84f0bcf795aa05227bf4ba8790a623f1d7e94950; \
            ;; \
        'x86_64') \
            URL="https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip"; \
            SHA256=c0ed7bc32ee52ae255af9982c8c88a7a4c610485cf1d55feeb037eab75fa082c; \
            ;; \
        'armhf') \
            URL="https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_arm.zip"; \
            SHA256=fd77cd3ba76175ecf7554fdf5fb66548f5906cb4944bc7e180b4be0b2196f404; \
            ;; \
        'armv7l') \
            URL="https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_arm.zip"; \
            SHA256=fd77cd3ba76175ecf7554fdf5fb66548f5906cb4944bc7e180b4be0b2196f404; \
            ;; \
        'aarch64') \
            URL="https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_arm64.zip"; \
            SHA256=f4b4ad7c6b6088960a667e34495cae490fb072947a9ff266bf5929f5333565e4; \
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
