#!/bin/bash


POLICY_ARN="arn:aws:iam::112234445555:policy/AmazonEKS_EBS_CSI_Driver_Policy"
CLUSTER="eksdemo1"

eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster $CLUSTER \
    --attach-policy-arn $POLICY_ARN \
    --approve \
    --override-existing-serviceaccounts



