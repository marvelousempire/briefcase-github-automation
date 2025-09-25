#!/usr/bin/env node

/**
 * Briefcase App - GitHub Automation Backend
 * Seamless GitHub operations with UV, PNPM, and GitHub CLI
 */

const express = require('express');
const { exec } = require('child_process');
const cors = require('cors');
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static('.'));

// Utility function to execute commands
const execCommand = (command, cwd = process.cwd()) => {
    return new Promise((resolve, reject) => {
        exec(command, { cwd }, (error, stdout, stderr) => {
            if (error) {
                reject({ success: false, error: error.message, stderr });
            } else {
                resolve({ success: true, output: stdout, stderr });
            }
        });
    });
};

// System Check Endpoint
app.post('/api/system-check', async (req, res) => {
    try {
        const checks = {};
        
        // Check UV
        try {
            await execCommand('which uv');
            checks.uv = true;
        } catch {
            checks.uv = false;
        }
        
        // Check PNPM
        try {
            await execCommand('which pnpm');
            checks.pnpm = true;
        } catch {
            checks.pnpm = false;
        }
        
        // Check GitHub CLI
        try {
            await execCommand('which gh');
            checks.gh = true;
        } catch {
            checks.gh = false;
        }
        
        // Check Git
        try {
            await execCommand('which git');
            checks.git = true;
        } catch {
            checks.git = false;
        }
        
        res.json({ success: true, checks });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// Install Missing Tools
app.post('/api/install-tools', async (req, res) => {
    try {
        const { tools } = req.body;
        const results = {};
        
        for (const tool of tools) {
            try {
                switch (tool) {
                    case 'uv':
                        await execCommand('curl -LsSf https://astral.sh/uv/install.sh | sh');
                        results.uv = true;
                        break;
                    case 'pnpm':
                        await execCommand('npm install -g pnpm');
                        results.pnpm = true;
                        break;
                    case 'gh':
                        await execCommand('brew install gh');
                        results.gh = true;
                        break;
                }
            } catch (error) {
                results[tool] = false;
            }
        }
        
        res.json({ success: true, results });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// Create Branch
app.post('/api/create-branch', async (req, res) => {
    try {
        const { branchName, baseBranch = 'main' } = req.body;
        
        // Checkout base branch
        await execCommand(`git checkout ${baseBranch}`);
        
        // Create new branch
        await execCommand(`git checkout -b ${branchName}`);
        
        res.json({ success: true, message: `Branch '${branchName}' created successfully` });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// Push Branch
app.post('/api/push-branch', async (req, res) => {
    try {
        const { branchName, commitTitle, commitDescription } = req.body;
        
        // Add all changes
        await execCommand('git add .');
        
        // Commit with message
        const commitMessage = `${commitTitle}\n\n${commitDescription}`;
        await execCommand(`git commit -m "${commitMessage}"`);
        
        // Push branch
        await execCommand(`git push origin ${branchName}`);
        
        res.json({ success: true, message: `Branch '${branchName}' pushed successfully` });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// Create Pull Request
app.post('/api/create-pr', async (req, res) => {
    try {
        const { branchName, title, description, reviewers = [] } = req.body;
        
        let prCommand = `gh pr create --title "${title}" --body "${description}" --head ${branchName}`;
        
        if (reviewers.length > 0) {
            prCommand += ` --reviewer ${reviewers.join(',')}`;
        }
        
        const result = await execCommand(prCommand);
        
        res.json({ success: true, message: 'Pull request created successfully', output: result.output });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// Execute Full Flow
app.post('/api/execute-flow', async (req, res) => {
    try {
        const { 
            branchName, 
            baseBranch, 
            commitTitle, 
            commitDescription, 
            prTitle, 
            prDescription, 
            reviewers = [],
            autoPR = true 
        } = req.body;
        
        const results = [];
        
        // 1. Create branch
        try {
            await execCommand(`git checkout ${baseBranch}`);
            await execCommand(`git checkout -b ${branchName}`);
            results.push({ step: 'create-branch', success: true });
        } catch (error) {
            results.push({ step: 'create-branch', success: false, error: error.message });
        }
        
        // 2. Add and commit changes
        try {
            await execCommand('git add .');
            const commitMessage = `${commitTitle}\n\n${commitDescription}`;
            await execCommand(`git commit -m "${commitMessage}"`);
            results.push({ step: 'commit', success: true });
        } catch (error) {
            results.push({ step: 'commit', success: false, error: error.message });
        }
        
        // 3. Push branch
        try {
            await execCommand(`git push origin ${branchName}`);
            results.push({ step: 'push', success: true });
        } catch (error) {
            results.push({ step: 'push', success: false, error: error.message });
        }
        
        // 4. Create PR if enabled
        if (autoPR) {
            try {
                let prCommand = `gh pr create --title "${prTitle}" --body "${prDescription}" --head ${branchName}`;
                if (reviewers.length > 0) {
                    prCommand += ` --reviewer ${reviewers.join(',')}`;
                }
                await execCommand(prCommand);
                results.push({ step: 'create-pr', success: true });
            } catch (error) {
                results.push({ step: 'create-pr', success: false, error: error.message });
            }
        }
        
        res.json({ success: true, results });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// Generate Schema
app.post('/api/generate-schema', (req, res) => {
    try {
        const { branchData, commitData, githubData, systemCheck } = req.body;
        
        const schema = {
            metadata: {
                version: "1.0.0",
                generated: new Date().toISOString(),
                project: "Briefcase App",
                author: "AI Assistant"
            },
            system: {
                tools: systemCheck,
                requirements: ["uv", "pnpm", "gh", "git"]
            },
            branch: branchData,
            commit: commitData,
            github: githubData,
            automation: {
                commands: [
                    `git checkout -b ${branchData.type}/${branchData.name}`,
                    "git add .",
                    `git commit -m "${commitData.title}"`,
                    `git push origin ${branchData.type}/${branchData.name}`,
                    `gh pr create --title "${commitData.title}" --body "${commitData.description}"`
                ]
            }
        };
        
        res.json({ success: true, schema });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// Serve the HTML file
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'github-automation.html'));
});

// Start server
app.listen(PORT, () => {
    console.log(`🚀 Briefcase App GitHub Automation Server running on port ${PORT}`);
    console.log(`📱 Open your browser to: http://localhost:${PORT}`);
    console.log(`🔧 System check: http://localhost:${PORT}/api/system-check`);
});

module.exports = app;
