helm install --dry-run -f values.yaml \
    -n nginx-helm \
    --set lockboxSecretStore.enabled=true \
    --set certificateSecretStore.enabled=false \
    --set deployment.image=nginx:1.25.2 \
    --set deployment.containerPort=80 \
    --set ingress.enabled=true \
    --set ingress.hosts={a\.com\,b\.com} \
    nginx ../