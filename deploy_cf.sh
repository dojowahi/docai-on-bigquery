#!/bin/bash

#####################################################################################################
# Script Name: deploy_cf.sh
# Date of Creation: 12/01/2022
# Author: Ankur Wahi
# Updated: 12/01/2022
#####################################################################################################

source ./config.sh

project_id=${PROJECT_ID}
cf_docai="docai-parser"


echo "Deploying Doc AI CF"

cd ~/docai-on-bigquery/src/cloud-functions/docai

gcloud functions deploy ${cf_docai} --entry-point get_doc --runtime python39 --trigger-http --allow-unauthenticated --project ${project_id} --service-account ${doc_sa} --gen2 --region ${REGION} --run-service-account ${doc_sa} --memory 256MB



endpoint_docai=$(gcloud functions describe ${cf_docai} --region=${REGION} --gen2 --format=json | jq -r '.serviceConfig.uri')


bq mk -d docai


build_sql="CREATE OR REPLACE FUNCTION docai.doc_extractor(uri STRING, mime_type STRING, location STRING,docai_processorId STRING) RETURNS STRING REMOTE WITH CONNECTION \`${project_id}.us.gcf-docai-conn\` OPTIONS ( endpoint = '${endpoint_docai}')"

    
bq query --use_legacy_sql=false ${build_sql}
