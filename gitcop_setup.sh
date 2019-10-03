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


echo "=============== Checking git hook templates configuration"
if git config --global init.templatedir ; then
  echo "Git hook templates already configured"
  TEMPLATE_DIR=$(git config --global init.templatedir)
else
  echo "Configuring git hook templates to point to ~/.git-templates"

  TEMPLATE_DIR="~/.git-templates"
  git config --global init.templatedir "$TEMPLATE_DIR"
fi

echo "=============== Fetching git-cop configuration"
mkdir -p ~/.config/git-cop/hooks
curl --silent https://raw.githubusercontent.com/BCCRiskAdvisory/edgecop/master/gitcop.yml > ~/.config/git-cop/configuration.yml

echo "=============== Fetching hook scripts"
mkdir -p $TEMPLATE_DIR/hooks
curl --silent https://raw.githubusercontent.com/BCCRiskAdvisory/edgecop/master/hooks/commit-msg.sh > $TEMPLATE_DIR/hooks/commit-msg
chmod a+x $TEMPLATE_DIR/hooks/commit-msg
