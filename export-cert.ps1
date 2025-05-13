# Paths to save the exported certificates
$exportDir = "$env:USERPROFILE\Documents\temp\wslcertificates"

# Function to export all certificates from a given store
function Export-AllCertsFromStore {
    param (
        [string]$storeLocation,
        [string]$storeName
    )

    # Create export directory if it does not exist
    if (-not (Test-Path -Path $exportDir)) {
        New-Item -ItemType Directory -Path $exportDir
    }

    $certStore = New-Object System.Security.Cryptography.X509Certificates.X509Store($storeName, $storeLocation)
    $certStore.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadOnly)
    $certs = $certStore.Certificates

    foreach ($cert in $certs) {
        $certPath = "$exportDir\$($cert.Thumbprint).cer"
        $cert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert) | Set-Content -Path $certPath -Encoding Byte
        Write-Output "Certificate exported to $certPath"
    }

    $certStore.Close()
}

# Export certificates from the Trusted Root Certification Authorities store
Export-AllCertsFromStore -storeLocation "LocalMachine" -storeName "Root"

