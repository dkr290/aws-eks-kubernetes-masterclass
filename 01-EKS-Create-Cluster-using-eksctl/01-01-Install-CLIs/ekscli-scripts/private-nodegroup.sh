eksctl create nodegroup --cluster=eksdemo1 \
                        --region=eu-central-1 \
                        --name=eksdemo1-ng-private1 \
                        --node-type=t3.small \
                        --nodes-min=1 \
                        --nodes-max=4 \
                        --node-volume-size=10 \
                        --ssh-access \
                        --ssh-public-key=ec2testkey \
                        --managed \
                        --asg-access \
                        --external-dns-access \
                        --full-ecr-access \
                        --appmesh-access \
                        --alb-ingress-access \
                        --node-private-networking