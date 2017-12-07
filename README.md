# Workflow Framework Comparison
Here is the repository for hackathon occured at INRA Toulouse on the 29 and 30 of november 2017.

The purpose of this meeting was to test different workflow manager in an **HPC environment**.
We didn't want to test Cloud and Docker functionalities.

## People implied (INRA):
 * Estelle Ancellet (MIAT, Record), 
 * Philippe Bardou (GenPhySE, Sigenae), 
 * Floréal Cabanettes (MIAT, Bioinfo Genotoul), 
 * Cédric Cabau (GenPhySE, Sigenae), 
 * Sébastien Carrere (LIPM, Bioinfo), 
 * Ludovic Legrand (LIPM, Bioinfo), 
 * Sarah Maman (GenPhySE, Sigenae), 
 * Céline Noirot (MIAT, Bioinfo Genotoul), 
 * Maria Bernard (GABY, Sigenae)

## Some publications:
 * Review :
	* 2016 [A review of bioinformatic pipelines frameworks](bib.oxfordjournals.org/content/early/2016/03/23/bib.bbw020.full)
	* 2017 [A Review of Scalable Bioinformatics Pipelines](https://link.springer.com/content/pdf/10.1007/s41019-017-0047-z.pdf)
 * Frameworks :
	* [BETSY](https://academic.oup.com/bioinformatics/article-lookup/doi/10.1093/bioinformatics/btw817)
	* [RABIX / Bunny](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5166558/)
	* [Nextflow](https://www.nature.com/articles/nbt.3820.pdf)
	* [Snakemake](https://www.ncbi.nlm.nih.gov/pubmed/22908215)
	* cwltool
	* [toil](https://www.nature.com/articles/nbt.3772)
	* [jflow](https://academic.oup.com/bioinformatics/article/32/3/456/1744024)
	* [pegasus](http://pegasus.isi.edu/publications/2014/2014-fgcs-deelman.pdf)
	* Galaxy

## Organization

In directory to_start you will find data to start comparison and also the
cwl workflow examples.
The purpose of the two days is to develop a workflow which perform :
 - fastqc
 - cutadapt
 - STAR (Indexation if needed)

It would be great if the workflow/manager can handle a list of single fastq and paired fastq in a same workflow.

## Main needs to explore

Required features of the workflow manager:
 - Facility for a biologist / bio-analyst to understand errors
 - Compatible HPC clusters (SGE, SLURM, ...)
 - Easy development, handling and maintenance
 - Few outbuildings
 - A living community
 - Generic input files (give file patterns)
 - ... to be completed

Things to identify when testing managers:

 - How does the manager behave if a child job is killed by the scheduler (overflow) / the user?
 - Does the rerun work after killing the master job?
 - During a rerun are the new parameters (put in the conf or in the command line) taken into account? For example memory options?
 - Can we limit the total number of jobs used in parallel by the workflow?
 - What is the space requirement during processing and after processing, are the files copied? symbolic links are made? if file are stored does it keep them zipped?

## Comparison sheet
Read only [Comparison sheet](https://docs.google.com/spreadsheets/d/1Iss0BYVrhS6-pWg16cWyN-yGUUQjGaKvEqAas_VEn64/edit?usp=sharing)
_If you want to add your tool or your feedback, please ask for access to celine.noirot@inra.fr._

## Conclusion

After 2 days:
- we tried to test : Rabix, toil, pegasus without success.
- 2 workflow managers stand out : NextFlow and Snakemake ( not a surprise ).
The caracteristics and the ease of coding are really similar.
The main problem on nextflow is the memory needed by master job (50G of virtual mem not enougth!).
On Snakemake it seems not to be as easy as on nextflow to use memory and cpu parameter in a rule/process.
For more details on evaluated caracteristics check the [Comparison sheet](https://docs.google.com/spreadsheets/d/1Iss0BYVrhS6-pWg16cWyN-yGUUQjGaKvEqAas_VEn64/edit?usp=sharing) and the contents of directories in comparison.
