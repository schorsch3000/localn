#!/usr/bin/env bash
set -e
echo running some real world tests...

fail(){
    echo -e "\n\n\n\n"
    echo "$@"
}
localn && fail "it shouldn\t run before init" || true

$(/bin/localn init)

localn || fail "it should run after init"

which node && fail "node shouln't be availible befor installing" || true

localn 4.0.0 || fail "it should install node version 4.0.0"

which node || fail "node should be installed by now"

node -v | fgrep -q 4.0.0 || fail "node 4.0.0 should be installed by now"

which npm || fail "npm should be installed by now"

npm -v | fgrep -q 3.7.2 || fail "npm 3.7.2 should be installed by now"


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


