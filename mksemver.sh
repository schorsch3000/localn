#!/usr/bin/env bash
rm -rf semverbuild
mkdir semverbuild
cd semverbuild
$(../src/localn.sh init)
../src/localn.sh stable
../src/localn.sh module semver
../src/localn.sh module pkg
pkg .localn/node-*/lib/node_modules/semver/
mv semver-linux ../semver
cd ..
rm -rf semverbuild
