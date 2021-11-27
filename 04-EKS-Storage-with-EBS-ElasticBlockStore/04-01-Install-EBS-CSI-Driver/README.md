# EKS Storage with EBS - Elastic Block Store

## Step-01: Introduction
- Create IAM Policy for EBS
- Associate IAM Policy to Worker Node IAM Role
- Install EBS CSI Driver

## Step-02:  Create IAM policyy
- Go to Services -> IAM
- Create a Policy 
  - Select JSON tab and copy paste the below JSON
```json

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AttachVolume",
        "ec2:CreateSnapshot",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteSnapshot",
        "ec2:DeleteTags",
        "ec2:DeleteVolume",
        "ec2:DescribeInstances",
        "ec2:DescribeSnapshots",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes",
        "ec2:DetachVolume"
      ],
      "Resource": "*"
    }
  ]
}
```
  - Review the same in **Visual Editor** 
  - Click on **Review Policy**
  - **Name:** Amazon_EBS_CSI_Driver
  - **Description:** Policy for EC2 Instances to access Elastic Block Store
  - Click on **Create Policy**

## Step-03: Get the IAM role Worker Nodes using and Associate this policy to that role
```
# Get Worker node IAM Role ARN
kubectl -n kube-system describe configmap aws-auth

# from output check rolearn
rolearn: arn:aws:iam::180789647333:role/eksctl-eksdemo1-nodegroup-eksdemo-NodeInstanceRole-IJN07ZKXAWNN
```
- Go to Services -> IAM -> Roles 
- Search for role with name **eksctl-eksdemo1-nodegroup** and open it
- Click on **Permissions** tab
- Click on **Attach Policies**
- Search for **Amazon_EBS_CSI_Driver** and click on **Attach Policy**

## Step-04: Deploy Amazon EBS CSI Driver  
- Verify kubectl version, it should be 1.14 or later
```
kubectl version --client --short
```
- Deploy Amazon EBS CSI Driver
```
# Deploy EBS CSI Driver
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master"

# Verify ebs-csi pods running
kubectl get pods -n kube-system
```


# You can follow also the procedure below taken from AWS documentation
# Download the IAM policy document from GitHub.
```
curl -o example-iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-ebs-csi-driver/release-1.3/docs/example-iam-policy.json
```

# Create the policy. You can change AmazonEKS_EBS_CSI_Driver_Policy to a different name, but if you do, make sure to change it in later steps too.
```
aws iam create-policy \
    --policy-name AmazonEKS_EBS_CSI_Driver_Policy \
    --policy-document file://example-iam-policy.json
```

# replace mycluster with the relevant name replace 111122223333 with your account id 

```
eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster my-cluster \
    --attach-policy-arn arn:aws:iam::111122223333:policy/AmazonEKS_EBS_CSI_Driver_Policy \
    --approve \
    --override-existing-serviceaccounts
```


# Add the respective helm repos

```
helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver
helm repo update
```


# install the driver and replace 602401143452.dkr.ecr.eu-central-1.amazonaws.com depending on the region
# from here https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html
```
helm upgrade -install aws-ebs-csi-driver aws-ebs-csi-driver/aws-ebs-csi-driver \
    --namespace kube-system \
    --set image.repository=602401143452.dkr.ecr.eu-central-1.amazonaws.com/eks/aws-ebs-csi-driver\
    --set controller.serviceAccount.create=false \
    --set controller.serviceAccount.name=ebs-csi-controller-sa
```






