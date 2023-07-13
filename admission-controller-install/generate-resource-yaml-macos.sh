#!/usr/bin/env bash

CURRENT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export BASE64_CERTIFICATE=$(cat ${CURRENT_DIR}/admission_controller_cert.pem | base64 -b 0)
export BASE64_KEY=$(cat ${CURRENT_DIR}/admission_controller_key.pem | base64 -b 0)

export FILE_NAME=${CURRENT_DIR}/01-tigera-secure-admission-controller-tls-secret.yaml
${CURRENT_DIR}/01-tigera-secure-admission-controller-tls-secret.yaml.tpl.sh

export FILE_NAME=${CURRENT_DIR}/06-tigera-secure-validating-webhook.yaml
${CURRENT_DIR}/06-tigera-secure-validating-webhook.yaml.tpl.sh