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

# Port forward kafka for producer and consumer connections is done in the kafka-e11b.yaml file
# Even though  kafka is portforwarded to localhost:31092, it is not acceessibble via the borwser as kafka runs on kafka protocol not http or https.
# The only wat to test kafka is 
# 1. kafkakat at command line
# 2. kafka-ui
# 3. Python quixstreams

# Use kafkacat to send a test message to kafka
# echo "{'key': 'value'}" | kafkacat -b localhost:31092 -P -t test-topic
# Confirm the messsage is received by looking at kafka-ui


# portforward kafka-ui
kubectl port-forward -n kafka svc/kafka-ui 8182:8080 &
echo "Kafka UI is running at http://localhost:8182"