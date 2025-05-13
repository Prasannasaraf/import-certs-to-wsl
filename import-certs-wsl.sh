#!/bin/bash


# Paths to the temporary directory and final destination in WSL
WSL_TEMP_DIR="/mnt/c/Users/$USER/Documents/temp/wslcertificates"
WSL_CERT_DIR="/usr/local/share/ca-certificates"

echo "Change to the temporary directory $WSL_TEMP_DIR"
mkdir -p $WSL_TEMP_DIR
cd $WSL_TEMP_DIR

# Convert .cer files to .crt files and move to the final destination
for cert in *.cer; do
    filename=$(basename "$cert" .cer)
    echo $filename
    sudo openssl x509 -inform DER -in "$cert" -out "$filename.crt"
done

# Move the converted .crt files to the final destination and remove the .cer files
sudo mv *.crt $WSL_CERT_DIR/
sudo rm *.cer

# Update CA certificates in WSL
sudo update-ca-certificates

echo "All certificates copied to WSL, converted to .crt, and CA certificates updated."