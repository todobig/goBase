#!/bin/bash

# Function to install Go
install_go() {
    # Remove any existing Go installation
    sudo rm -rf /usr/local/go

    # Extract the downloaded archive into /usr/local
    sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz

    # Add /usr/local/go/bin to the PATH environment variable
    if [[ ":$PATH:" != *":/usr/local/go/bin:"* ]]; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> "$HOME/.profile"
        source "$HOME/.profile"
    fi
}

# Function to verify Go installation
verify_go() {
    # Verify that Go is installed
    go_version=$(go version)
    if [[ $go_version == *"go version"* ]]; then
        echo "Go is installed. Version:"
        echo "$go_version"
    else
        echo "Go installation failed."
        exit 1
    fi
}

# Main function
main() {
    # Install Go
    install_go

    # Verify Go installation
    verify_go

    # Test program
    echo "Testing Go installation with a sample program..."
    cat <<EOF > hello.go
package main

import "fmt"

func main() {
    fmt.Println("Hello, Go!")
}
EOF
    go run hello.go
}

# Execute main function
main
