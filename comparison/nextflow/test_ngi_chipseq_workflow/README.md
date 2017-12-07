# Retour d'experience sur l'utilisation d'un workflow de ChipSeq

Traitements réalisés hors du hackathon sur le cluster de calcul Genotoul (SGE)

Dans le cadre d'un projet de traitement, nous avons recherché des workflows existants:

 - [CCBR ChIP-Seq Pipeline](https://github.com/CCBR/ChIP-Seq-Pipeline)
 - [NGI-ChiPseq](https://github.com/SciLifeLab/NGI-ChIPseq)

##Installation 

N E X T F L O W  ~  version 0.25.7

```
module load bioinfo/Java8
mkdir nextflow
cd nextflow/
curl -s https://get.nextflow.io | bash
```
Edition de mon bashrc, ajout du chemin nextflow ds le path et le `module load java8`

Pour configurer l’utilisation par défaut du gestionnaire de workflow, 
il suffit de créer à la racine du repertoire d'exécution un fichier `nextflow.config` 
qui contient les paramètres suivant :
```
process.executor = 'sge'
process.queue = 'workq'
```
Test : Est ce que ca envoie bien sur le cluster ?
se positionner dans le work (car nextflow écrit depuis le cluster ds le répertoire courant) :
```
cd ~work
~/save/bin/nextflow/nextflow run hello
```

Lancement OK, mais lancé depuis le frontal, les adminsys ne souhaitent pas ce genre de pratique.
Soumission du job maître.

Pb : demande énormément de mémoire !
Un simple : ` qsub -b y -l mem=12G -l h_vmem=12G ~/save/bin/nextflow/nextflow run hello` se fait tuer car utiliser jusqu'a 22G de virtual mem !
```
qacct -j XXXX 
...
cpu          13.660       
mem          138.399           
io           0.176             
iow          0.000             
maxvmem      22.008G
```

## Workflow "CCBR ChIP-Seq Pipeline"
```
cd ~/save/bin/nextflow
mkdir workflows; cd workflows
git clone https://github.com/CCBR/ChIP-Seq-Pipeline.git
```

Ce workflow a été développé pour slurm, donc a modifier :
 - Fichier config ( paramètre sge, destinataire du mail)
```
profiles {
    standard {
    process {
      executor = 'sge'
      cpus = 4
      memory = '16 GB'
      penv = 'parallel_smp'
    }
}
```


 - Ou fichier main.nf dans chaque process définir penv (à éviter bien sûr):
```
process fastqc {
    module 'fastqc'

    cpus 4
    penv 'parallel_smp'
```

Lancement du workflow (en qsub)

```
nextflow run ~/save/bin/nextflow/workflows/ChIP-Seq-Pipeline/main.nf 
-config ~/save/bin/nextflow/workflows/ChIP-Seq-Pipeline/config 
--macsconfig='macs.config' 
--reads='/work/user/project/chipseq_public/raw/*.fastq'
```

Pb rencontrés :

 - Pour pouvoir le faire tourner, j’ai du donner 60G de ram !!! Sinon se fait killer ! 
Mémoire utilisée (qacct)
```
mem          4853.972          
io           205.327           
iow          0.000             
maxvmem      72.764G
```

 - Plantage sur picard tools variable à définir. Ajout dans le workflow main.nf ligne 166  de : (car picard 2.1.1 a besoin de java8)
`module load bioinfo/Java8`
Ajout dans le .bashrc de
`export PICARDJARPATH=/usr/local/bioinfo/src/picard-tools/picard-tools-2.1.1`


 - De nombreux 'module load' ne correspondait à rien chez nous mais cela ne pose pas de pb si le soft est dans le path.
 
 - Ligne 309 utilise des path du CEA
   `ceas = "ceas -g /fdb/CEAS/${params.genome}.refGene -b ${analysis_id}_peaks.narrowPeak -w ${analysis_id}_treat_pileup.bdg"`
   
Ne connaissant pas bien les outils utilisés , ne sachant pas à quoi correspond le module `ceas`, j'ai abandonné le test de ce pipeline.


## Workflow NGI-ChiPseq

Magique! Tout est paramétrable même les génomes. Il suffit de copier le fichier `conf/base.config`
Le modifier en fonction de la config locale. 

Éditer le fichier `nextflow.config` qui est à la racine.
Soit ajouter votre profil soit modifier les lignes suivantes pour pointer sur votre config
```
standard {
    includeConfig 'conf/base.config'
}
```
Lancement 
```
nextflow run ~/save/bin/nextflow/workflows/NGI-ChIPseq/main.nf --macsconfig='macs.config' --reads='/work/user/chipseq_public/raw/*.fastq'
```
_Remarques sur le comportement de nextflow :_
 - Si un job plante, tue tout ce qui était en cours d'exécution.
 - si on modifie la conf globale `conf/base.config`, nouvelles valeurs directement prises en compte.
 - Relancer avec -resume sinon écrase ce qui existait déjà.

_Remarque sur le workflow :_
Le workflow a planté sur une étape de post-alignement a cause de la mémoire (dépassement hvmem), lorsque j'ai relancé, il a refait les bwa !

Pourquoi ? A priori :
 - STEP 3.1 - align with bwa -> pas de sauvegarde des résultats intermédiaires dc relance tout
 - STEP 3.2 - post-alignment processing

En fin de traitement copy les fichiers depuis l'espace de travail vers l'output, 
--> besoin de bcp d’espace

Ensuite, quelques pb R lié à MACS mais j'ai pu faire tourner rapidement ce workflow.

## Conclusion
Prendre exemple sur les developpements du NGI si l'on doit coder des nextflow

