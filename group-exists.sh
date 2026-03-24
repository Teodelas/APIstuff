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
