function build() {
  # ./clean-build.sh
  # ./build.sh
  true
}

function sync-and-build() {
  wk
  git fetch
  git checkout master
  git merge origin/master
  echo pulled wk
  git checkout DEPS
  c
  git checkout trunk
  git pull
  echo pulled chrome
  git checkout $1
  git rebase trunk
  echo 'rebased onto trunk'
  gclient sync --force --jobs=32
  gclient runhooks
  echo synced chrome
  c
  tools/sync-webkit-git.py
  echo sync-webkit-git.py
  build
}

echo "Start: `date`" >> versions-tried
while ! sync-and-build ; do
  DEPS >> versions-tried
  echo 'retrying'
done

echo -n 'finished with' >> versions-tried
DEPS >> versions-tried

if [ ! -z $1 ] ; then
  c
  git checkout $1
  if git rebase trunk ; then
    echo 'rebased succesfully' >> versions-tried
  else
    echo 'failed the rebase' >> versions-tried
    git rebase --abort
  fi
  build
fi
echo "End: `date`" >> versions-tried
