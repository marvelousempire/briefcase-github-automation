#!/bin/bash

# Briefcase App - GitHub Automation Setup Script
# Seamless setup with UV, PNPM, and GitHub CLI

echo "🚀 Briefcase App - GitHub Automation Setup"
echo "=========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install UV
install_uv() {
    echo -e "${YELLOW}Installing UV...${NC}"
    curl -LsSf https://astral.sh/uv/install.sh | sh
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ UV installed successfully${NC}"
    else
        echo -e "${RED}❌ UV installation failed${NC}"
        return 1
    fi
}

# Function to install PNPM
install_pnpm() {
    echo -e "${YELLOW}Installing PNPM...${NC}"
    npm install -g pnpm
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ PNPM installed successfully${NC}"
    else
        echo -e "${RED}❌ PNPM installation failed${NC}"
        return 1
    fi
}

# Function to install GitHub CLI
install_gh() {
    echo -e "${YELLOW}Installing GitHub CLI...${NC}"
    if command_exists brew; then
        brew install gh
    else
        echo -e "${RED}❌ Homebrew not found. Please install Homebrew first.${NC}"
        return 1
    fi
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ GitHub CLI installed successfully${NC}"
    else
        echo -e "${RED}❌ GitHub CLI installation failed${NC}"
        return 1
    fi
}

# Function to install Node.js dependencies
install_dependencies() {
    echo -e "${YELLOW}Installing Node.js dependencies...${NC}"
    npm install
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Dependencies installed successfully${NC}"
    else
        echo -e "${RED}❌ Dependencies installation failed${NC}"
        return 1
    fi
}

# Function to setup GitHub authentication
setup_github_auth() {
    echo -e "${YELLOW}Setting up GitHub authentication...${NC}"
    echo -e "${BLUE}Please follow the authentication process:${NC}"
    gh auth login --web
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ GitHub authentication successful${NC}"
    else
        echo -e "${RED}❌ GitHub authentication failed${NC}"
        return 1
    fi
}

# Function to make scripts executable
make_executable() {
    echo -e "${YELLOW}Making scripts executable...${NC}"
    chmod +x github-automation-server.js
    chmod +x push-with-summary.sh
    chmod +x setup.sh
    echo -e "${GREEN}✅ Scripts made executable${NC}"
}

# Function to start the server
start_server() {
    echo -e "${YELLOW}Starting GitHub automation server...${NC}"
    echo -e "${BLUE}Server will be available at: http://localhost:3000${NC}"
    echo -e "${BLUE}Press Ctrl+C to stop the server${NC}"
    echo ""
    node github-automation-server.js
}

# Main setup function
main() {
    echo -e "${BLUE}Checking system requirements...${NC}"
    
    # Check Node.js
    if ! command_exists node; then
        echo -e "${RED}❌ Node.js not found. Please install Node.js first.${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ Node.js found${NC}"
    
    # Check npm
    if ! command_exists npm; then
        echo -e "${RED}❌ npm not found. Please install npm first.${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ npm found${NC}"
    
    # Check Git
    if ! command_exists git; then
        echo -e "${RED}❌ Git not found. Please install Git first.${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ Git found${NC}"
    
    # Install missing tools
    if ! command_exists uv; then
        install_uv
    else
        echo -e "${GREEN}✅ UV already installed${NC}"
    fi
    
    if ! command_exists pnpm; then
        install_pnpm
    else
        echo -e "${GREEN}✅ PNPM already installed${NC}"
    fi
    
    if ! command_exists gh; then
        install_gh
    else
        echo -e "${GREEN}✅ GitHub CLI already installed${NC}"
    fi
    
    # Install dependencies
    install_dependencies
    
    # Make scripts executable
    make_executable
    
    # Setup GitHub authentication
    setup_github_auth
    
    echo ""
    echo -e "${GREEN}🎉 Setup completed successfully!${NC}"
    echo ""
    echo -e "${BLUE}Next steps:${NC}"
    echo -e "${BLUE}1. Run: ./setup.sh start${NC}"
    echo -e "${BLUE}2. Open: http://localhost:3000${NC}"
    echo -e "${BLUE}3. Use the web interface to manage your GitHub operations${NC}"
    echo ""
    
    # Ask if user wants to start the server
    read -p "Do you want to start the server now? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        start_server
    fi
}

# Handle command line arguments
case "$1" in
    "start")
        start_server
        ;;
    "check")
        echo -e "${BLUE}System Check:${NC}"
        echo -e "UV: $(command_exists uv && echo '✅ Installed' || echo '❌ Missing')"
        echo -e "PNPM: $(command_exists pnpm && echo '✅ Installed' || echo '❌ Missing')"
        echo -e "GitHub CLI: $(command_exists gh && echo '✅ Installed' || echo '❌ Missing')"
        echo -e "Git: $(command_exists git && echo '✅ Installed' || echo '❌ Missing')"
        echo -e "Node.js: $(command_exists node && echo '✅ Installed' || echo '❌ Missing')"
        ;;
    "install-tools")
        install_uv
        install_pnpm
        install_gh
        ;;
    *)
        main
        ;;
esac
