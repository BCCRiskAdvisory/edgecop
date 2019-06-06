# EDGECOP

## Rubocop

To use the rubocop config in a project create a .rubocop.yml file in the base directory with:

```yml
inherit_from: https://raw.githubusercontent.com/BCCRiskAdvisory/edgecop/master/edgecop.yml
```

This file contains configuration for two optional gems - `rubocop-performance` and `rubocop-rails`. If these don't apply to your project you can inherit only the parts you want. The below would be suitable for a plain ruby project:

```yml
inherit_from: 
  - https://raw.githubusercontent.com/BCCRiskAdvisory/edgecop/master/edgecop-core.yml
  - https://raw.githubusercontent.com/BCCRiskAdvisory/edgecop/master/edgecop-performance.yml
```

To ensure the cached rubocop file will be ignored to the .gitignore file add

```
/.rubocop-https*
```

## Gitcop

This repo provides a setup script for gitcop. Copy the following command into your terminal:

```
curl https://raw.githubusercontent.com/BCCRiskAdvisory/edgecop/master/gitcop_setup.sh | bash -s
```
