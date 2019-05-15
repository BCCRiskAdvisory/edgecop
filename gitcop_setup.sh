#! /usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

function version_gt() { test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"; }

echo "=============== Checking for git cop"

if $(gem list git-cop -i) ;
then
  echo "Git cop already installed"
else
  echo "Installing git cop..."
  gem install git-cop
fi


echo "=============== Checking git version"
GIT_VERSION=$(git --version | sed 's/[[:alpha:]|(|[:space:]]//g')
if version_gt 2.10.0 $GIT_VERSION ; then
  echo "You have ${GIT_VERSION} installed, but this script requires version 2.9 or higher! Please update your git version and rerun this script."
  exit 1
else
  echo "Git version ok"
fi


echo "=============== Checking git hooks configuration"
if git config --global core.hooksPath ; then
  if [ $(git config --global core.hooksPath) == "~/.config/git-hooks" ]; then
    echo "Git global hooks already configured correctly"
  else
    echo "Git global hooks have an unexpected configuration"
    echo "You might need to modify your commit hooks manually"
  fi
else
  echo "Configuring git global hooks to point to ~/.config/git-hooks"
  git config --global core.hooksPath "~/.config/git-hooks"
  echo 
fi

echo "=============== Fetching git-cop configuration"
mkdir -p ~/.config/git-cop/hooks
curl --silent https://raw.githubusercontent.com/BCCRiskAdvisory/edgecop/master/gitcop.yml > ~/.config/git-cop/configuration.yml

echo "=============== Fetching hook scripts"
mkdir -p ~/.config/git-hooks
curl --silent https://raw.githubusercontent.com/BCCRiskAdvisory/edgecop/master/hooks/commit-msg.sh > ~/.config/git-hooks/commit-msg
chmod a+x ~/.config/git-hooks/commit-msg







