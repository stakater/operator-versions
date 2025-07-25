#!/bin/bash
#
# Script to run on an OpenShift cluster to get all versions of operators

set -euo pipefail

usage () {
  echo "script syntax:    -v       specify the OpenShift version, otherwise it will be fetched from the cluster
                  -t       do a test run with one operator
                  -h       this help text";
}

options=':v:th'
while getopts $options option
do
    case $option in
        v  ) VERSION=$OPTARG;;
        t  ) TESTING='true';;
        h  ) usage; exit;;
        \? ) echo "ERROR: Unknown option: -$OPTARG" >&2; exit 1;;
        :  ) echo "ERROR: Missing argument value for -$OPTARG" >&2; exit 1;;
    esac
done

shift $((OPTIND - 1))

TESTING=${TESTING:-'false'}
OS_VERSION=$(oc get clusterversion -o json | jq -r '.items[].spec.channel')
VERSION=${VERSION:-$OS_VERSION}

# Put all files in a folder corresponding to the OpenShift cluster version
if ! "$TESTING"; then
  mkdir -p "$VERSION"
fi

# Get the name of all operators in all catalogs
# Skip the first line with the header
ALL_OPERATORS=$(oc get packagemanifests | awk '{print $1}' | tail -n +2)

# For each operator, get all available versions for the OpenShift cluster on the current version
# Create a JSON document that conforms to the format of Renovate custom datasources
while IFS= read -r op; do
  # Prefix all versions with "v"
  RESULT=$(oc get packagemanifests -o json "$op" | \
    jq -r '.status.channels[]' | \
    jq '{version: ("v" + .currentCSVDesc.version)}' | \
    jq -n '.releases |= [inputs]')

  if "$TESTING"; then
    echo "$VERSION/$op.json"
    echo "$RESULT"
    break
  else
    echo "$RESULT" > "$VERSION/$op.json"
  fi
done <<<"$ALL_OPERATORS"
