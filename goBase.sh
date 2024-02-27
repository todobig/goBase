#!/bin/bash

# Download the latest version of Go
wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz

# Remove any previous Go installation
sudo rm -rf /usr/local/go

# Extract the downloaded archive into /usr/local
sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz

# Add /usr/local/go/bin to the PATH environment variable
if ! grep -qF "/usr/local/go/bin" "$HOME/.profile"; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> "$HOME/.profile"
fi

# Apply changes to the current shell
source "$HOME/.profile"

# Verify the installation
go version
