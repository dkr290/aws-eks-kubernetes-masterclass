#!/bin/bash
eksctl utils associate-iam-oidc-provider \
    --region  eu-central-1\
    --cluster eksdemo1 \
    --approve
