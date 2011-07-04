source ~/.profile
alias ls='ls -G'
export PATH=$PATH:$HOME/dev/chromium/third_party/WebKit/Tools/Scripts/:$HOME/dev/bin:$HOME/dev/bin/d:$HOME/bin
export PATH=$PATH:$HOME/dev/gyp-read-only

source ~/dev/dotfiles/chrome-shortcuts.sh
source ~/dev/dotfiles/git-shortcuts.sh
source ~/dev/tasks/shortcuts.sh

export EDITOR=vi

export PATH=$PATH:/Users/jameskozianski/dev/xcodebuild-parser
alias be='xparse.rb build-chrome.output'
alias te='xparse.rb build-tests.output'

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Setting PATH for MacPython 2.5
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH

alias lint-expectations='python webkit/tools/layout_tests/run_webkit_tests.py --lint'
