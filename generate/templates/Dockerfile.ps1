@"
FROM $( $VARIANT['_metadata']['distro'] ):$( $VARIANT['_metadata']['distro_version'] )
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on `$BUILDPLATFORM, building for `$TARGETPLATFORM"

RUN apk add --no-cache $( $VARIANT['_metadata']['package'] )=$( $VARIANT['_metadata']['package_version'] )


"@

if ( $VARIANT['_metadata']['components'] -contains 'jq' ) {
    @"
RUN apk add --no-cache jq


"@
}

if ( $VARIANT['_metadata']['components'] -contains 'libvirt' ) {
    @"
RUN apk add --no-cache libvirt-client


"@
}

if ( $VARIANT['_metadata']['components'] -contains 'sops' ) {
    if ( $VARIANT['_metadata']['distro'] -eq 'alpine' -and $VARIANT['_metadata']['distro_version'] -in @('3.6', '3.5', '3.4', '3.3') ) {
        @"
# Fix generic certification validation errors in alpine 3.5: https://github.com/docker-library/official-images/issues/2773#issuecomment-350431934
RUN apk add --no-cache ca-certificates

# Fix wget not working in alpine:3.6 and below. https://github.com/gliderlabs/docker-alpine/issues/423
# RUN apk add --no-cache libressl

# Fix wget error 'wget: SSL/TLS certificate is not being validated!' in alpine:3.5, use curl instead: https://github.com/docker-library/official-images/issues/2773
RUN apk add --no-cache curl \
    && curl -sL https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux > /usr/local/bin/sops && chmod +x /usr/local/bin/sops \
    && apk del curl


"@
    }else {
        @"
RUN wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux > /usr/local/bin/sops && chmod +x /usr/local/bin/sops


"@
    }
@"
RUN apk add --no-cache gnupg


"@
}

if ( $VARIANT['_metadata']['components'] -contains 'ssh' ) {
    @"
RUN apk add --no-cache openssh-client sshpass


"@
}

@"
CMD [ "terraform" ]

"@
