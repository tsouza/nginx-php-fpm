#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

VERSION=$1
mkdir -p ${VERSION}
sed "s/<placeholder>/${VERSION}/g" Dockerfile.template > ${VERSION}/Dockerfile
cp nginx.conf supervisord.conf ${VERSION}/
