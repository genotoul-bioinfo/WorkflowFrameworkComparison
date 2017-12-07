# Nextflow 

## Installation steps :

`curl -s https://get.nextflow.io | bash`

Install dans le repertoire courant. On peut ensuite le déplacer à sa guise (mais peut nécessiter des droits sudo par la suite si on met par exemple dans /usr/local/bin)

## TEST

	`nextflow run hello`

## QUICK START

https://www.nextflow.io/docs/latest/getstarted.html#your-first-script

nextflow run NextFlowFile.sh
	-> execute le workflow

nextflow run NextFlowFile.sh -resume
	-> ne rejoue que l'essentiel (utilise Cache)


nextflow run NextFlowFile.sh -trace
	-> liste les operations (pas les lignes de commande): on voit la conso CPU




## Issues :

fromFilePairs ne fonctionnent qu'en path relatif (mais pas sur...)

publishDir: il faut specifier le output sinon il copie rien

On ne peut utiliser une Channel en input qu'une fois.
UC: cutadapt sort une channel de fichiers clean_*
Si on veut lancer en // 2 STAR ou 1 STAR et un GLINT sur ces fichiers, il faut dupliquer la channel en sortie de cutadapt

	output:
	set pair_id, 'clean_*' into clean_files,clean_files2

mode flatten == iterateur

L'ordre des process dans le fichier nextflow n'a pas d'importance, les in/out determinent l'ordre d'execution
