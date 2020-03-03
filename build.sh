#!/bin/bash

echo ""
echo "------------------------------------------------------"
echo ""
echo " Build and deploy sample app to Kubernetes cluster"
echo ""
echo " This script will:"
echo ""
echo "   * Delete any existing deployments (ignore delete errors on first run)"
echo "   * Build Docker images, tag and push them to a local"
echo "     repo integrated with the local k8s cluster."
echo "   * Deploy these images to k8s."
echo "   * Deploy a 3 node MongoDB Replica Set using the official Helm chart."
echo "   * Expose the two public services with an Nginx ingress."
echo ""
echo "   Feel free to run any of the steps manually in isolation."
echo ""
echo "------------------------------------------------------"
echo ""

set -x

# service-static-html

microk8s.kubectl delete service service-static-html
microk8s.kubectl delete -f service-static-html/service-static.deployment.yml

docker build service-static-html -t service-static-html
docker tag service-static-html localhost:32000/service-static-html
docker push localhost:32000/service-static-html

microk8s.kubectl apply -f service-static-html/service-static.deployment.yml
microk8s.kubectl expose deployment service-static-html --type=LoadBalancer --port=80

# service-mongodb-api

microk8s.kubectl delete service service-mongodb-api
microk8s.kubectl delete -f service-mongodb-api/service-mongodb-api.deployment.yml

docker build service-mongodb-api -t service-mongodb-api
docker tag service-mongodb-api localhost:32000/service-mongodb-api
docker push localhost:32000/service-mongodb-api

microk8s.kubectl apply -f service-mongodb-api/service-mongodb-api.deployment.yml
microk8s.kubectl expose deployment service-mongodb-api --type=LoadBalancer --port=8080

# service-mongodb

helm delete service-mongodb
helm install service-mongodb stable/mongodb -f service-mongodb/values.yaml

# service-nginx-ingress

microk8s.kubectl delete -f service-nginx-ingress/ingress.yml
microk8s.kubectl apply -f service-nginx-ingress/ingress.yml

set +x

echo ""
echo "------------------------------------------------------"
echo ""
echo " Please wait for the above deployments to complate."
echo " Then web interface should be available at:"
echo ""
echo "   http://127.0.0.1"
echo ""