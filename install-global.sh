#!/bin/bash

# Briefcase Git - Global Installation Script
# Makes the briefcase-git command available system-wide

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
BRIEFCASE_TOOL_DIR="/Volumes/SeverD-1/Shared/AppsHub/Briefcase-GitHub-Automation"
INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="briefcase-git"

echo -e "${BLUE}🚀 Briefcase Git - Global Installation${NC}"
echo -e "${BLUE}=====================================${NC}"

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo -e "${YELLOW}⚠️  Running as root - this will install system-wide${NC}"
else
    echo -e "${YELLOW}⚠️  Not running as root - will install to user directory${NC}"
    INSTALL_DIR="$HOME/.local/bin"
fi

# Create install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Check if briefcase-git script exists
if [ ! -f "$BRIEFCASE_TOOL_DIR/$SCRIPT_NAME" ]; then
    echo -e "${RED}❌ briefcase-git script not found at: $BRIEFCASE_TOOL_DIR/$SCRIPT_NAME${NC}"
    exit 1
fi

# Create wrapper script
cat > "$INSTALL_DIR/$SCRIPT_NAME" << EOF
#!/bin/bash

# Briefcase Git Wrapper Script
# This script calls the main briefcase-git tool from AppsHub

BRIEFCASE_TOOL_DIR="$BRIEFCASE_TOOL_DIR"

# Check if tool directory exists
if [ ! -d "\$BRIEFCASE_TOOL_DIR" ]; then
    echo "❌ Briefcase automation tool not found at: \$BRIEFCASE_TOOL_DIR"
    echo "Please ensure the tool is installed correctly"
    exit 1
fi

# Execute the main script with all arguments
exec "\$BRIEFCASE_TOOL_DIR/$SCRIPT_NAME" "\$@"
EOF

# Make wrapper script executable
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Add to PATH if not already there
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
    echo -e "${YELLOW}📝 Adding $INSTALL_DIR to PATH...${NC}"
    
    # Add to shell profile
    if [ -f "$HOME/.zshrc" ]; then
        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$HOME/.zshrc"
        echo -e "${GREEN}✅ Added to ~/.zshrc${NC}"
    elif [ -f "$HOME/.bashrc" ]; then
        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$HOME/.bashrc"
        echo -e "${GREEN}✅ Added to ~/.bashrc${NC}"
    elif [ -f "$HOME/.bash_profile" ]; then
        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$HOME/.bash_profile"
        echo -e "${GREEN}✅ Added to ~/.bash_profile${NC}"
    else
        echo -e "${YELLOW}⚠️  Please add $INSTALL_DIR to your PATH manually${NC}"
    fi
fi

# Test installation
if command -v "$SCRIPT_NAME" > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Installation successful!${NC}"
    echo -e "${CYAN}📝 Command installed at: $INSTALL_DIR/$SCRIPT_NAME${NC}"
    echo ""
    echo -e "${GREEN}🎉 You can now use 'briefcase-git' from any directory!${NC}"
    echo ""
    echo -e "${YELLOW}Examples:${NC}"
    echo -e "  ${CYAN}briefcase-git help${NC}                    # Show help"
    echo -e "  ${CYAN}briefcase-git init${NC}                    # Initialize automation"
    echo -e "  ${CYAN}briefcase-git branch feature/new-feature${NC}  # Create branch"
    echo -e "  ${CYAN}briefcase-git commit \"Add new feature\"${NC}   # Commit changes"
    echo -e "  ${CYAN}briefcase-git flow${NC}                    # Complete automation"
    echo ""
    echo -e "${PURPLE}💡 Run 'briefcase-git help' for all available commands${NC}"
else
    echo -e "${RED}❌ Installation failed${NC}"
    echo -e "${YELLOW}Please check permissions and try again${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}🔧 Next Steps:${NC}"
echo -e "1. ${CYAN}Open a new terminal${NC} (to reload PATH)"
echo -e "2. ${CYAN}Navigate to any project directory${NC}"
echo -e "3. ${CYAN}Run 'briefcase-git init'${NC} to initialize automation"
echo -e "4. ${CYAN}Start using automated GitHub workflows!${NC}"
