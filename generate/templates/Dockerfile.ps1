# Global cache for checksums
function global:Set-Checksums($k, $url) {
    $global:CHECKSUMS = if (Get-Variable -Scope Global -Name CHECKSUMS -ErrorAction SilentlyContinue) { $global:CHECKSUMS } else { @{} }
    $global:CHECKSUMS[$k] = if ($global:CHECKSUMS[$k]) { $global:CHECKSUMS[$k] } else {
        $r = Invoke-WebRequest $url
        $c = if ($r.headers['Content-Type'] -eq 'text/plain') { $r.Content } else { [System.Text.Encoding]::UTF8.GetString($r.Content) }
        $c -split "`n"
    }
}
function global:Get-ChecksumsFile ($k, $keyword) {
    $file = $global:CHECKSUMS[$k] | ? { $_ -match $keyword } | % { $_ -split "\s" } | Select-Object -Last 1 | % { $_.TrimStart('*') }
    if ($file) {
        $file
    }else {
        "No file among $k checksums matching regex: $keyword" | Write-Warning
    }
}
function global:Get-ChecksumsSha ($k, $keyword) {
    $sha = $global:CHECKSUMS[$k] | ? { $_ -match $keyword } | % { $_ -split "\s" } | Select-Object -First 1
    if ($sha) {
        $sha
    }else {
        "No sha among $k checksums matching regex: $keyword" | Write-Warning
    }
}

# Global functions
function global:Generate-DownloadBinary ($o) {
    Set-StrictMode -Version Latest

    Set-Checksums "$( $o['binary'] )-$( $o['version'] )" $o['checksumsUrl']

    $shellVariable = "$( $o['binary'].ToUpper() -replace '[^A-Za-z0-9_]', '_' )_VERSION"
@"
# Install $( $o['binary'] )
RUN set -eux; \
    $shellVariable=$( $o['version'] ); \
    case "`$( uname -m )" in \

"@

    $o['architectures'] = if ($o.Contains('architectures')) { $o['architectures'] } else { 'linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x' }
    foreach ($a in ($o['architectures'] -split ',') ) {
        $split = $a -split '/'
        $os = $split[0]
        $arch = $split[1]
        $archv = if ($split.Count -gt 2) { $split[2] } else { '' }
        switch ($a) {
            "$os/386" {
                $hardware = 'x86'
                $regex = "$os[-_](i?$arch|x86(_64)?)[-_]?$archv$( [regex]::Escape($o['archiveformat']) )$"
            }
            "$os/amd64" {
                $hardware = 'x86_64'
                $regex = "$os[-_]($arch|x86(_64)?)[-_]?$archv$( [regex]::Escape($o['archiveformat']) )$"
            }
            "$os/arm/v6" {
                $hardware = 'armhf'
                $regex = "$os[-_]($arch|arm)[-_]?($archv)?$( [regex]::Escape($o['archiveformat']) )$"
            }
            "$os/arm/v7" {
                $hardware = 'armv7l'
                $regex = "$os[-_]($arch|arm)[-_]?($archv)?$( [regex]::Escape($o['archiveformat']) )$"
            }
            "$os/arm64" {
                $hardware = 'aarch64'
                $regex = "$os[-_]($arch|aarch64)[-_]?$archv$( [regex]::Escape($o['archiveformat']) )$"
            }
            "$os/ppc64le" {
                $hardware = 'ppc64le'
                $regex = "$os[-_]$arch[-_]?$archv$( [regex]::Escape($o['archiveformat']) )$"
            }
            "$os/riscv64" {
                $hardware = 'riscv64'
                $regex = "$os[-_]$arch[-_]?$archv$( [regex]::Escape($o['archiveformat']) )$"
            }
            "$os/s390x" {
                $hardware = 's390x'
                $regex = "$os[-_]$arch[-_]?$archv$( [regex]::Escape($o['archiveformat']) )$"
            }
            default {
                throw "Unsupported architecture: $a"
            }
        }

        $file = Get-ChecksumsFile "$( $o['binary'] )-$( $o['version'] )" $regex
        if ($file) {
            $sha = Get-ChecksumsSha "$( $o['binary'] )-$( $o['version'] )" $regex
@"
        '$hardware') \
            URL=$( Split-Path $o['checksumsUrl'] -Parent )/$file; \
            SHA256=$sha; \
            ;; \

"@
        }
    }

@"
        *) \
            echo "Architecture not supported"; \
            exit 1; \
            ;; \
    esac; \

"@

@"
    FILE=$( $o['binary'] )$( $o['archiveformat'] ); \
    wget -q "`$URL" -O "`$FILE"; \
    echo "`$SHA256  `$FILE" | sha256sum -c -; \

"@


    if ($o['archiveformat'] -match '\.tar\.gz|\.tgz') {
        if ($o['archivefiles'].Count -gt 0) {
@"
    tar -xvf "`$FILE" --no-same-owner --no-same-permissions -- $( $o['archivefiles'] -join ' ' ); \
    rm -f "`$FILE"; \

"@
        }else {
@"
    tar -xvf "`$FILE" --no-same-owner --no-same-permissions; \
    rm -f "`$FILE"; \

"@
        }
    }elseif ($o['archiveformat'] -match '\.bz2') {
@"
    bzip2 -d "`$FILE"; \

"@
    }elseif ($o['archiveformat'] -match '\.gz') {
@"
    gzip -d "`$FILE"; \

"@
    }elseif ($o['archiveformat'] -match '\.zip') {
@"
    unzip "`$FILE" $( $o['binary'] ); \

"@
    }
    $destination = if ($o.Contains('destination')) { $o['destination'] } else { "/usr/local/bin/$( $o['binary'] )" }
    $destinationDir = Split-Path $destination -Parent
@"
    mkdir -pv $destinationDir; \
    mv -v $( $o['binary'] ) $destination; \
    chmod +x $destination; \
    $( $o['testCommand'] ); \

"@

    if ($o.Contains('archivefiles')) {
        if ($license = $o['archivefiles'] | ? { $_ -match 'LICENSE' }) {
@"
    mkdir -p /licenses; \
    mv -v $license /licenses/$license; \

"@
        }
    }

@"
    :


"@
}

@"
FROM alpine:3.17
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on `$BUILDPLATFORM, building for `$TARGETPLATFORM"

"@

Generate-DownloadBinary @{
    binary = 'terraform'
    version = $VARIANT['_metadata']['package_version']
    archiveformat = '.zip'
    checksumsUrl = "https://releases.hashicorp.com/terraform/$( $VARIANT['_metadata']['package_version'] )/terraform_$( $VARIANT['_metadata']['package_version'] )_SHA256SUMS"
    destination = '/usr/local/bin/terraform'
    testCommand = 'CHECKPOINT_DISABLE=1 terraform version'
}

@"
RUN apk add --no-cache ca-certificates


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
RUN set -eux; \
    apk add --no-cache curl; \
    curl -sSL https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^185348fd77fc160d5bdf3cd20ecbc796163504fd3df196d7cb29000773657b74 '; \
    sops --version; \
    apk del curl


"@
    }else {
@"
RUN set -eux; \
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^185348fd77fc160d5bdf3cd20ecbc796163504fd3df196d7cb29000773657b74 '; \
    sops --version


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
# Disable telemetry. See: https://developer.hashicorp.com/terraform/cli/commands#upgrade-and-security-bulletin-checks
ENV CHECKPOINT_DISABLE=1

CMD [ "terraform" ]

"@
