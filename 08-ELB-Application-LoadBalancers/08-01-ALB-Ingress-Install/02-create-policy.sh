#!/bin/bash

aws iam create-policy \
     --policy-name ALBIngressControllerIAMPolicy \
     --policy-document https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/master/docs/examples/iam-policy.json