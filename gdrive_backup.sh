#!/usr/bin/env bash

set -euo pipefail

DATE_FOR_NAME=$(date '+%Y-%m-%d')

G_CLIENT_ID='G_CLIENT_ID'
G_CLIENT_SECRET='G_CLIENT_SECRET'

# Copy and paste this in browser for get authorization code
BROWSER_URL="https://accounts.google.com/o/oauth2/v2/auth?client_id=${G_CLIENT_ID}&access_type=offline&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=https://www.googleapis.com/auth/drive.file&response_type=code"
AUTHORIZATION_CODE="AUTHORIZATION_CODE"

#ACCESS_TOKEN_RESPONSE=$(curl -s --request POST --data "code=${AUTHORIZATION_CODE}&client_id=${G_CLIENT_ID}&client_secret=${G_CLIENT_SECRET}&redirect_uri=urn:ietf:wg:oauth:2.0:oob&grant_type=authorization_code" https://oauth2.googleapis.com/token | /usr/bin/jq --raw-output '.')
REFRESH_TOKEN="REFRESH_TOKEN"

# if [[ -z "${ACCESS_TOKEN}" || "${ACCESS_TOKEN}" == "null" ]]; then
ACCESS_TOKEN_RESPONSE=$(curl -s --request POST --data "client_id=${G_CLIENT_ID}&client_secret=${G_CLIENT_SECRET}&refresh_token=${REFRESH_TOKEN}&grant_type=refresh_token" https://oauth2.googleapis.com/token | /usr/bin/jq --raw-output '.')
ACCESS_TOKEN=$(echo $ACCESS_TOKEN_RESPONSE | jq .access_token)
# fi

curl -s -X POST -L \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -F "metadata={name : '${DUMP_NAME}'};type=application/json;charset=UTF-8" \
    -F "file=@${DUMP_NAME};type=application/gzip" \
    "https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart"
