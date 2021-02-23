#!/usr/bin/env bash
set -ex
rm -rf semverbuild
mkdir semverbuild
cd semverbuild
eval $(../src/localn.sh init)
../src/localn.sh 12.0.0
../src/localn.sh module semver
../src/localn.sh module pkg
pkg .localn/node-*/lib/node_modules/semver/
mv semver-linux ../semver
cd ..
rm -rf semverbuild
