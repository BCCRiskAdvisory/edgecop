#! /usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail
IFS=$'\n\t'

if ! command -v git-cop > /dev/null; then
   printf "%s\n" "[git]: Git Cop not found. To install, run: gem install git-cop."
   exit 1
fi

curl --silent https://raw.githubusercontent.com/BCCRiskAdvisory/edgecop/main/gitcop.yml > ~/.config/git-cop/configuration.yml

git-cop --hook --commit-message "${BASH_ARGV[0]}"
