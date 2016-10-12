#!/usr/bin/env bash

cd /tmp

describe "localn"
    it "should fail if called uninitialized"
        localn stable >/dev/null
        assert unequal "$?"  "0"
    end

    it "should init"
        $(/bin/localn init)
        assert match ":$PATH" ":$PWD/.localn/bin"
    end

    it "shouldn't expose node before downloading"
        node -v
        assert unequal "$?" "0"
    end

    it "should download a specific version of node..."
        $(/bin/localn init)
        localn 4.0.0
        assert equal "$(node -v)" "v4.0.0"
        it "... and npm"
            npm -v &>/dev/null
            assert equal "$?" "0"
        end
        rm -rf .localn
    end

    it "should download a lts version of node"
        $(/bin/localn init)
        localn lts &>/dev/null
        assert test "$(node -v | egrep -q ^v[0-9]+\\.[0-9]+[02468]+\\.)"
        rm -rf .localn

    end

    it "should download the latest version of node"
        $(/bin/localn init)
        localn latest &>/dev/null
        node -v &>/dev/null
        assert equal "$?" "0"
        rm -rf .localn

    end

    it "should download the latest stable version of node"
        $(/bin/localn init)
        localn stable &>/dev/null
        node -v &>/dev/null
        assert equal "$?" "0"
        rm -rf .localn

    end


end
