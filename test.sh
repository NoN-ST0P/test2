#!/bin/bash

# Need to create a chrone job in linux to schedule a check for any Github update 
# 0 * * * * /root/snap/test.sh >> /root/snap/Checklog.txt 2>&1
# This will check in minute 00 every houre for a new update
OWNER="NoN-ST0P"
REPO="test2"
BRANCH="teeest"
#Check for Branch last commit version
LAST_COMMIT_FILE="x.last_commit"
if [ -f "$LAST_COMMIT_FILE" ]; then
    LAST_COMMIT=$(cat "$LAST_COMMIT_FILE")
else
    LAST_COMMIT=""
fi

# Retrieve the latest commit information for the branch
API_URL="https://api.github.com/repos/$OWNER/$REPO/branches/$BRANCH"
LATEST_COMMIT=$(curl -s "$API_URL" | jq -r '.commit.sha')

# Compare the latest commit SHA with the stored value
if [ "$LATEST_COMMIT" != "$LAST_COMMIT" ]; then
    echo "Changes detected in the repository!"

    # Get files from Github Command
    echo "Downloading new files..."
        # Git Command #
        
    # Restarting the service
    echo "Restarting the service..."
        # Restart Command #

    # Update the last commit SHA in the file
    echo "$LATEST_COMMIT" > "$LAST_COMMIT_FILE"
else
    echo "No changes in the repository."
fi
