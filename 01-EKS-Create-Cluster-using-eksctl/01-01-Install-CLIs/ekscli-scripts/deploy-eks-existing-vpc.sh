#!/bin/bash

#deploy with atomatic VPC pelase refer to the yaml to deploy with existing VPC
eksctl create cluster --name=eksdemo1 \
                      --region=eu-central-1 \
                      --vpc-private-subnets=subnet-0751e6722a6fd51f0,subnet-019d86a1b60152405 \
                      --vpc-public-subnets=subnet-0eddfa7c33f6eb916,subnet-0bb0c596c6db7b089 \
                      -- 
                      --without-nodegroup 

#create tags
#kubernetes.io/cluster/<name> tag set to either shared or owned
#kubernetes.io/role/internal-elb tag set to 1 for private subnets
#kubernetes.io/role/elb tag set to 1 for public subnets