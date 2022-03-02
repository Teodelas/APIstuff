# OKTA Setup
    - Create Okta directory
    - Create Okta user and app
    - Use the Okta discovery URI:
    -   Show script sample
    
    - Configure redirect in Okta app
    https://<apigee-public-ip>.nip.io/v1/oauth20/callback
    
# Apigee Setup


# Troubleshooting
## Fix KVM Values
    export TOKEN=$(gcloud auth print-access-token)
    export APIGEE_ORG=teodlh-apigeex
    export APIGEE_ENV=eval
    export KVM_NAME=idpConfigIdentityProxy
    export API_HOSTNAME=apigeex-eval.dlhdemo.com

curl -X POST     -H "Content-Type: application/json"     -H "Authorization: Bearer $TOKEN"     -d '{"key": "idp.az.hostname", "value": "dev-xyz.okta.com"}'     "https://$API_HOSTNAME/kvm-admin/v1/organizations/$APIGEE_ORG/environments/$APIGEE_ENV/keyvaluemaps/$KVM_NAME/entries"

curl -X POST     -H "Content-Type: application/json"     -H "Authorization: Bearer $TOKEN"     -d '{"key": "idp.az.uri", "value": "oauth2/v1/authorize"}'     "https://$API_HOSTNAME/kvm-admin/v1/organizations/$APIGEE_ORG/environments/$APIGEE_ENV/keyvaluemaps/$KVM_NAME/entries"

curl -X POST     -H "Content-Type: application/json"     -H "Authorization: Bearer $TOKEN"     -d '{"key": "idp.apigee.client_id", "value": "<okta client id>"}'     "https://$API_HOSTNAME/kvm-admin/v1/organizations/$APIGEE_ORG/environments/$APIGEE_ENV/keyvaluemaps/$KVM_NAME/entries"

curl -X POST     -H "Content-Type: application/json"     -H "Authorization: Bearer $TOKEN"     -d '{"key": "idp.apigee.client_secret", "value": "<okta client secret>"}’ "https://$API_HOSTNAME/kvm-admin/v1/organizations/$APIGEE_ORG/environments/$APIGEE_ENV/keyvaluemaps/$KVM_NAME/entries"

curl -X POST     -H "Content-Type: application/json"     -H "Authorization: Bearer $TOKEN"     -d '{"key": “idp.apigee.redirect_uri", "value": "https://$API_HOSTNAME/v1/oauth20/callback
"}'     "https://$API_HOSTNAME/kvm-admin/v1/organizations/$APIGEE_ORG/environments/$APIGEE_ENV/keyvaluemaps/$KVM_NAME/entries"

curl -X POST     -H "Content-Type: application/json"     -H "Authorization: Bearer $TOKEN"     -d '{"key": "idp.token.hostname", "value": "dev-94045917.okta.com"}'     "https://$API_HOSTNAME/kvm-admin/v1/organizations/$APIGEE_ORG/environments/$APIGEE_ENV/keyvaluemaps/$KVM_NAME/entries"

curl -X POST     -H "Content-Type: application/json"     -H "Authorization: Bearer $TOKEN"     -d '{"key": "idp.token.uri", "value": "oauth2/v1/token"}'     "https://$API_HOSTNAME/kvm-admin/v1/organizations/$APIGEE_ORG/environments/$APIGEE_ENV/keyvaluemaps/$KVM_NAME/entries"

curl -X POST     -H "Content-Type: application/json"     -H "Authorization: Bearer $TOKEN"     -d '{"key": "idp.jwks.hostname", "value": "dev-94045917.okta.com"}'     "https://$API_HOSTNAME/kvm-admin/v1/organizations/$APIGEE_ORG/environments/$APIGEE_ENV/keyvaluemaps/$KVM_NAME/entries"

curl -X POST     -H "Content-Type: application/json"     -H "Authorization: Bearer $TOKEN"     -d '{"key": "idp.jwks.uri", "value": "oauth2/v1/keys"}'     "https://$API_HOSTNAME/kvm-admin/v1/organizations/$APIGEE_ORG/environments/$APIGEE_ENV/keyvaluemaps/$KVM_NAME/entries"

curl -X POST     -H "Content-Type: application/json"     -H "Authorization: Bearer $TOKEN"     -d '{"key": "idp.userinfo.hostname", "value": "dev-94045917.okta.com"}'     "https://$API_HOSTNAME/kvm-admin/v1/organizations/$APIGEE_ORG/environments/$APIGEE_ENV/keyvaluemaps/$KVM_NAME/entries"

curl -X POST     -H "Content-Type: application/json"     -H "Authorization: Bearer $TOKEN"     -d '{"key": "idp.userinfo.uri", "value": "oauth2/v1/userinfo"}'     "https://$API_HOSTNAME/kvm-admin/v1/organizations/$APIGEE_ORG/environments/$APIGEE_ENV/keyvaluemaps/$KVM_NAME/entries"

curl -X POST     -H "Content-Type: application/json"     -H "Authorization: Bearer $TOKEN"     -d '{"key": "idp.issuer", "value": "dev-94045917.okta.com"}'     "https://$API_HOSTNAME/kvm-admin/v1/organizations/$APIGEE_ORG/environments/$APIGEE_ENV/keyvaluemaps/$KVM_NAME/entries"

