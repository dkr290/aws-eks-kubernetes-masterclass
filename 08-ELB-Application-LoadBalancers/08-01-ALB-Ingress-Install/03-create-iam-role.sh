#!/bin/bash

ARN_ID="arn:aws:iam::506564311551:policy/ALBIngressControllerIAMPolicy"
REGION="eu-central-1"
CLUSTER_NAME="eksdemo1"

eksctl create iamserviceaccount \
    --region $REGION \
    --name alb-ingress-controller \
    --namespace kube-system \
    --cluster $CLUSTER_NAME \
    --attach-policy-arn $ARN_ID \
    --override-existing-serviceaccounts \
    --approve