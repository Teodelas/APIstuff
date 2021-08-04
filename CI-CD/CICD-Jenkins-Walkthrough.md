# Deploy Jenkins and Configure Jenkins
1. Deploy Jenkins from [GCP Marketplace](https://pantheon.corp.google.com/marketplace/product/click-to-deploy-images/jenkins)
	1. A sample production scale ready deployment of Jenkins can be found [here](https://cloud.google.com/architecture/using-jenkins-for-distributed-builds-on-compute-engine)
1. After the VM is successfully deployed, SSH into VM. GCP console provides an easy way to do this:
![SSH]
(./images/ssh-vm.png)

## Install nodejs, npm, and Maven
1. sudo apt install nodejs
2. sudo apt install npm
3. sduo apt install maven
  
# Setup Github repo
1. Create a github repo:https://docs.github.com/en/get-started/quickstart/create-a-repo 
1. Setup Git repo locally
` $ export GIT_URL=https://github.com/username/repo.git
  $ cd $home
  $ mkdir cicd-demo
  $ cd cicd-demo
  $ git init
  $ git remote add origin $GIT_URL
  $ git add .
  $ git commit -m "initial commit"`
  
## Copy CICD Reference implementation
` $ mkdir devrel

  $ git pull https://github.com/apigee/devrel.git
  
  $ cp ~/devrel/references/cicd-pipeline/. ~/cicd-demo/reponame/. -a -r
  $ cd ~/cicd-demo/reponame
  $ git add .
  $ git commit -m "devrel cicd reference"
  $ git push`
  
# Configure GCP IAM

## Create service account for Jenkins
1. export SERVICE_ACCOUNT_ID=jenkins-apigee-service-acocunt
1. export PROJECT_ID=teodlh-apigeex
1. gcloud iam service-accounts create $SERVICE_ACCOUNT_ID \
    --description="Jenkins service account" \
    --display-name="jenkins-appigee-service-account"   
1. gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT_ID@$PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/apigee.admin"
*To use a different role, see roles available here or create a custom role: https://cloud.google.com/iam/docs/understanding-roles#apigee-roles*
1. gcloud iam service-accounts keys create ./jenkins-key-file.json \
    --iam-account=$SERVICE_ACCOUNT_ID@$PROJECT_ID.iam.gserviceaccount.com
    
## Activate service account on Jenkins VM
1. SSH into Jenkins VM
1. gcloud auth activate-service-account $SERVICE_ACCOUNT_ID@$PROJECT_ID.iam.gserviceaccount.com --key-file=./jenkins-key-file.json --project=$PROJECT_ID
  
# Configure Jenkins
 
## Add Plugins
1. Go to http://35.196.27.63/pluginManager/
1. Click on Available, and install: Pipeline:Multibranch, cucumber-reports:5.5.0, git:4.8.0, html publisher, junit:1.51, matrix-project:1.19, script-security:1.77, token-macro:2.15, workflow-step-api:2.24, configuration-as-code:1.51, workflow-aggregator:2.6, workflow-multibranch:2.22
1. Check off Github and click on 'Install without restart'

## Configure global variables
1. Go to http://<jenkins ip / url>/configure
1. Scroll down to Global properties and check off Environment variables
	1. Add PATH+EXTRA as */opt/apache-maven-3.8.1/bin*
	1. Add ID_File as */path-to-id-file.json*
	3. APIGEE_ENV, APIGEE_ORG, and APIGEE_URL as environment variables and set the values to your Apigee org a
  
## Configure Jenkinsfile 
This configuration sets the maven profile to use Apigee X management API (GoogleAPI) and authenticate using an the IAM service account created previously
1. In the GitHub repo, go to the file /ci-config/jenkins/Jenkinsfile
1. Find the section that begins with *mvn clean install* and replace it with the code below

`mvn clean install \
                -P"googleapi" \
                -Denv="${env.APIGEE_ENV}" \
                -Dorg="${env.APIGEE_ORG}" \
                -Durl="${env.APIGEE_URL}" \
                -Dbearer="$(gcloud auth print-access-token)" \
                -Ddeployment.suffix="${env.APIGEE_DEPLOYMENT_SUFFIX}" \
                -Ddeployment.description="Jenkins Build: ${env.BUILD_TAG} Author: ${env.AUTHOR_EMAIL}"
`
## Configure Maven
This configuration sets the maven profile to use custom apigee url
1. Edit pom.xml
1. Find the `<properties>` section
1. Add `<apigee.url>${url}</apigee.url>`
1. Find the plugin section `<groupId>com.google.code.maven-replacer-plugin</groupId>`
1. Replace 
 ` 						<token>org-env.apigee.net</token>
							<value>${apigee.org}-${apigee.env}.apigee.net</value>`
   with 
  ` 					<token>org-env.apigee.net</token>
							<value>${apigee.url}</value>`  
1. 

  
  
  


