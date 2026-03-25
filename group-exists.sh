# --- Permissions ---
#gcloud organizations add-iam-policy-binding [YOUR_ORG_ID] \
  #--member="serviceAccount:[svc-account]@[project-id].iam.gserviceaccount.com" \
  #--role="roles/serviceusage.serviceUsageConsumer"
  
#Assign Group Reader to service account.
#https://knowledge.workspace.google.com/admin/users/assign-specific-admin-roles#service-account 
#include upn: [svc-account]@[project-id].iam.gserviceaccount.com

#Impersonate service account
#gcloud auth application-default login --impersonate-service-account=<svc_account>@<project-id>.iam.gserviceaccount.com
  
# --- Configuration ---
PROJECT_ID=""
GROUP_KEY="" #group-name@suffix
# Only fetch the token if not already set
if [ -z "$TOKEN" ]; then
    echo "Fetching auth token..."
    TOKEN=$(gcloud auth application-default print-access-token)
fi

curl -X GET "https://cloudidentity.googleapis.com/v1/groups:lookup?groupKey.id=$GROUP_KEY" \
  -H "Authorization: Bearer $TOKEN" \
  -H "x-goog-user-project: $PROJECT_ID" \
  -H "Content-Type: application/json" 
