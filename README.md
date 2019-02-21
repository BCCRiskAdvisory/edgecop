# EDGECOP

To use this rubocop config in a project create a .rubocop.yml file in the base directory with:

```yml
inherit_from: https://raw.githubusercontent.com/BCCRiskAdvisory/edgecop/master/edgecop.yml
```

To ensure the cached rubcop file will be ignored to the .gitignore file add

```
/.rubocop-https*
```
