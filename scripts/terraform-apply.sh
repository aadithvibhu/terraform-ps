#!/bin/bash

###################################################
#   terraform-apply.sh
# Author: Satheesh Papisetty
##################################################

set +x
set -e

##################################################################
# Export Runtime Variables
##################################################################

export no_proxy=169.254.169.254,localhost,127.0.0.1
export PATH=${TF_HOME}:$PATH

##################################################################
# Move to project terraform config directory
##################################################################

echo ${WORKSPACE}/${PROJECT}/${ENVNAME}
cd ${WORKSPACE}/${PROJECT}/${ENVNAME}
terraform import aws_key_pair.${KEYNAME} ${KEYNAME}
##################################################################
# Delete local terraform config and pull from s3 config
##################################################################

rm -rf .terraform

######################################################################################
# Pull remote terraform config then compare and update finally pushing to s3
######################################################################################

echo "########################################################################################"
echo "# Terraform State Bucket = ${S3_BUCKET}/${PROJECT}/${ENVNAME}/${APPNAME}.state #"
echo "# Key_id = ${KMS_KEY_ID}                                                               #"
echo "########################################################################################"

terraform version

terraform init \
      -backend=true \
      -backend-config="bucket=${S3_BUCKET}" \
      -backend-config="key=${PROJECT}/${ENVNAME}/${APPNAME}.tfstate" \
      -backend-config="region=ap-southeast-1" \
      -backend-config="acl=bucket-owner-full-control" \
      -backend-config="encrypt=1"
terraform apply --auto-approve=true
echo "Exit code: {$?}"
