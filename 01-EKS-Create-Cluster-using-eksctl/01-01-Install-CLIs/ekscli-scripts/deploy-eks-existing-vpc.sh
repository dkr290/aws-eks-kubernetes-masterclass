#!/bin/bash

#deploy with atomatic VPC pelase refer to the yaml to deploy with existing VPC
eksctl create cluster --name=eksdemo1 \
                      --region=eu-central-1 \
                      --vpc-private-subnets=subnet-0fcaed4ab8d710574,subnet-043f7d85b8ef5ba10 \
                      --vpc-public-subnets=subnet-0939ed04e6646bd0d,subnet-092d2e9f572efebf9 \
                      --without-nodegroup 
