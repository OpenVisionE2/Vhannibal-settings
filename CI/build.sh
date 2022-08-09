#!/bin/sh

# Script by Persian Prince for https://github.com/OpenVisionE2
# You're not allowed to remove my copyright or reuse this script without putting this header.

git clone --depth 1 https://github.com/oe-alliance/oe-alliance-settings.git
rm -rf oe-alliance-settings/*liktra*
rm -rf oe-alliance-settings/*malimali*
rm -rf oe-alliance-settings/README.md
cp -rp oe-alliance-settings/* .
rm -rf oe-alliance-settings

find . -name '*satellites.xml*' -type f | xargs rm -f

setup_git() {
  git config --global user.email "bot@openvision.tech"
  git config --global user.name "Open Vision settings bot"
}

commit_files() {
  git checkout master
  git add -u
  git add *
  git commit --message "Fetch latest Vhannibal settings."
  ./CI/chmod.sh
  ./CI/dos2unix.sh
}

upload_files() {
  git remote add upstream https://${GITHUB_TOKEN}@github.com/OpenVisionE2/Vhannibal-settings.git > /dev/null 2>&1
  git push --quiet upstream master || echo "failed to push with error $?"
}

setup_git
commit_files
upload_files
