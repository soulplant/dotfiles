source ~/.profile
alias ls='ls -G'
export PATH=$PATH:$HOME/dev/chromium/third_party/WebKit/Tools/Scripts/:$HOME/dev/bin:$HOME/dev/bin/d:$HOME/bin
export C=$HOME/dev/chromium/src
export WK=$C/third_party/WebKit

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

source git-shortcuts.sh


alias pc='prepare-ChangeLog --merge-base `mh`'
function wkg {
  grep -R "$1" $WK/Source/* $2 $3 $4 $5
}

function fix-python-path {
  export PYTHONPATH=$PYTHONPATH:$HOME/dev/chromium/src/third_party/WebKit/Tools/Scripts
}

function build-chrome {
  c
  cd chrome
  xcodebuild -project chrome.xcodeproj -configuration Debug -target chrome
}

function build-chrome-tests {
  c
  cd chrome
  xcodebuild -project chrome.xcodeproj -configuration Debug -target unit_tests
}

function build-chrome-unittests {
  c
  cd chrome
  xcodebuild -project chrome.xcodeproj -configuration Debug -target unit_tests
}

function run-chrome-unittests {
    c
    xcodebuild/Debug/unit_tests
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
