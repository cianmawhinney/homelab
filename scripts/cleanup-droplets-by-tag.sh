#!/bin/bash

show_help() {
  echo "Usage: $0 <tag>"
  echo ""
  echo "Deletes droplets from DigitalOcean based on the specified tag."
  echo ""
  echo "Parameters:"
  echo "  <tag>          The tag to filter droplets by."
  echo ""
  echo "Example:"
  echo "  $0 webservers"
  echo ""
  echo "Note: Requires 'doctl' to be installed and authenticated."
}

delete_droplets_by_tag() {
  if ! doctl auth whoami &>/dev/null; then
    echo "Not authenticated. Run 'doctl auth init'."
    exit 1
  fi

  TAG=$1
  if [ -z "$TAG" ]; then
    read -p "Enter the tag to filter droplets by: " TAG
  fi

  DROPLETS=$(doctl compute droplet list --tag-name "$TAG" --format ID,Name --no-header)

  if [ -z "$DROPLETS" ]; then
    echo "No droplets found with the tag '$TAG'."
    exit 0
  fi

  echo "Droplets to be deleted:"
  echo "$DROPLETS"

  read -p "Are you sure you want to delete these droplets? (y/n): " CONFIRM

  if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    DROPLET_IDS=$(echo "$DROPLETS" | awk '{print $1}')
    doctl compute droplet delete $DROPLET_IDS --force
    echo "Droplets deleted."
  else
    echo "Operation cancelled."
  fi
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help
  exit 0
fi

delete_droplets_by_tag "$1"
