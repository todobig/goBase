#!/bin/bash

# Color codes for colorful logging
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Step 1: Download
echo -e "${GREEN}Step 1: Download${NC}"
wget https://dl.google.com/go/go1.22.0.linux-amd64.tar.gz || { echo -e "${RED}Failed to download Go.${NC}"; exit 1; }

# Step 2: Extract & Install
echo -e "${GREEN}Step 2: Extract & Install${NC}"
sudo tar -C /usr/local -xvf go1.22.0.linux-amd64.tar.gz || { echo -e "${RED}Failed to extract and install Go.${NC}"; exit 1; }

# Step 3: Add Path to file (if installing for the first time)
echo -e "${GREEN}Step 3: Add Path to file${NC}"
echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.profile || { echo -e "${RED}Failed to add path to ~/.profile.${NC}"; exit 1; }
source $HOME/.profile || { echo -e "${RED}Failed to source ~/.profile.${NC}"; exit 1; }

# Step 4: Test
echo -e "${GREEN}Step 4: Test${NC}"
go version || { echo -e "${RED}Failed to verify Go installation.${NC}"; exit 1; }

echo -e "${GREEN}Installation completed successfully.${NC}"
