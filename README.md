# SQL over Docs
The goal of this demo is to run a BigQuery SQL and extract information from documents

## Requirements
* Ensure the GCP user is allowed to create service accounts and assign roles


## Setting up the demo
**1)** In Cloud Shell or other environment where you have the gcloud SDK installed, execute the following commands:
```console
gcloud components update 
cd $HOME

git clone https://github.com/dojowahi/docai-on-bigquery.git
cd ~/docai-on-bigquery
chmod +x *.sh
```

**2)** **Edit config.sh** - In your editor of choice update the variables in config.sh to reflect your desired gcp project.

**3)** Next execute the command below

```console
sh setup_sa.sh
```

**4)** Next execute the command below

```console
sh deploy_cf.sh
```

If the shell script has executed successfully,have a dataset docai and table land_coords under your project in BigQuery along with a function doc_extractor
<br/><br/>


<br/><br/>
### Congrats! You just executed BigQuery SQL over Documents
