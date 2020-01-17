#!/bin/bash

# renames proofs parameters to mapped CIDs from paramaters.json file
# uploads renamed files to jdcloud object store
# this creates a "fake" IPFS gateway in China

set -e
VERSION="${1:-"v20"}"
PARAMETERS_JSON="${2:-"parameters.json"}"
PROOFS_DIR="${3:-"/var/tmp/filecoin-proof-parameters"}"
manifest="$(cat "${PARAMETERS_JSON}")"
cd "${PROOFS_DIR}"
for proof in $(ls ${VERSION}*); do
  cid="$(jq --arg filename "$proof" -r '.[$filename].cid' <<< $manifest)"
  if [ ! -z "$cid" ] && [ "$cid" != "null" ]; then
    echo "mv $proof $cid"
    cids="$cid $cids"
  fi
done
for c in $cids; do
  echo "aws s3 cp $c s3://proof-parameters/ipfs/$c"
done
