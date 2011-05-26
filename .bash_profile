source ~/.profile
alias ls='ls -G'
export PATH=$PATH:$HOME/dev/chromium/third_party/WebKit/Tools/Scripts/:$HOME/dev/bin:$HOME/dev/bin/d:$HOME/bin
export C=$HOME/dev/chromium/src
export C2=$HOME/dev/chromium2/src
export WK=$C/third_party/WebKit
export WK2=$C2/third_party/WebKit

function c {
    cd $C
}

function c2 {
    cd $C2
}

function wk {
    cd $WK
}

function wk2 {
    cd $WK2
}

function s {
  cd $WK/Tools/Scripts
}

function sy {
  s
  cd webkitpy
}

function wk2p {
  export PATH=$WK2/Tools/Scripts:$PATH
}

source ~/dev/dotfiles/git-shortcuts.sh


alias pc='prepare-ChangeLog --merge-base `mh`'
function wkg {
  grep -R "$1" $WK/Source/* $2 $3 $4 $5
}

function fix-python-path {
  export PYTHONPATH=$PYTHONPATH:$HOME/dev/chromium/src/third_party/WebKit/Tools/Scripts
}

function fix-python-path-2 {
  export PYTHONPATH=$PYTHONPATH:$HOME/dev/chromium2/src/third_party/WebKit/Tools/Scripts
}

function build-chrome {
  (
    c
    cd chrome
    xcodebuild -project chrome.xcodeproj -configuration Debug -target chrome 2>&1 | tee ~/.last-build-output
    return ${PIPESTATUS[0]}
  )
}

function build-chrome2 {
  (
    c2
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

function run-browsertests {
  xcodebuild/Debug/browser_tests
}

function build-chrome-unittests {
  c
  cd chrome
  xcodebuild -project chrome.xcodeproj -configuration Debug -target unit_tests
}

function run-chrome-unittests {
    c
    xcodebuild/Debug/unit_tests $@
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

export EDITOR=vi

function ison {
    Source/JavaScriptCore/JavaScriptCore.gyp/JavaScriptCore.xcodeproj/project.pbxproj
    Source/WebCore/WebCore.gyp/WebCore.xcodeproj/project.pbxproj
    grep "$1=1" $WK
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

function rph-defined-2 {
  F=$C2/xcodebuild/DerivedSources/Debug/webcore/bindings/V8Navigator.cpp
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

alias snippets="grep '^\(Mon\|===\)' ~/notes/day-to-day"
export PATH=$PATH:$HOME/dev/gyp-read-only
alias DEPS='grep webkit_revision $C/DEPS | head -n 1'

alias WKDEPS='git --git-dir=$WK/.git log | grep 'git-svn-id:' | head -n 1'

alias DD='DEPS ; WKDEPS'

source ~/dev/tasks/shortcuts.sh

export PATH=$PATH:/Users/jameskozianski/dev/xcodebuild-parser
alias be='xparse.rb build-chrome.output'
alias te='xparse.rb build-tests.output'
