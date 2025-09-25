#!/bin/bash

# Briefcase GitHub Automation - Quick Start
# Located in AppsHub for easy access

echo "🚀 Briefcase GitHub Automation - Quick Start"
echo "============================================="

# Navigate to the automation folder
cd "/Volumes/SeverD-1/Shared/AppsHub/Briefcase-GitHub-Automation"

echo "📁 Location: $(pwd)"
echo ""

# Check if we're in the right directory
if [ ! -f "github-automation.html" ]; then
    echo "❌ Error: Not in the correct directory"
    echo "Please run this from the Briefcase-GitHub-Automation folder"
    exit 1
fi

echo "✅ Found GitHub automation files"
echo ""

# Show available options
echo "🎯 Available Options:"
echo "1. Open in browser (standalone)"
echo "2. Start server (full experience)"
echo "3. Run setup script"
echo "4. Check system requirements"
echo "5. Install dependencies"
echo ""

read -p "Choose an option (1-5): " choice

case $choice in
    1)
        echo "🌐 Opening in browser..."
        open github-automation.html
        ;;
    2)
        echo "🚀 Starting server..."
        if [ ! -d "node_modules" ]; then
            echo "📦 Installing dependencies first..."
            npm install
        fi
        node github-automation-server.js
        ;;
    3)
        echo "🔧 Running setup script..."
        ./setup.sh
        ;;
    4)
        echo "🔍 Checking system requirements..."
        ./setup.sh check
        ;;
    5)
        echo "📦 Installing dependencies..."
        npm install
        ;;
    *)
        echo "❌ Invalid option"
        exit 1
        ;;
esac

echo ""
echo "✅ Operation completed!"
echo ""
echo "📖 For more information, see README.md"
echo "🌐 Web interface: http://localhost:3000"
echo "📁 Files location: $(pwd)"
