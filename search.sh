#!/bin/bash

# Ensure the CSV file exists
CSV_FILE="data.csv"
if [[ ! -f "$CSV_FILE" ]]; then
  echo "Error: $CSV_FILE not found."
  exit 1
fi

# Strip the header and use fzf to search Titles
# Then extract the matching site value

# Use awk to skip the header, then present Titles via fzf
selected_title=$(awk -F',' 'NR > 1 { print $1 }' "$CSV_FILE" | fzf --prompt="Search Title: ")

# Exit if nothing selected
if [[ -z "$selected_title" ]]; then
  echo "No title selected."
  exit 1
fi

# Find the matching line and extract the site field
site=$(awk -F',' -v title="$selected_title" 'NR > 1 && $1 == title { print $2 }' "$CSV_FILE")

# Show the result
if [[ -n "$site" ]]; then
  echo "Site for '$selected_title': $site"
else
  echo "Site not found for: $selected_title"
fi

