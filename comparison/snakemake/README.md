# Snakemake

## Installation steps :

```
virtualenv -p python3 env
source env/bin/activate
pip3 install snakemake
```

### Remarques :

Easy installation

### Example: cufflinks:

Semble fonctionner, mais on peut lancer que le "dry run": les fichiers input fournis sont vides

## Issues :

python3 doit être associé à une version de python > 3.5

sous genotoul le 29/11
```
virtualenv -p /usr/local/bioinfo/src/python/Python-3.6.1/bin/python3.6 env
```

Lignes de commande compliquées pour soumettre sur le cluster (pas très user friendly) - besoin d'un wrapper
si on veut que ça soit utilisé par des "novices"

## Maria's Note

- rule Fastqc :
  
  1) snakemake créé les dossiers s'ils n'existent pas. Donc pour fastqc pas la peine de créer le dossier explicitement avant
  2) obligation de préciser les fichiers de sortie
		
- rule Cutadapt:

  3) par défaut snakemake va remplace {input} de la partie run/shell par la concaténation des inputs en les séparant par un espace. On peut aussi nommer les inputs et utiliser {input.name} dans la commande. Idem output
  4) on peut définir des fichiers comme étant temporaires. Ils seront supprimés dès qu'ils ne servernt plus d'input à une autre règle
	
- rule STAR_mmapping:

  5) on peut définir un wildcards dans input et ouput. Pour l'utiliser dans shell alors il faut utiliser la syntaxe {wildcards.WILDCARDNAME}
  6) pour écrire plusieurs lignes de commande shell : utiliser les triples double quote
  7) on peut définir des priorités d'excecutions. Utile pour controler qui s'exécute avant qui et donc cumuler avec des options temp(), quels fichiers peut être supprimés pour gagner de la place

- possibilité d'utiliser des données complexe :
```
samples:
    - name: sample
      read_1: data/reads/sample.fq.gz
    - name: sample_CD4
      read_1: data/reads/sample_CD4_R1.fastq.gz
      read_2: data/reads/sample_CD4_R2.fastq.
```
Mais ensuite ce n'est pas très claire, de comment les utiliser dans le Snakefile. Floreal a proposé une solution. J'aimerais pouvoir parser directement dans la ligne input des règles. Dans tous les cas je n'ai pas trouvé de doc qui permettent de formaliser ce cas.

## Fin Jour 1
Workflow terminé. Soumission cluster (DRMAA) fonctionelle.


