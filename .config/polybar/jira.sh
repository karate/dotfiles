#!/bin/sh

# This script uses the Jira REST API to get all open issues assigned to the
# next available version for each project.

# Requirements:
# - jq: json query tool, to parse the API response.
# - Gnome keyring: The Gnome password manager, to prevent storing passwords
# here (already installed if you use Gnome).
# - secret-tool: The Gnome keyring CLI interface (already installed if you use Gnome).

# Set-up:
# Use the Gnome keyring to store your Jira password, with:
# secret-tool store --label=Jira user $user domain "$jira_url"
# Make sure that the domain url is the exact same url that you set below as $jira_url

# Usage:
# ./jira.sh count
# ./jira.sh list

# Jira instance URL.
jira_url='https://jira.example.com';
# Jira User
user='foo';

# Query settings
assignee=$user;                               # Assigned to me
resolution='unresolved';                      # Unresolved issues
fix_version='earliestUnreleasedVersion()';    # Assigned for the next version
fields='key,summary';                         # Fetch only key and title
order="priority+desc,project+asc";            # Order by priority and poject

# Get number of issues
get_total_issues() {
  count=0;
  make_call | jq '.total';
}

# Get top 10 issues
get_issue_list() {
  count=10;
  make_call | jq '.issues[] | .key + ": " + .fields.summary[:60]';
}

make_call() {
  # get password from Gnome Keyring
  pass=$(secret-tool lookup user $user domain "$jira_url");

  # Make API call
  API_URL="$jira_url/rest/api/2/search?jql=assignee=$assignee+and+resolution=$resolution+and+fixVersion=$fix_version+order+by+$order&maxResults=$count&fields=$fields";
  curl --silent --user $user:$pass "$API_URL"
}

# Parse command line arguments
if [ -z "$1" ]; then
  echo "No action given. Please use either 'count' or 'list'";
  exit 1;
else
  action=$1;
fi;

if [ "$1" = "count" ]; then
  get_total_issues;
elif [ "$1" = "list" ]; then
  get_issue_list;
else
  echo "Unsupported action. Please use either 'count' or 'list'";
  exit 1;
fi;
