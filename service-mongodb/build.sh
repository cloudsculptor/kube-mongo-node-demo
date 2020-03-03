#!/bin/bash

# Install Helm chart: https://github.com/helm/charts/tree/master/stable/mongodb

helm install service-mongodb stable/mongodb -f values.yaml

# Uninstall command: `helm delete service-mongodb`