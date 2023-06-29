# Get latest patch versions:
#   VERSIONS=$( curl https://releases.hashicorp.com/terraform/ | grep '/terraform/' | cut -d '/' -f3 | grep -v '\-' )
#   VERSIONS_MAJOR_MINOR=$( echo "$VERSIONS" | cut -d '.' -f1,2 | uniq | sed 's/$/./' )     # E.g. 1.5.
#   VERSIONS_MAJOR_MINOR_REGEX=$( echo "$VERSIONS_MAJOR_MINOR" | sed 's/\./\\./g' )         # E.g. 1\.5\.
#   for i in $VERSIONS_MAJOR_MINOR_REGEX; do echo "$VERSIONS" | grep -E "$i" | head -n1; done   # E.g. 1.5.2
$local:PACKAGE_VERSIONS = @(
    '1.5.2'
    '1.4.6'
    '1.3.9'
    '1.2.9'
    '1.1.9'
    '1.0.11'
    '0.15.5'
    '0.14.11'
    '0.13.7'
    '0.12.31'
    '0.11.15'
    '0.10.8'
    '0.9.11'
    '0.8.8'
    # '0.7.13'
    # '0.6.16'
    # '0.5.3'
    # '0.4.2'
    # '0.3.7'
    # '0.2.2'
    # '0.1.1'
)
$local:VARIANTS_MATRIX = @(
    foreach ($v in $local:PACKAGE_VERSIONS) {
        @{
            package_version = $v
            subvariants = @(
                @{ components = @() }
                @{ components = @( 'jq', 'sops', 'ssh' ) }
                @{ components = @( 'jq', 'libvirt', 'sops', 'ssh' ) }
            )
        }
    }
)
$VARIANTS = @(
    foreach ($variant in $VARIANTS_MATRIX){
        foreach ($subVariant in $variant['subvariants']) {
            @{
                # Metadata object
                _metadata = @{
                    package = $variant['package']
                    package_version = $variant['package_version']
                    platforms = & {
                        $v = $variant['package_version'] -as [version]
                        if ($v.Major -eq 0 -and $v.Minor -le 10) {
                            'linux/386,linux/amd64'
                        }else {
                            'linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64'
                        }
                    }
                    components = $subVariant['components']
                }
                # Docker image tag. E.g. 'v1.5.2'
                tag = @(
                    "v$( $variant['package_version'] )"
                    $subVariant['components'] | ? { $_ }
                ) -join '-'
                tag_as_latest = if ($variant['package_version'] -eq $local:PACKAGE_VERSIONS[0] -and $subVariant['components'].Count -eq 0) { $true } else { $false }
            }
        }
    }
)

# Docker image variants' definitions (shared)
$VARIANTS_SHARED = @{
    buildContextFiles = @{
        templates = @{
            'Dockerfile' = @{
                common = $true
                includeHeader = $false
                includeFooter = $false
                passes = @(
                    @{
                        variables = @{}
                    }
                )
            }
        }
    }
}
