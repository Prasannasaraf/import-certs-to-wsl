mkdir -p /mnt/c/Users/$USER/Documents/temp/wslcertificates

# Execute Powershell: Export certificates
powershell.exe ./export-cert.ps1 

# Bash Script: Import Certificates
./import-certs-wsl.sh
