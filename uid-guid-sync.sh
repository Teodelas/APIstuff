# --- Configuration ---
PROJECT_ID=""
# Ensure these variables are set before running
# USER_EMAIL="user@example.com"
# NEW_USERNAME="jdoe"
# NEW_UID="1001"
# NEW_GID="1001"

# --- Authentication ---
# Only fetch the token if not already set (optional optimization)
if [ -z "$TOKEN" ]; then
    echo "Fetching auth token..."
    TOKEN=$(gcloud auth application-default print-access-token)
fi

# --- Construct JSON Payload ---
# Using a Here-Doc variable avoids messy \" escape characters
JSON_PAYLOAD=$(cat <<EOF
{
  "posixAccounts": [
    {
      "username": "$NEW_USERNAME",
      "uid": "$NEW_UID",
      "gid": "$NEW_GID",
      "homeDirectory": "/home/$NEW_USERNAME",
      "shell": "/bin/bash",
      "operatingSystemType": "LINUX"
    }
  ]
}
EOF
)

# --- Execute Request ---
curl -X PATCH "https://admin.googleapis.com/admin/directory/v1/users/$USER_EMAIL" \
  -H "Authorization: Bearer $TOKEN" \
  -H "x-goog-user-project: $PROJECT_ID" \
  -H "Content-Type: application/json" \
  -d "$JSON_PAYLOAD"
