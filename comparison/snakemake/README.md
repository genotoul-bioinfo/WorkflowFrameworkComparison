# Snakemake

## Installation steps :

```
virtualenv -p python3 env
source env/bin/activate
pip3 install snakemake
```

## Remarques :
Easy installation

## Example: cufflinks:
Semble fonctionner, mais on peut lancer que le "dry run": les fichiers input fournis sont vides

## Issues :

python3 doit être associé à une version de python > 3.5

sous genotoul le 29/11
```
virtualenv -p /usr/local/bioinfo/src/python/Python-3.6.1/bin/python3.6 env
```

Lignes de commande compliquées pour soumettre sur le cluster (pas très user friendly) - besoin d'un wrapper
si on veut que ça soit utilisé par des "novices"

## Fin Jour 1
Workflow terminé. Soumission cluster (DRMAA) fonctionelle.
