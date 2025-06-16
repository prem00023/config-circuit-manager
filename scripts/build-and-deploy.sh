
#!/bin/bash

# Build and Deploy Script for Circuit Management Portal

set -e

# Configuration
IMAGE_NAME="circuit-management"
IMAGE_TAG="latest"
NAMESPACE="circuit-management"

echo "🏗️  Building Docker image..."
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .

echo "📦 Tagging image for registry..."
# Uncomment and modify for your registry
# docker tag ${IMAGE_NAME}:${IMAGE_TAG} your-registry.com/${IMAGE_NAME}:${IMAGE_TAG}

echo "⬆️  Pushing to registry..."
# Uncomment for registry push
# docker push your-registry.com/${IMAGE_NAME}:${IMAGE_TAG}

echo "🚀 Deploying to Kubernetes..."

# Create namespace if it doesn't exist
kubectl apply -f k8s/namespace.yaml

# Apply all Kubernetes configurations
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/hpa.yaml

echo "✅ Deployment completed successfully!"

# Check deployment status
echo "📊 Checking deployment status..."
kubectl rollout status deployment/circuit-management-app -n ${NAMESPACE}

# Show pods
echo "🏃 Running pods:"
kubectl get pods -n ${NAMESPACE}

# Show services
echo "🌐 Services:"
kubectl get services -n ${NAMESPACE}

echo "🎉 Circuit Management Portal is now deployed!"
