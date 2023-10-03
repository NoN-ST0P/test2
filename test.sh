OWNER="NoN-ST0P"
REPO="test2"
BRANCH="teeest"
API_URL="https://api.github.com/repos/$OWNER/$REPO/branches/$BRANCH"
LAST_COMMIT_FILE=".last_commit"
if [ -f "$LAST_COMMIT_FILE" ]; then
    LAST_COMMIT=$(cat "$LAST_COMMIT_FILE")
else
    LAST_COMMIT=""
fi

# Retrieve the latest commit information for the branch

LATEST_COMMIT=$(curl -s "$API_URL" | jq -r '.commit.sha')

# Compare the latest commit SHA with the stored value
if [ "$LATEST_COMMIT" != "$LAST_COMMIT" ]; then
    echo "Changes detected in the repository!"

    # Execute the necessary commands to restart the service
    # Replace this line with your own restart command
    echo "Restarting the service..."
    # your_restart_command_here

    # Update the last commit SHA in the file
    echo "$LATEST_COMMIT" > "$LAST_COMMIT_FILE"
else
    echo "No changes in the repository."
fi
