export C=$HOME/dev/chromium$1/src
export WK=$C/third_party/WebKit

export PS1="\h:\W \u\$ "
if [ ! -z $1 ] ; then
  PS1="[c$1] "$PS1
fi

function c {
    cd $C
}

function wk {
    cd $WK
}

function s {
  cd $WK/Tools/Scripts
}

function sy {
  s
  cd webkitpy
}

alias pc='prepare-ChangeLog --merge-base `mh`'

function fix-python-path {
  export PYTHONPATH=$PYTHONPATH:$C/third_party/WebKit/Tools/Scripts
}

function build-chrome {
  (
    c
    cd chrome
    xcodebuild -project chrome.xcodeproj -configuration Debug -target chrome 2>&1 | tee ~/.last-build-output
    return ${PIPESTATUS[0]}
  )
}

function build-chrome-tests {
  (
    c
    cd chrome
    xcodebuild -project chrome.xcodeproj -configuration Debug -target unit_tests
  )
}

function build-chrome-browsertests {
  (
    c
    cd chrome
    xcodebuild -project chrome.xcodeproj -configuration Debug -target browser_tests 2>&1 | tee ~/.last-build-output
    return ${PIPESTATUS[0]}
  )
}

function run-rph-browsertests {
  xcodebuild/Debug/browser_tests --gtest_filter='RegisterProtocolHandlerBrowserTest.*'
}

function run-cm-browsertest {
  xcodebuild/Debug/browser_tests --gtest_filter='RegisterProtocolHandlerBrowserTest.*'
}

function run-browsertests {
  xcodebuild/Debug/browser_tests
}

function build-chrome-unittests {
  c
  cd chrome
  xcodebuild -project chrome.xcodeproj -configuration Debug -target unit_tests
}

alias run-chrome-unittests='$C/xcodebuild/Debug/unit_tests'

function build-chrome-all {
  c
  cd build
  xcodebuild -project all.xcodeproj -configuration Debug -target All
}

# update-webkit needs up to date git-svn info, so the git svn rebase is necessary.
function kalman-git-up {
    git pull && git svn rebase
    update-webkit --chromium
}

function rph-defined {
  F=$C/xcodebuild/DerivedSources/Debug/webcore/bindings/V8Navigator.cpp
  if [ -e $F ] ; then
    if grep registerProtocolHandler $F ; then
      echo 'Defined'
    else
      echo 'Not defined'
    fi
  else
    echo "File doesn't exist"
  fi
}

function build-chromium-layouttests {
  wk
  xcodebuild -project Source/WebKit/chromium/WebKit.xcodeproj -target DumpRenderTree
}

function run-chromium-layouttests {
  new-run-webkit-tests --chromium --results-directory=results $@
}

function brct {
  build-chromium-layouttests
  run-chromium-layouttests $@
}

function ison {
    Source/JavaScriptCore/JavaScriptCore.gyp/JavaScriptCore.xcodeproj/project.pbxproj
    Source/WebCore/WebCore.gyp/WebCore.xcodeproj/project.pbxproj
    grep "$1=1" $WK
}

alias DEPS='grep webkit_revision $C/DEPS | head -n 1'

alias WKDEPS='git --git-dir=$WK/.git log | grep 'git-svn-id:' | head -n 1'

alias DD='DEPS ; WKDEPS'

