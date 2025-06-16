
#!/bin/bash

# Local Development Script

set -e

echo "🏗️  Building application locally..."
npm run build

echo "🐳 Building Docker image..."
docker build -t circuit-management:dev .

echo "🚀 Starting local container..."
docker run -d \
  --name circuit-management-dev \
  -p 8080:80 \
  circuit-management:dev

echo "✅ Application is running at http://localhost:8080"
echo "🛑 To stop: docker stop circuit-management-dev && docker rm circuit-management-dev"
