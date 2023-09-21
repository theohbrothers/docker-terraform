# Get latest patch versions:
#   VERSIONS=$( curl https://releases.hashicorp.com/terraform/ | grep '/terraform/' | cut -d '/' -f3 | grep -v '\-' )
#   VERSIONS_MAJOR_MINOR=$( echo "$VERSIONS" | cut -d '.' -f1,2 | uniq | sed 's/$/./' )     # E.g. 1.5.
#   VERSIONS_MAJOR_MINOR_REGEX=$( echo "$VERSIONS_MAJOR_MINOR" | sed 's/\./\\./g' )         # E.g. 1\.5\.
#   for i in $VERSIONS_MAJOR_MINOR_REGEX; do echo "$VERSIONS" | grep -E "$i" | head -n1; done   # E.g. 1.5.2
$local:VERSIONS = @( Get-Content $PSScriptRoot/versions.json -Encoding utf8 -raw | ConvertFrom-Json )

$local:VARIANTS_MATRIX = @(
    foreach ($v in $local:VERSIONS.terraform.versions) {
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
                tag_as_latest = if ($variant['package_version'] -eq $local:VARIANTS_MATRIX[0]['package_version'] -and $subVariant['components'].Count -eq 0) { $true } else { $false }
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
