#!/bin/bash

# Ensure we're using Node v22.13.1 LTS for stability
source ~/.nvm/nvm.sh
nvm use 22.13.1

echo "Using Node $(node --version) and npm $(npm --version)"
echo "Starting Quartz server..."

# Start the server with better error handling
npx quartz build --serve