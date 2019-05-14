# EDGECOP

## Rubocop

To use the rubocop config in a project create a .rubocop.yml file in the base directory with:

```yml
inherit_from: https://raw.githubusercontent.com/BCCRiskAdvisory/edgecop/master/edgecop.yml
```

To ensure the cached rubcop file will be ignored to the .gitignore file add

```
/.rubocop-https*
```

## Gitcop

This repo provides a setup script for gitcop. Copy the following command into your terminal:

```
curl https://raw.githubusercontent.com/BCCRiskAdvisory/edgecop/master/gitcop_setup.sh | bash -s
```
