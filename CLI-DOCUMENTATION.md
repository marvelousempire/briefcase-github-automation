# 🌐 Briefcase Git - Universal CLI Documentation

## 🚀 **Overview**

Briefcase Git is a universal command-line tool that provides seamless GitHub automation from any directory. It integrates with the Briefcase GitHub Automation tool to provide automated branch management, commit summaries, and pull request creation.

## 📍 **Installation**

### **Option 1: Global Installation (Recommended)**
```bash
cd "/Volumes/SeverD-1/Shared/AppsHub/Briefcase-GitHub-Automation"
sudo ./install-global.sh
```

### **Option 2: Manual Installation**
```bash
# Copy the script to your PATH
cp briefcase-git /usr/local/bin/
chmod +x /usr/local/bin/briefcase-git
```

### **Option 3: User Installation**
```bash
# Install to user directory
cp briefcase-git ~/.local/bin/
chmod +x ~/.local/bin/briefcase-git
# Add ~/.local/bin to your PATH
```

## 🎯 **Commands**

### **Core Commands**

#### **`briefcase-git init`**
Initialize Briefcase Git automation in the current directory.

```bash
briefcase-git init
```

**What it does:**
- Initializes Git repository (if not already initialized)
- Creates `.briefcase-git` configuration file
- Sets up automated workflows

#### **`briefcase-git branch <name>`**
Create and switch to a new branch with automatic type detection.

```bash
briefcase-git branch feature/new-feature
briefcase-git branch bugfix/fix-login
briefcase-git branch hotfix/security-patch
briefcase-git branch release/v1.2.0
```

**Branch Types:**
- `feature/*` - New features
- `bugfix/*` - Bug fixes
- `hotfix/*` - Critical fixes
- `release/*` - Release preparation

#### **`briefcase-git commit <title>`**
Commit changes with automated summary generation.

```bash
briefcase-git commit "Add user authentication"
briefcase-git commit "Fix login bug"
briefcase-git commit "Update documentation"
```

**Generated Summary Includes:**
- ✅ Completed features
- 🔧 Technical fixes
- 📱 User experience improvements
- ✅ Build status

#### **`briefcase-git push`**
Push the current branch to GitHub.

```bash
briefcase-git push
```

#### **`briefcase-git pr`**
Create a pull request using GitHub CLI.

```bash
briefcase-git pr
```

#### **`briefcase-git flow`**
Execute complete automation flow (push + create PR).

```bash
briefcase-git flow
```

### **Utility Commands**

#### **`briefcase-git web`**
Open the web interface for the automation tool.

```bash
briefcase-git web
```

#### **`briefcase-git server`**
Start the automation server.

```bash
briefcase-git server
```

#### **`briefcase-git status`**
Check system status and requirements.

```bash
briefcase-git status
```

#### **`briefcase-git setup`**
Setup the automation tool.

```bash
briefcase-git setup
```

#### **`briefcase-git help`**
Show help information.

```bash
briefcase-git help
```

## 🎨 **Project Template**

### **Create New Project**
```bash
cd "/Volumes/SeverD-1/Shared/AppsHub/Briefcase-GitHub-Automation"
./briefcase-project-template.sh "My New Project"
```

### **Project Types**
1. **iOS App** - Swift/SwiftUI project structure
2. **Web App** - React/Vue/HTML project structure
3. **Node.js** - Backend/API project structure
4. **Python** - Script/App project structure
5. **General** - Any language project structure

### **Template Features**
- ✅ Automatic Git initialization
- ✅ Project structure creation
- ✅ Briefcase Git configuration
- ✅ README with automation instructions
- ✅ Initial commit with summary

## 🔧 **Configuration**

### **`.briefcase-git` File**
The configuration file is automatically created when you run `briefcase-git init`:

```ini
[project]
name = "your-project"
type = "feature"
base_branch = "main"

[github]
owner = "marvelousempire"
repo = "your-project"
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
```

## 🚀 **Workflow Examples**

### **Complete Development Flow**
```bash
# 1. Initialize project
briefcase-git init

# 2. Create feature branch
briefcase-git branch feature/user-authentication

# 3. Make changes to your code
# ... edit files ...

# 4. Commit with automated summary
briefcase-git commit "Add user authentication system"

# 5. Push and create PR
briefcase-git flow
```

### **Quick Bug Fix Flow**
```bash
# 1. Create bugfix branch
briefcase-git branch bugfix/fix-login-error

# 2. Fix the bug
# ... edit files ...

# 3. Commit fix
briefcase-git commit "Fix login error handling"

# 4. Push and create PR
briefcase-git flow
```

### **Release Preparation**
```bash
# 1. Create release branch
briefcase-git branch release/v1.2.0

# 2. Update version numbers
# ... edit files ...

# 3. Commit release
briefcase-git commit "Prepare release v1.2.0"

# 4. Push and create PR
briefcase-git flow
```

## 🔍 **System Requirements**

### **Required Tools**
- **Git** - Version control
- **GitHub CLI** - GitHub operations
- **Node.js** - Backend server
- **UV** - Python package manager
- **PNPM** - Node.js package manager

### **Check Requirements**
```bash
briefcase-git status
```

## 🌐 **Web Interface**

The web interface provides a graphical way to use all automation features:

### **Access Methods**
1. **Direct File:** Open `github-automation.html` in browser
2. **Server:** Run `briefcase-git server` then visit `http://localhost:3000`
3. **CLI:** Run `briefcase-git web`

### **Web Features**
- 🌿 Branch Management
- 📝 Commit Automation
- 🐙 GitHub Integration
- 🔧 System Check
- 📋 Schema Generation
- ⚡ Full Automation

## 🎯 **Best Practices**

### **Branch Naming**
- Use descriptive names: `feature/user-dashboard`
- Include type prefix: `bugfix/`, `hotfix/`, `release/`
- Use kebab-case: `feature/new-user-interface`

### **Commit Messages**
- Use clear, descriptive titles
- Let the tool generate detailed summaries
- Include context about what was changed

### **Workflow**
1. Always create a branch for new work
2. Use automated commit summaries
3. Push and create PRs for review
4. Use the web interface for complex operations

## 🚨 **Troubleshooting**

### **Command Not Found**
```bash
# Check if installed
which briefcase-git

# Reinstall if needed
sudo ./install-global.sh
```

### **Permission Denied**
```bash
# Make script executable
chmod +x briefcase-git

# Check PATH
echo $PATH
```

### **GitHub CLI Not Found**
```bash
# Install GitHub CLI
brew install gh

# Authenticate
gh auth login
```

### **Server Not Starting**
```bash
# Check Node.js
node --version

# Install dependencies
npm install

# Check port availability
lsof -i :3000
```

## 📱 **Integration**

### **With Existing Projects**
```bash
# Navigate to existing project
cd /path/to/your/project

# Initialize automation
briefcase-git init

# Start using automated workflows
briefcase-git branch feature/your-feature
```

### **With CI/CD**
The tool generates standard Git commits and PRs that work with any CI/CD system.

### **With GitHub Actions**
Use the generated PR descriptions and commit messages in your GitHub Actions workflows.

## 🎉 **Success!**

You now have a universal GitHub automation tool that works from any directory! Use `briefcase-git help` to see all available commands and start automating your GitHub workflows.

---

**🚀 Happy coding with Briefcase Git!**
