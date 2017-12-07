export DRMAA_LIBRARY_PATH=/SGE/ogs/lib/linux-x64/libdrmaa.so
snakemake --jobs 999 --configfile config.yaml --cluster-config cluster.yaml --drmaa " -l mem={cluster.mem},h_vmem={cluster.mem} -pe parallel_smp {cluster.cpu}"
