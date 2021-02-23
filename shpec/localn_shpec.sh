#!/usr/bin/env bash

cd /tmp

describe "localn"
    it "should fail if called uninitialized"
        localn stable &>/dev/null
        assert unequal "$?"  "0"
    end

    it "should init"
        eval $(/bin/localn init)
        assert grep ":$PATH" ":$PWD/.localn/bin"
    end

    it "shouldn't expose node before downloading"
        node -v &>/dev/null
        assert unequal "$?" "0"
    end

    it "should download a specific version of node..."
        eval $(/bin/localn init)
        localn 4.0.0 &>/dev/null
        assert equal "$(node -v)" "v4.0.0"
        it "... and npm"
            npm -v &>/dev/null
            assert equal "$?" "0"
        end
        rm -rf .localn
    end

    it "should download the latest version of node"
        localn latest &>/dev/null
        node -v &>/dev/null
        assert equal "$?" "0"
        rm -rf .localn

    end

    it "should download the latest version of node in a given range"
        localn latest 4 &>/dev/null
        node -v &>/dev/null
        assert equal "$?" "0"
        assert equal "$(node -v)" "v4.9.1"
        rm -rf .localn


        localn latest 4.8 &>/dev/null
        node -v &>/dev/null
        assert equal "$?" "0"
        assert equal "$(node -v)" "v4.8.7"
        rm -rf .localn
    end

    it "should download the latest stable version of node"
        localn stable &>/dev/null
        node -v &>/dev/null
        assert equal "$?" "0"
        rm -rf .localn

    end

    it "should install yarn without using npm"
        localn stable &>/dev/null
        stub_command npm
        yarn --help &>/dev/null
        assert equal "$?" "127" # check yarn is not present
        localn module yarn &>/dev/null
        yarn --help &>/dev/null
        assert equal "$?" "0"
    end

    it "should install node according to the package.json"
        echo '{"engines":{"node":">7 <9.0.0"}}' > package.json
        localn install
        semver -r ">7 <9.0.0" $(node -v)
        assert equal "$?" "0"
        echo '{"engines":{"node":">0.10 <0.12"}}' > package.json
        localn install
        semver -r ">0.10 <0.12" $(node -v)
        assert equal "$?" "0"
    end


end
