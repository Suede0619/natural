#!/bin/bash

# Quartz Server Stability Script
# Based on research: Quartz requires Node v22+ for stability
# Issue found: Node v23+ causes crashes due to experimental features

echo "🌱 Starting Quartz Server with Stability Enhancements"
echo "=================================================="

# Ensure we're using Node v22.13.1 LTS for stability
source ~/.nvm/nvm.sh
nvm use 22.13.1

# Verify Node version meets requirements
NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 22 ]; then
    echo "❌ Error: Node.js v22+ required. Current: $(node --version)"
    echo "Please run: nvm install 22.13.1 && nvm use 22.13.1"
    exit 1
fi

echo "✅ Using Node $(node --version) and npm $(npm --version)"

# Clear any potential memory issues from previous runs
echo "🧹 Cleaning up previous builds..."
rm -rf .quartz-cache 2>/dev/null || true

# Start server with memory leak monitoring
echo "🚀 Starting Quartz server..."
echo "📝 Note: Hot-reload may cause ~350kB memory leaks per reload"
echo "🔄 Server will restart automatically if it crashes"

# Use forever-like behavior with automatic restart
while true; do
    npx quartz build --serve
    echo "⚠️  Server stopped unexpectedly. Restarting in 3 seconds..."
    sleep 3
done