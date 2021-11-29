#!/usr/bin/env python3

from aws_cdk import core
from stacks.vpc_stack import VPCStack

#To create new VPC


#Enable if you have existing VPC
#from stacks.eks_stack_existing_vpc import EKSStack

app = core.App()

vpc_stack = VPCStack(app, 'vpc')


#Enable if you have existing VPC
#eks_stack = EKSStack(app, 'eks')

app.synth()