#!/bin/bash

set -x

# patient-zero-mongo/build.sh

# Static

microk8s.kubectl delete service static-app
microk8s.kubectl delete -f patient-zero-k8s/static-deployment.yml

docker build patient-zero-sample-static -t static-app
docker tag static-app localhost:32000/static-app
docker push localhost:32000/static-app

microk8s.kubectl apply -f patient-zero-k8s/static-deployment.yml
microk8s.kubectl expose deployment static-app --type=LoadBalancer --port=80

# Node

microk8s.kubectl delete service node-app
microk8s.kubectl delete -f patient-zero-k8s/node-deployment.yml

docker build patient-zero-sample-node -t node-app
docker tag node-app localhost:32000/node-app
docker push localhost:32000/node-app

microk8s.kubectl apply -f patient-zero-k8s/node-deployment.yml
microk8s.kubectl expose deployment node-app --type=LoadBalancer --port=8080

# Ingress

microk8s.kubectl delete -f patient-zero-k8s/ingress.yml
microk8s.kubectl apply -f patient-zero-k8s/ingress.yml