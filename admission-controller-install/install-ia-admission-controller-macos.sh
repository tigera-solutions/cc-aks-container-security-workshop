#!/usr/bin/env bash

curl ${URL}/tigera-image-assurance-admission-controller.yaml -o tigera-image-assurance-admission-controller.yaml
curl ${URL}/01-tigera-secure-admission-controller-tls-secret.yaml.tpl.sh -o 01-tigera-secure-admission-controller-tls-secret.yaml.tpl.sh
curl ${URL}/06-tigera-secure-validating-webhook.yaml.tpl.sh -o 06-tigera-secure-validating-webhook.yaml.tpl.sh

chmod +x generate-resource-yaml-macos.sh
chmod +x 01-tigera-secure-admission-controller-tls-secret.yaml.tpl.sh
chmod +x 06-tigera-secure-validating-webhook.yaml.tpl.sh

./generate-resource-yaml-macos.sh

cp 01-tigera-secure-admission-controller-tls-secret.yaml tigera-image-assurance-admission-controller-deploy.yaml
cat tigera-image-assurance-admission-controller.yaml >>tigera-image-assurance-admission-controller-deploy.yaml
sed -s -e '1 s/^/---\n/g' 06-tigera-secure-validating-webhook.yaml >>tigera-image-assurance-admission-controller-deploy.yaml