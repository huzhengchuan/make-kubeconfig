#!/bin/sh -e

set -o pipefail

if test -z "$1"; then
    echo "$0: server is required."
fi

kubectl config set-cluster \
    --embed-certs \
    --server=${1} \
    --certificate-authority=/run/secrets/kubernetes.io/serviceaccount/ca.crt \
    $(cat /run/secrets/kubernetes.io/serviceaccount/namespace)

kubectl config set-credentials \
    $(cat /run/secrets/kubernetes.io/serviceaccount/namespace) \
    --token=$(cat /run/secrets/kubernetes.io/serviceaccount/token)

kubectl config set-context \
    --cluster=$(cat /run/secrets/kubernetes.io/serviceaccount/namespace) \
    --user=$(cat /run/secrets/kubernetes.io/serviceaccount/namespace) \
    $(cat /run/secrets/kubernetes.io/serviceaccount/namespace)

kubectl config use-context $(cat /run/secrets/kubernetes.io/serviceaccount/namespace)

kubectl config view --raw