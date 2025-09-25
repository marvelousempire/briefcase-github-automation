#!/bin/bash

# GitHub Desktop Setup Script for Briefcase GitHub Automation
# This script prepares the repository for GitHub Desktop

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 GitHub Desktop Setup for Briefcase GitHub Automation${NC}"
echo -e "${BLUE}=====================================================${NC}"

# Repository details
REPO_NAME="briefcase-github-automation"
REPO_URL="https://github.com/marvelousempire/briefcase-github-automation"
LOCAL_PATH="/Volumes/SeverD-1/Shared/AppsHub/Briefcase-GitHub-Automation"

echo -e "${GREEN}📁 Repository Details:${NC}"
echo -e "  ${CYAN}Name:${NC} $REPO_NAME"
echo -e "  ${CYAN}URL:${NC} $REPO_URL"
echo -e "  ${CYAN}Local Path:${NC} $LOCAL_PATH"
echo ""

# Check if repository exists
if [ ! -d "$LOCAL_PATH" ]; then
    echo -e "${RED}❌ Local repository not found at: $LOCAL_PATH${NC}"
    exit 1
fi

cd "$LOCAL_PATH"

# Check if it's a git repository
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ Not a Git repository${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Local repository found${NC}"

# Check if remote is already set
if git remote get-url origin > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Remote origin already configured${NC}"
    CURRENT_URL=$(git remote get-url origin)
    echo -e "  ${CYAN}Current URL:${NC} $CURRENT_URL"
else
    echo -e "${YELLOW}📝 Setting up remote origin...${NC}"
    git remote add origin "$REPO_URL"
    echo -e "${GREEN}✅ Remote origin configured${NC}"
fi

# Check current branch
CURRENT_BRANCH=$(git branch --show-current)
echo -e "${GREEN}📝 Current branch:${NC} $CURRENT_BRANCH"

# Check if there are commits
COMMIT_COUNT=$(git rev-list --count HEAD)
echo -e "${GREEN}📝 Commits:${NC} $COMMIT_COUNT"

echo ""
echo -e "${BLUE}🎯 GitHub Desktop Setup Instructions:${NC}"
echo ""
echo -e "${YELLOW}1. Open GitHub Desktop${NC}"
echo -e "${YELLOW}2. Click 'Add' → 'Add Existing Repository'${NC}"
echo -e "${YELLOW}3. Browse to: ${CYAN}$LOCAL_PATH${NC}"
echo -e "${YELLOW}4. Click 'Add Repository'${NC}"
echo ""
echo -e "${GREEN}✅ Repository will be added to GitHub Desktop${NC}"
echo ""

# Create a GitHub Desktop specific README
cat > GITHUB-DESKTOP-SETUP.md << EOF
# 🖥️ GitHub Desktop Setup

## 📁 Repository Information

- **Name:** $REPO_NAME
- **URL:** $REPO_URL
- **Local Path:** $LOCAL_PATH
- **Branch:** $CURRENT_BRANCH
- **Commits:** $COMMIT_COUNT

## 🚀 Quick Setup

1. **Open GitHub Desktop**
2. **Click "Add" → "Add Existing Repository"**
3. **Browse to:** \`$LOCAL_PATH\`
4. **Click "Add Repository"**

## 🎯 What You'll See

- ✅ All commits with detailed messages
- ✅ Branch structure
- ✅ File history
- ✅ Ready for GitHub operations

## 🔧 Next Steps

After adding to GitHub Desktop:

1. **Push to GitHub:** Use GitHub Desktop to push all commits
2. **Create Branches:** Use GitHub Desktop for branch management
3. **Create PRs:** Use GitHub Desktop for pull requests
4. **Use CLI:** Use \`briefcase-git\` commands for automation

## 📱 Available Commands

\`\`\`bash
# From any directory
briefcase-git init
briefcase-git branch feature/new-feature
briefcase-git commit "Add new feature"
briefcase-git flow
\`\`\`

## 🌐 Web Interface

- **Direct:** Open \`github-automation.html\` in browser
- **Server:** Run \`briefcase-git server\` then visit \`http://localhost:3000\`

---

**🎉 Ready for GitHub Desktop!**
EOF

echo -e "${GREEN}✅ Created GitHub Desktop setup guide${NC}"
echo -e "${CYAN}📝 File: GITHUB-DESKTOP-SETUP.md${NC}"

echo ""
echo -e "${BLUE}🎉 Setup Complete!${NC}"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo -e "1. ${CYAN}Open GitHub Desktop${NC}"
echo -e "2. ${CYAN}Add repository from: $LOCAL_PATH${NC}"
echo -e "3. ${CYAN}Push all commits to GitHub${NC}"
echo -e "4. ${CYAN}Start using automated workflows!${NC}"
