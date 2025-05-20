#!/bin/bash

# Clean up previous kubernates cluster
# Rancher Desktop > Troubleshooting > Reset Kubernates

# Create a local kubernates cluster for development.
# We are using Rancher Desktop, which creates a single node kubernates cluster
# Ensure Rancher Desktop is running and Preferences > Kubernetes > Enable Kubernetes # is checked.
# Install kafka, kafka-ui, granfana, mlflow, risingwave, metabase on this cluster


# Install kafka
kubectl create namespace kafka
kubectl create -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka
kubectl apply -f manifests/kafka-e11b.yaml


# Install kafka-ui
kubectl apply -f manifests/kafka-ui-all-in-one.yaml




# Port forwarding once services are up

# Port forward kafka for producer and consumer connections
kubectl port-forward -n kafka service/kafka-e11b-kafka-bootstrap 31092:31092 &
echo "Kafka is running at localhost:31092"
# Test by



# portforward kafka-ui
kubectl port-forward -n kafka svc/kafka-ui 8182:8080 &
echo "Kafka UI is running at http://localhost:8182"