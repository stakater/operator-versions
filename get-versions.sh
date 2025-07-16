#!/usr/bin/env bash
#
# Script to run on an OpenShift cluster to get all versions of operators for that OpenShift version

set -euo pipefail

# Get the name of all operators in the Red Hat catalog
ALL_RH_OPERATORS=$(oc get packagemanifests | grep 'Red Hat Operators' | awk '{print $1}')

# For each operator, get all available versions for the OpenShift cluster on the current version
# Create a JSON document that conforms to the format of Renovate datasources
counter=0
while IFS= read -r op; do
  counter=$((counter+1))
  # Prefix all versions with "v"
  oc get packagemanifests -o json "$op" | \
    jq -r '.status.channels[]' | \
    jq '{version: ("v" + .currentCSVDesc.version)}' | \
    jq -n '.releases |= [inputs]' > "$op.json"

  if [ "$counter" -eq 3 ]; then
    echo "END TEST"
    break
  fi
done <<<"$ALL_RH_OPERATORS"
