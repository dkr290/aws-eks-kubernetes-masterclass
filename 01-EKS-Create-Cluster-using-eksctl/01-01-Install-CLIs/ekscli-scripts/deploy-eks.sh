#!/bin/bash

#deploy with aotomatic VPC pelase refer to the yaml to deploy with existing VPC
eksctl create cluster --name=eksdemo1 \
                      --region=eu-central-1 \
                      --zones=eu-central-1a,eu-central-1b \
                      --without-nodegroup 
