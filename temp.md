export APIGEE_X_ORG=teodlh-apigeex
export APIGEE_X_ENV=eval
export APIGEE_X_HOSTNAME=34.149.2.239.nip.io
export TEST_IDP_DISCOVERY_DOCUMENT=https://dev-94045917.okta.com/.well-known/openid-configuration
export TEST_IDP_APIGEE_CLIENT_ID=0oaqi3vqwaJrs7Idq5d6
export TEST_IDP_APIGEE_CLIENT_SECRET=iKAY1MyFD8rCUF_3TM8YK3AjSpP_KWXuouG2qsxV

https://apigeex-eval.dlhdemo.com/v1/oauth20/authorize?client_id=xkey-1626394128&redirect_uri=https://httpbin.org/get&response_type=code&state=1&scope=openid%20email%20profile

export TOKEN=$(gcloud auth print-access-token)
export APIGEE_ORG=teodlh-apigeex
export APIGEE_ENV=eval
export KVM_NAME=idpConfigIdentityProxy
export API_HOSTNAME=apigeex-eval.dlhdemo.com


export APIGEE_ORG=teodlh-project
export API_HOSTNAME=apigeex.dlhdemo.com


curl -X GET \
    -H "Authorization: Bearer $TOKEN" \
    "https://$API_HOSTNAME/kvm-admin/v1/organizations/$APIGEE_ORG/environments/$APIGEE_ENV/keyvaluemaps/$KVM_NAME/entries/idp.az.hostname"

curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN" \
    -d '{"key": "idp.issuer", "value": "dev-94045917.okta.com"}' \
    "https://$API_HOSTNAME/kvm-admin/v1/organizations/$APIGEE_ORG/environments/$APIGEE_ENV/keyvaluemaps/$KVM_NAME/entries"
    
    OKTA Setup:
    - Create Okta directory
    - Create Okta user and app
    - 
    - Use the Okta discovery URI:
    -   Show script sample
    
    - Configure redirect in Okta app
    https://<apigee-public-ip>.nip.io/v1/oauth20/callback
    
    gcloud compute ssl-certificates create apigee-ssl-cert \
    --description="Apigee SSL Certv2"\
    --domains=34.149.2.239.nip.io,apigeex-eval.dlhdemo.com \
    --global
