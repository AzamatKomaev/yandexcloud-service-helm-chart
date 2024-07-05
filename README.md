# yandexcloud-service-helm-chart

![image](https://github.com/AzamatKomaev/yandexcloud-service-helm-chart/assets/86872713/c5d3174e-8daa-458a-82f4-909ebe9f05d8)

## Before installing

This repository contains helm chart that could help you with deploying applications on Yandex.Cloud Kubernetes. Check [Habr article](https://habr.com/ru/articles/769046/) to get known about initial state of the chart. 
Unless the chart has basic Kubernetes resources (like Deployment and Services) on your K8s cluster should be installed [external-secrets chart]([https://habr.com/ru/articles/769046/](https://github.com/external-secrets/external-secrets)). 
It will allow you to deploy CRD resources on your cluster (SecretStore and ExternalSecret). These resources are necessary if you want to integrate with [Yandex Certificate 
Manager](https://yandex.cloud/en/docs/certificate-manager/) and [Yandex Lockbox](https://yandex.cloud/en/docs/lockbox/).

## values.yaml
Check actual chart values [here](https://github.com/AzamatKomaev/yandexcloud-service-helm-chart/blob/main/values.yaml). 

## templates
In this section you can check information about all resources in the chart. 

<b>cert-secret-store.yaml</b> - Optional SecretStore resource. We can use such type of resource
to create integration with external API. That file contains configuration to connect to 
Yandex Certificate Manager.

<b>lockbox-secret-store.yaml</b> - Optional SecretStore resource. It contains almost the same
configration as in cert-secret-store.yaml, but connect to Yandex Lockbox.

<b>cert-external-secret.yaml</b> - Optional ExternalSecret resource. Uses SecretStore and
Certificate ID to get TLS certificate and create K8s Secret.

<b>lockbox-external-secret.yaml</b> - Optional ExternalSecret resource. Uses SecretStore and
Secret ID to get secrets and create K8s Secret.

<b>cluster.ip</b> - Required Service resource. Expose application on selected port.

<b>deploy.yaml</b> - Required Deployment resource. Run selected replicas for application.

<b>ingress.yaml</b> - Optional Ingress  resource. Can be used to expose application 
under HTTPS.

## Installation

Deploy simple nginx application:

```shell
helm install \
    -n nginx-helm \
    --set lockboxSecretStore.enabled=true \
    --set certificateSecretStore.enabled=false \
    --set deployment.image=nginx:1.25.2 \
    --set deployment.containerPort=80 \
    --set ingress.enabled=true \
    --set ingress.hosts=example.com \
    nginx .
```
