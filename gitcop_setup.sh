#! /usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

if $(gem list git-cop -i) ;
then
  echo "=============== Git cop already installed"
else
  echo "=============== Installing git cop..."
  gem install git-cop
fi


echo "=============== Fetching git-cop configuration..."
mkdir -p ~/.config/git-cop/hooks
curl https://raw.githubusercontent.com/BCCRiskAdvisory/edgecop/master/gitcop.yml > ~/.config/git-cop/configuration.yml


echo "=============== Fetching hook scripts"
mkdir -p ~/.config/git-hooks
curl https://raw.githubusercontent.com/BCCRiskAdvisory/edgecop/master/hooks/commit-msg.sh > ~/.config/git-hooks/commit-msg.sh


if $(grep -q "\[core\]" ~/.gitconfig) && $(grep -q "hooksPath" ~/.gitconfig) ;
then
  echo "=============== It looks like you already have a hooksPath configured in ~/.gitconfig

This script won't change your existing config, but it's expecting ~/.gitconfig to contain the following:

[core]
  hooksPath = ~/.config/git-hooks
"
else
  echo "configuring global hooks for git"
  echo "[core]
  hooksPath = ~/.config/git-hooks" >> ~/.gitconfig
fi




