#!/bin/bash

# Update the package index
echo "Updating package index..."
sudo apt update -y

# Install prerequisites
echo "Installing prerequisites..."
sudo apt install -y curl

# Install Node.js (using NodeSource)
echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Verify Node.js and npm installation
echo "Verifying Node.js and npm installation..."
node_version=$(node -v)
npm_version=$(npm -v)
echo "Node.js version: $node_version"
echo "npm version: $npm_version"

# Create a directory for the Node.js project
project_dir="hello-world-node"
echo "Creating project directory: $project_dir"
mkdir $project_dir
cd $project_dir

# Initialize a Node.js project
echo "Initializing Node.js project..."
npm init -y

# Create a simple "Hello World" app inside the project directory
echo "Creating hello.js inside $project_dir..."
cat <<EOL > hello.js
const http = require('http');

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello, World!\\n');
});

const PORT = 3000;
server.listen(PORT, () => {
  console.log(\`Server running at http://localhost:\${PORT}/\`);
});
EOL

# Add start script to package.json
echo "Adding start script to package.json..."
sed -i 's/"scripts": {/"scripts": {\n    "start": "node hello.js",/' package.json

# Start the Node.js application
echo "Starting the Node.js application..."
npm start
