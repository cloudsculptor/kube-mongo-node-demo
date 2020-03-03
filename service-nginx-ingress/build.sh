#!/bin/bash

microk8s.kubectl delete -f patient-zero-k8s/ingress.yml
microk8s.kubectl apply -f patient-zero-k8s/ingress.yml