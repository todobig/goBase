#!/bin/bash

# Define Go version
GO_VERSION="1.23.1"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print in green
print_success() {
    echo -e "${GREEN}$1${NC}"
}

# Function to print in red
print_error() {
    echo -e "${RED}$1${NC}"
}

# Function to print in yellow
print_warning() {
    echo -e "${YELLOW}$1${NC}"
}

# Function to print in blue
print_info() {
    echo -e "${BLUE}$1${NC}"
}

# Start installation
print_info "Starting Go $GO_VERSION installation..."

# Download the latest version of Go
print_info "Downloading Go $GO_VERSION..."
if wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"; then
    print_success "Go $GO_VERSION downloaded successfully."
else
    print_error "Failed to download Go $GO_VERSION."
    exit 1
fi

# Remove any previous Go installation
print_info "Removing previous Go installation..."
if sudo rm -rf /usr/local/go; then
    print_success "Previous Go installation removed."
else
    print_error "Failed to remove the previous Go installation."
    exit 1
fi

# Extract the downloaded archive into /usr/local
print_info "Extracting Go $GO_VERSION..."
if sudo tar -C /usr/local -xzf "go${GO_VERSION}.linux-amd64.tar.gz"; then
    print_success "Go $GO_VERSION extracted successfully."
else
    print_error "Failed to extract Go $GO_VERSION."
    exit 1
fi

# Add /usr/local/go/bin to the PATH environment variable if it's not already present
print_info "Updating PATH environment variable..."
if ! grep -qF "/usr/local/go/bin" "$HOME/.profile"; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> "$HOME/.profile"
    print_success "PATH updated in .profile."
else
    print_warning "PATH already contains Go binaries."
fi

# Immediately apply the PATH change for the current shell
print_info "Refreshing environment for the current shell..."
export PATH=$PATH:/usr/local/go/bin

# Apply .profile to ensure it's reflected in future shell sessions
if source "$HOME/.profile"; then
    print_success "Environment refreshed for future shell sessions."
else
    print_warning "Failed to source .profile, please check your .profile manually."
fi

# Remove the downloaded Go tarball
print_info "Cleaning up downloaded files..."
rm "go${GO_VERSION}.linux-amd64.tar.gz"
print_success "Cleanup complete."

# Verify the installation
print_info "Verifying Go installation..."
if go version; then
    print_success "Go $GO_VERSION installed successfully!"
else
    print_error "Go installation failed."
    exit 1
fi
