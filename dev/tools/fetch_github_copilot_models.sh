#!/bin/sh

# Check if the config file exists
CONFIG_FILE=~/.config/github-copilot/apps.json
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: GitHub Copilot configuration file not found at $CONFIG_FILE"
  echo "Please make sure GitHub Copilot is properly installed and configured."
  echo "You might need to open VS Code, log into GitHub Copilot, and try again."
  exit 1
fi

# Attempt to read the oauth_token from the first entry in app.json
COPILOT_TOKEN=$(jq -r 'first(.[].oauth_token)' "$CONFIG_FILE" 2>/dev/null)

if [ -z "$COPILOT_TOKEN" ] || [ "$COPILOT_TOKEN" = "null" ]; then
  echo "Failed to read oauth_token from $CONFIG_FILE"
  echo "Please ensure you're properly logged in to GitHub Copilot in your editor."
  exit 1
fi

curl -s https://api.githubcopilot.com/models \
  -H "Authorization: Bearer $COPILOT_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Copilot-Integration-Id: vscode-chat" | jq -r '.data[].id'
