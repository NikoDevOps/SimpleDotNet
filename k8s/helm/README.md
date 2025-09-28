# Quick start

# create namespace (if needed)
kubectl create ns helloenv || true

# Install chart from local folder ./helloenv
helm install helloenv . -n helloenv \
  --set image.repository=ghcr.io/nikodevops/helloenv \
  --set image.tag=dev \
  --set config.GREETING="Kuber"

# Enable Ingress (example)
helm upgrade helloenv ./helloenv -n helloenv \
  --set ingress.enabled=true \
  --set ingress.hosts[0].host=helloenv.example.com \
  --set ingress.hosts[0].paths[0].path=/ \
  --set ingress.hosts[0].paths[0].pathType=Prefix