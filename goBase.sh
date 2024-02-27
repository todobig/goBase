#!/bin/bash

# Colors for better visualization
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Remove any existing Go installations
printf "Removing any existing Go installation...\n"
sudo rm -rf /usr/local/go
sed -i '/\/usr\/local\/go\/bin/d' "$HOME/.profile" # Remove Go bin directory from PATH

# Download and extract Go
printf "Downloading and extracting Go...\n"
wget -q https://go.dev/dl/go1.22.0.linux-amd64.tar.gz -O /tmp/go.tar.gz
sudo tar -C /usr/local -xzf /tmp/go.tar.gz

# Add /usr/local/go/bin to the PATH environment variable
if [[ ":$PATH:" != *":/usr/local/go/bin:"* ]]; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> "$HOME/.profile"
    source "$HOME/.profile"
fi

# Verify Go installation
go_version=$(go version)
if [[ $go_version == *"go version"* ]]; then
    printf "${GREEN}Go is installed. Version:${NC}\n"
    echo "$go_version"
else
    printf "${RED}Go installation failed.${NC}\n"
    exit 1
fi

# Test program
printf "Testing Go installation with a sample program...\n"
cat <<EOF > hello.go
package main

import "fmt"

func main() {
    fmt.Println("Hello, Go!")
}
EOF
go run hello.go
