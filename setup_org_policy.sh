##################################################
##
## Create and Configure GCP project for EE+BQ
##
##################################################

# source the previously set env variables
source ./config.sh

# prompt user to login
gcloud auth login ${USER_EMAIL}

##################################################
##
## Project
##
##################################################

echo "Creating new project"

gcloud projects create ${PROJECT_ID}

echo "Setting default project"

gcloud config set project ${PROJECT_ID}

##################################################
##
## Billing
##
##################################################

echo "Assigning billing account"

gcloud billing projects link ${PROJECT_ID} --billing-account=${BILLING_ACCOUNT_ID}

##################################################
##
## Org Policies
##
##################################################

echo "Configuring org policies at project level"

#enable VPC peering
cat <<EOF > new_policy.yaml
constraint: constraints/compute.restrictVpcPeering
listPolicy:
    allValues: ALLOW
constraint: constraints/compute.vmExternalIpAccess
listPolicy:
    allValues: ALLOW
constraint: constraints/cloudfunctions.allowedIngressSettings
listPolicy:
    allValues: ALLOW
constraint: constraints/iam.allowedPolicyMemberDomains
listPolicy:
    allValues: ALLOW
constraint: constraints/iam.disableServiceAccountKeyCreation
boolean_policy:
    enforced: false
EOF
gcloud resource-manager org-policies set-policy \
    --project=${PROJECT_ID} new_policy.yaml

#disable the shielded vm requirement
gcloud resource-manager org-policies disable-enforce \
    compute.requireShieldedVm --project=${PROJECT_ID}
