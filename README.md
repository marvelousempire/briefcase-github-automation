# 🚀 Briefcase App - GitHub Automation

**Seamless GitHub operations with UV, PNPM, and GitHub CLI**

A single-file Vue.js application with Node.js backend that automates GitHub operations for the Briefcase App project.

## ✨ Features

- **🌿 Branch Management**: Create, push, and manage branches automatically
- **📝 Commit Automation**: Generate detailed commit messages with full summaries
- **🐙 GitHub Integration**: Create pull requests with comprehensive descriptions
- **🔧 System Check**: Verify UV, PNPM, GitHub CLI, and Git installation
- **📋 Schema Generation**: Export/import configuration schemas
- **⚡ Full Automation**: Execute complete GitHub workflow with one click
- **🎨 Avatar System**: Comprehensive multi-source avatar management (Memoji, Stickers, Emoji)
- **📱 Interface Documentation**: Complete UI/UX documentation for all features

## 🛠️ Prerequisites

- **Node.js** (v16+)
- **npm** or **yarn**
- **Git**
- **UV** (Python package manager)
- **PNPM** (Node.js package manager)
- **GitHub CLI** (gh)

## 🚀 Quick Start

### Option 1: Automated Setup
```bash
# Run the setup script
./setup.sh

# Start the server
./setup.sh start
```

### Option 2: Manual Setup
```bash
# Install dependencies
npm install

# Make scripts executable
chmod +x github-automation-server.js

# Start the server
node github-automation-server.js
```

### Option 3: Direct Browser Access
```bash
# Just open the HTML file in your browser
open github-automation.html
```

## 🌐 Usage

1. **Open your browser** to `http://localhost:3000`
2. **Check system requirements** - Verify all tools are installed
3. **Configure your branch** - Set branch name, type, and base
4. **Enter commit information** - Title, description, and features
5. **Set GitHub details** - Repository owner, name, and token
6. **Execute automation** - Click "Execute Full Flow" for complete automation

## 📋 API Endpoints

- `POST /api/system-check` - Check system requirements
- `POST /api/install-tools` - Install missing tools
- `POST /api/create-branch` - Create new branch
- `POST /api/push-branch` - Push branch with commits
- `POST /api/create-pr` - Create pull request
- `POST /api/execute-flow` - Execute full automation flow
- `POST /api/generate-schema` - Generate configuration schema

## 🎯 Example Usage

### CNContact Integration Branch
```json
{
  "branch": {
    "name": "feature/cncontact-integration",
    "type": "feature",
    "base": "main",
    "autoPR": true
  },
  "commit": {
    "title": "✅ CNContact Integration COMPLETE",
    "description": "🎯 OBJECTIVE: Fix CNContact integration to enable proper family messaging system\n\n✅ COMPLETED FEATURES:\n• Implemented proper Me card retrieval using contact enumeration\n• Fixed custom fields storage using note field with JSON data\n• Implemented loadBriefcaseDataFromContact function\n• Fixed updateContactBriefcaseStatus function\n• Added validateContactExists function\n• Fixed addFamilyMemberFromContact method\n• Created comprehensive NavigationCoordinator with all tab constants\n• Resolved all conditional binding and type annotation errors\n\n🔧 TECHNICAL FIXES:\n• Replaced non-existent CNContact.customFields with note field storage\n• Fixed CNContactStore().unifiedMeContact() API issues\n• Implemented JSON-based data persistence in contact notes\n• Added proper error handling for contact operations\n• Fixed all Swift compilation errors\n\n📱 USER EXPERIENCE:\n• Family members can now be added from device Contacts app\n• Briefcase data is stored securely in contact notes\n• Trust precedence system works with contact relationships\n• Me card setup guides users through proper configuration\n\n✅ BUILD STATUS: SUCCESSFUL - No compilation errors\n🚀 READY FOR: Document scanner implementation\n\nNEXT BRANCH: feature/document-scanner"
  },
  "github": {
    "owner": "marvelousempire",
    "repo": "briefcase-app",
    "reviewers": ""
  }
}
```

## 🔧 Configuration

### Environment Variables
- `PORT` - Server port (default: 3000)
- `GITHUB_TOKEN` - GitHub personal access token
- `REPO_OWNER` - GitHub repository owner
- `REPO_NAME` - GitHub repository name

### Customization
- Modify `github-automation.html` for UI changes
- Update `github-automation-server.js` for backend logic
- Customize `setup.sh` for installation process

## 📁 File Structure

```
briefcase-app/
├── github-automation.html          # Vue.js frontend
├── github-automation-server.js     # Node.js backend
├── package.json                    # Dependencies
├── setup.sh                        # Setup script
├── push-with-summary.sh            # Git push script
└── README.md                       # This file
```

## 🎨 Features

### Frontend (Vue.js)
- **Responsive Design**: Works on desktop and mobile
- **Real-time Status**: Live updates on operations
- **Schema Management**: Export/import configurations
- **System Monitoring**: Check tool availability
- **One-click Automation**: Execute full workflows

### Backend (Node.js)
- **REST API**: Clean API endpoints
- **Command Execution**: Safe system command execution
- **Error Handling**: Comprehensive error management
- **CORS Support**: Cross-origin requests
- **Static Serving**: Serve frontend files

## 🚨 Troubleshooting

### Common Issues

1. **GitHub CLI Authentication**
   ```bash
   gh auth login --web
   ```

2. **Missing Tools**
   ```bash
   ./setup.sh install-tools
   ```

3. **Permission Errors**
   ```bash
   chmod +x *.sh
   ```

4. **Port Already in Use**
   ```bash
   PORT=3001 node github-automation-server.js
   ```

## 🔒 Security

- **No sensitive data stored** - All operations are stateless
- **Local execution only** - Commands run on your machine
- **GitHub token required** - Secure API access
- **CORS enabled** - Controlled cross-origin access

## 📈 Future Enhancements

- [ ] **GitHub Actions Integration** - Automate CI/CD
- [ ] **Multiple Repository Support** - Manage multiple projects
- [ ] **Template System** - Predefined commit templates
- [ ] **Webhook Integration** - Real-time updates
- [ ] **Team Collaboration** - Multi-user support

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

MIT License - see LICENSE file for details

## 🎉 Success!

Your Briefcase App GitHub automation is ready! 

**Next steps:**
1. Run `./setup.sh start`
2. Open `http://localhost:3000`
3. Execute your first automation flow
4. Enjoy seamless GitHub operations! 🚀
