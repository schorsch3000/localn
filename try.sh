#!/usr/bin/env bash
set -e
echo running some real world tests...

fail(){
    echo -e "\n\n\n\n"
    echo "$@"
    exit 1
}
localn && fail "it shouldn\t run before init" || true

$(/bin/localn init)

localn || fail "it should run after init"

which node && fail "node shouln't be availible before installing" || true

localn 4.0.0 || fail "it should install node version 4.0.0"

which node || fail "node should be installed by now"

node -v | fgrep -q 4.0.0 || fail "node 4.0.0 should be installed by now"

which npm || fail "npm should be installed by now"

npm -v
npm -v | fgrep -q 2.14.2 || fail "npm 2.14.2 should be installed by now"


rm -rf .localn
localn lts
which node || fail "node lts should be installed by now"
which node || fail "npm bundled by node lts should be installed by now"

rm -rf .localn
localn stable
which node || fail "node stable should be installed by now"
which node || fail "npm bundled by node stable should be installed by now"

rm -rf .localn
localn latest
which node || fail "node latest should be installed by now"
which node || fail "npm bundled by node latest should be installed by now"

which npm-cache && fail "modules should not be installed by default"  || true

localn module npm-cache || fail "modules should be installable"
npm-cache -v || fail "installed module should have it't bin's exposed"


test -d /tmp/cachedir && fail "cachedir should not be there initially" || true
localn cachedir /tmp/cachedir || fail "setting cachedir should not fail"
localn stable || fail "node should be installable with set cachedir"
test -d /tmp/cachedir || fail "cachedir should be after cached install"
test -f /tmp/cachedir/node-v6.4.0-*-*.tar.gz || fail "cached file should be in cachedir"




