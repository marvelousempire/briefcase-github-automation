#!/bin/bash

# Briefcase Project Template - Universal Project Setup
# Creates a new project with Briefcase Git automation ready to go

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

echo -e "${BLUE}🚀 Briefcase Project Template${NC}"
echo -e "${BLUE}============================${NC}"

# Get project name
if [ -z "$1" ]; then
    read -p "Enter project name: " PROJECT_NAME
else
    PROJECT_NAME="$1"
fi

if [ -z "$PROJECT_NAME" ]; then
    echo -e "${RED}❌ Project name is required${NC}"
    exit 1
fi

# Get project type
echo -e "${YELLOW}Select project type:${NC}"
echo -e "1. ${CYAN}iOS App${NC} (Swift/SwiftUI)"
echo -e "2. ${CYAN}Web App${NC} (React/Vue/HTML)"
echo -e "3. ${CYAN}Node.js${NC} (Backend/API)"
echo -e "4. ${CYAN}Python${NC} (Script/App)"
echo -e "5. ${CYAN}General${NC} (Any language)"
echo ""
read -p "Choose (1-5): " PROJECT_TYPE

case $PROJECT_TYPE in
    1) PROJECT_TYPE_NAME="iOS App"; PROJECT_TYPE_CODE="ios";;
    2) PROJECT_TYPE_NAME="Web App"; PROJECT_TYPE_CODE="web";;
    3) PROJECT_TYPE_NAME="Node.js"; PROJECT_TYPE_CODE="nodejs";;
    4) PROJECT_TYPE_NAME="Python"; PROJECT_TYPE_CODE="python";;
    5) PROJECT_TYPE_NAME="General"; PROJECT_TYPE_CODE="general";;
    *) PROJECT_TYPE_NAME="General"; PROJECT_TYPE_CODE="general";;
esac

# Get project directory
if [ -z "$2" ]; then
    read -p "Enter project directory (default: current): " PROJECT_DIR
else
    PROJECT_DIR="$2"
fi

if [ -z "$PROJECT_DIR" ]; then
    PROJECT_DIR="."
fi

# Create project directory if it doesn't exist
if [ ! -d "$PROJECT_DIR" ]; then
    mkdir -p "$PROJECT_DIR"
fi

cd "$PROJECT_DIR"

echo -e "${BLUE}📁 Creating project: $PROJECT_NAME${NC}"
echo -e "${CYAN}📝 Type: $PROJECT_TYPE_NAME${NC}"
echo -e "${CYAN}📁 Location: $(pwd)${NC}"

# Initialize Git repository
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}📁 Initializing Git repository...${NC}"
    git init
fi

# Create project structure based on type
case $PROJECT_TYPE_CODE in
    "ios")
        echo -e "${YELLOW}📱 Creating iOS project structure...${NC}"
        mkdir -p "Sources" "Resources" "Tests" "Documentation"
        touch "README.md" "LICENSE" "Sources/main.swift" "Tests/mainTests.swift"
        ;;
    "web")
        echo -e "${YELLOW}🌐 Creating web project structure...${NC}"
        mkdir -p "src" "public" "assets" "docs"
        touch "README.md" "LICENSE" "index.html" "package.json" "src/main.js"
        ;;
    "nodejs")
        echo -e "${YELLOW}🟢 Creating Node.js project structure...${NC}"
        mkdir -p "src" "tests" "docs" "config"
        touch "README.md" "LICENSE" "package.json" "src/index.js" "tests/index.test.js"
        ;;
    "python")
        echo -e "${YELLOW}🐍 Creating Python project structure...${NC}"
        mkdir -p "src" "tests" "docs" "requirements"
        touch "README.md" "LICENSE" "requirements.txt" "src/main.py" "tests/test_main.py"
        ;;
    "general")
        echo -e "${YELLOW}📁 Creating general project structure...${NC}"
        mkdir -p "src" "docs" "tests"
        touch "README.md" "LICENSE" "src/main" "tests/test"
        ;;
esac

# Create Briefcase Git configuration
cat > .briefcase-git << EOF
# Briefcase Git Configuration
# Generated: $(date)

[project]
name = "$PROJECT_NAME"
type = "$PROJECT_TYPE_CODE"
base_branch = "main"

[github]
owner = "marvelousempire"
repo = "$PROJECT_NAME"
auto_pr = true

[commit]
template = "briefcase"
include_summary = true
include_features = true
include_technical_fixes = true

[automation]
auto_branch_prefix = "feature"
auto_commit_template = "briefcase"
auto_pr_template = "briefcase"
EOF

# Create project README
cat > README.md << EOF
# $PROJECT_NAME

**Project Type:** $PROJECT_TYPE_NAME  
**Created:** $(date)  
**Briefcase Git:** ✅ Configured

## 🚀 Quick Start

This project is configured with Briefcase Git automation for seamless GitHub operations.

### Available Commands

\`\`\`bash
# Initialize automation (already done)
briefcase-git init

# Create a new feature branch
briefcase-git branch feature/new-feature

# Commit changes with automated summary
briefcase-git commit "Add new feature"

# Push branch and create PR
briefcase-git flow

# Open web interface
briefcase-git web

# Check system status
briefcase-git status
\`\`\`

## 📁 Project Structure

\`\`\`
$PROJECT_NAME/
├── .briefcase-git          # Briefcase Git configuration
├── README.md               # This file
├── LICENSE                 # Project license
└── [project files]         # Your project files
\`\`\`

## 🔧 Development

1. **Create a branch:** \`briefcase-git branch feature/your-feature\`
2. **Make changes:** Edit your files
3. **Commit changes:** \`briefcase-git commit "Your commit message"\`
4. **Push and create PR:** \`briefcase-git flow\`

## 📱 Briefcase Git Features

- ✅ **Automated Branch Management**
- ✅ **Smart Commit Summaries**
- ✅ **GitHub Integration**
- ✅ **Pull Request Automation**
- ✅ **System Status Checking**
- ✅ **Web Interface**

## 🤝 Contributing

This project uses Briefcase Git for automated GitHub workflows. All contributions should follow the automated flow:

1. Create feature branch
2. Make changes
3. Commit with automated summary
4. Push and create PR

## 📄 License

See LICENSE file for details.

---

**🎉 Happy coding with Briefcase Git!**
EOF

# Create initial commit
echo -e "${YELLOW}📝 Creating initial commit...${NC}"
git add .
git commit -m "🚀 Initial commit: $PROJECT_NAME

✅ PROJECT SETUP:
• Project type: $PROJECT_TYPE_NAME
• Briefcase Git automation configured
• Project structure created
• Documentation initialized

🔧 TECHNICAL SETUP:
• Git repository initialized
• Briefcase Git configuration created
• Project structure established
• README documentation added

📱 READY FOR DEVELOPMENT:
• Automated GitHub workflows enabled
• Branch management configured
• Commit automation ready
• Pull request automation active

✅ BUILD STATUS: SUCCESSFUL - Project initialized
🚀 READY FOR: Development and automated GitHub operations"

echo -e "${GREEN}✅ Project '$PROJECT_NAME' created successfully!${NC}"
echo ""
echo -e "${BLUE}🎯 Next Steps:${NC}"
echo -e "1. ${CYAN}cd $(pwd)${NC}"
echo -e "2. ${CYAN}briefcase-git branch feature/initial-setup${NC}"
echo -e "3. ${CYAN}Start developing your project${NC}"
echo -e "4. ${CYAN}Use 'briefcase-git flow' for automated GitHub operations${NC}"
echo ""
echo -e "${PURPLE}💡 Run 'briefcase-git help' for all available commands${NC}"
echo -e "${PURPLE}🌐 Run 'briefcase-git web' to open the web interface${NC}"
