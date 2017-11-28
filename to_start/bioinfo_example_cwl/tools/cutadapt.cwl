cwlVersion: v1.0
class: CommandLineTool
id: cutadapt
label: cutadapt
doc: cutadapt removes adapter sequences from high-throughput sequencing reads.

baseCommand: cutadapt

requirements:
  SoftwareRequirement:
    packages:
      cutadapt:
        version: [ "1.13"]
        
inputs:

# General options
  file-R1:
    type: File
    doc: File containing sequencing reads (forward or single-end reads).
    inputBinding:
      position: 1
  file-R2:
    type: File?
    doc: File containing seuquencing reads (reverse, only paired-end reads).
    inputBinding:
      position: 2
  format:
    type: string?
    doc: |
      Input file format; can be either 'fasta', 'fastq' or 'sra-fastq'.
      Ignored when reading csfasta/qual files. Default auto-detect from file 
      name extension.
    inputBinding:
      prefix: --format=
      separate: false

# Finding adapters
  adapter-R1:
    type: File?
    doc: |
      Sequence of an adapter ligated to the 3' end (paired data: of the first 
      read). The adapter and subsequent bases are trimmed. If a '$' character
      is appended ('anchoring'), the adapter is only found if it is a suffix 
      of the read.
    inputBinding:
      prefix: --adapter=
      separate: false
  front-R1:
    type: string?
    doc: |
      Sequence of an adapter ligated to the 5' end (paired data of the first 
      read). The adapter and any preceding bases are trimmed. Partial matches 
      at the 5' end are allowed. If a '^' character is prepended ('anchoring'),
      the adapter is only found if it is a prefix of the read.
    inputBinding:
      prefix: --front=
      separate: false
  anywhere-R1:
    type: string?
    doc: |
      Sequence of an adapter that may be ligated to the 5' or 3' end (paired 
      data of the first read). Both types of matches as described under -a und 
      -g are allowed. If the first base of the read is part of the match, the 
      behavior is as with -g, otherwise as with -a. This option is mostly for 
      rescuing failed library preparations - do not use if you know which end 
      your adapter was ligated to!
    inputBinding:
      prefix: --anywhere=
      separate: false
  error-rate:
    type: float
    default: 0.1
    doc: |
      Maximum allowed error rate (no. of errors divided by the length of the 
      matching region). Default 0.1
    inputBinding:
      prefix: --error-rate=
      separate: false
  no-indels:
    type: boolean
    default: false
    doc: |
      Allow only mismatches in alignments. Default allow both mismatches and
      indels.
    inputBinding:
      prefix: --no-indels
  times:
    type: int
    default: 1
    doc: Remove up to COUNT adapters from each read. Default 1
    inputBinding:
      prefix: --times=
      separate: false
  overlap:
    type: int
    default: 3
    doc: |
      If the overlap between the read and the adapter is shorter than 
      MINLENGTH, the read is not modified. Reduces the no. of bases trimmed due
      to random adapter matches. Default 3
    inputBinding:
      prefix: --overlap=
      separate: false
  match-read-wildcards:
    type: boolean
    default: false
    doc: Interpret IUPAC wildcards in reads. Default False
    inputBinding:
      prefix: --match-read-wildcards
  no-match-adapter-wildcards:
    type: boolean
    default: false
    doc: Do not interpret IUPAC wildcards in adapters.
    inputBinding:
      prefix: --no-match-adapter-wildcards
  no-trim:
    type: boolean
    default: false
    doc: |
      Match and redirect reads to output/untrimmed-output as usual, but do not 
      remove adapters.
    inputBinding:
      prefix: --no-trim
  mask-adapter:
    type: boolean
    default: false
    doc: Mask adapters with 'N' characters instead of trimming them.
    inputBinding:
      prefix: --mask-adapter

# Additional read modifications

  cut-R1:
    type: int?
    doc: |
      Remove bases from each read (first read only if paired). If LENGTH is 
      positive, remove bases from the beginning. If LENGTH is negative, remove 
      bases from the end. Can be used twice if LENGTHs have different signs.
    inputBinding:
      prefix: --cut=
      separate: false
  nextseq-trim:
    type: string?
    doc: |
      NextSeq-specific quality trimming (each read). Trims also dark cycles 
      appearing as high-quality G bases (EXPERIMENTAL).
    inputBinding:
      prefix: --nextseq-trim=
      separate: false
  quality-cutoff:
    type: int?
    doc: |
      Trim low-quality bases from 5' and/or 3' ends of each read before adapter
      removal. Applied to both reads if data is paired. If one value is given, 
      only the 3' end is trimmed. If two comma-separated cutoffs are given,
      the 5' end is trimmed with the first cutoff, the 3' end with the second.
    inputBinding:
      prefix: --quality-cutoff=
      separate: false
  quality-base:
    type: int
    default: 33
    doc: |
      Assume that quality values in FASTQ are encoded as 
      ascii(quality + QUALITY_BASE). This needs to be set to 64 for some old 
      Illumina FASTQ files. Default 33
    inputBinding:
      prefix: --quality-base=
      separate: false
  length:
    type: int?
    doc: |
      Shorten reads to LENGTH. This and the following modificationsare applied 
      after adapter trimming.
    inputBinding:
      prefix: --length=
      separate: false
  trim-n:
    type: boolean
    default: false
    doc: Trim N's on ends of reads.
    inputBinding:
      prefix: --trim-n
  length-tag:
    type: string?
    doc: |
      Search for TAG followed by a decimal number in the description field of 
      the read. Replace the decimal number with the correct length of the
      trimmed read. For example, use --length-tag 'length=' to correct fields
      like 'length=123'.
    inputBinding:
      prefix: --length-tag=
      separate: false
  strip-suffix:
    type: string?
    doc: |
      Remove this suffix from read names if present.
      Can be given multiple times.
    inputBinding:
      prefix: --strip-suffix=
      separate: false
  prefix:
    type: string?
    doc: |
      Add this prefix to read names. Use {name} to insert the name of the
      matching adapter.
    inputBinding:
      prefix: --prefix=
      separate: false
  suffix:
    type: string?
    doc: |
      Add this suffix to read names; can also include {name}
    inputBinding:
      prefix: --suffix
      separate: false
 
# Filtering of processed reads:

  minimum-length:
    type: int
    default: 0
    doc: |
      Discard trimmed reads that are shorter than LENGTH. Reads that are too 
      short even before adapter removal are also discarded. In colorspace, an 
      initial primer is not counted. Default 0
    inputBinding:
      prefix: --minimum-length=
      separate: false
  maximum-length:
    type: int?
    doc: |
      Discard trimmed reads that are longer than LENGTH. Reads that are too long 
      even before adapter removal are also discarded. In colorspace, an initial 
      primer is not counted. Default no limit
    inputBinding:
      prefix: --maximum-length=
      separate: false
  max-n:
    type: float?
    doc: |
      Discard reads with too many N bases. If COUNT is an integer, it is treated
      as the absolute number of N bases. If it is between 0 and 1, it is treated
      as the proportion of N's allowed in a read.
    inputBinding:
      prefix: --max-n=
      separate: false
  discard-trimmed:
    type: boolean
    default: false
    doc: |
      Discard reads that contain an adapter. Also use -O to avoid discarding too
      many randomly matching reads!
    inputBinding:
      prefix: --discard-trimmed
  discard-untrimmed:
    type: boolean
    default: false
    doc: Discard reads that do not contain the adapter.
    inputBinding:
      prefix: --discard-untrimmed

# Output

  output-R1:
    type: string?
    doc: |
      Write trimmed reads to FILE. FASTQ or FASTA format is chosen depending on 
      input. The summary report is sent to standard output. Use '{name}' in FILE
      to demultiplex reads into multiple files. Default write to standard output
    inputBinding:
      prefix: --output=
      separate: false
  info:
    type: string?
    doc: |
      Write information about each read and its adapter matches into FILE. See
      the documentation for the file format.
    inputBinding:
      prefix: --info-file=
      separate: false
  rest:
    type: string?
    doc: |
      When the adapter matches in the middle of a read, write the rest 
      (after the adapter) into FILE.
    inputBinding:
      prefix: --rest-file=
      separate: false
  wildcard:
    type: string?
    doc: |
      When the adapter has N bases (wildcards), write adapter bases matching 
      wildcard positions to FILE. When there are indels in the alignment, this 
      will often not be accurate.
    inputBinding:
      prefix: --wildcard-file=
      separate: false
  too-short-output-R1:
    type: string?
    doc: |
      Write reads that are too short (according to length specified by -m) to
      FILE. Default discard reads
    inputBinding:
      prefix: --too-short-output=
      separate: false
  too-long-output-R1:
    type: string?
    doc: |
      Write reads that are too long (according to length specified by -M) to 
      FILE. Default discard reads
    inputBinding:
      prefix: --too-long-output=
      separate: false
  untrimmed-output-R1:
    type: string?
    doc: |
      Write reads that do not contain any adapter to FILE. Default output to 
      same file as trimmed reads.
    inputBinding:
      prefix: --untrimmed-output=
      separate: false

# Colorspace options

  colorspace:
    type: boolean
    default: false
    doc: |
      Enable colorspace mode. Also trim the color that is adjacent to the found
      adapter.
    inputBinding:
      prefix: --colorspace
  double-encode:
    type: boolean
    default: false
    doc: Double-encode colors (map 0,1,2,3,4 to A,C,G,T,N).
    inputBinding:
      prefix: --double-encode
  trim-primer:
    type: boolean
    default: false
    doc: |
      Trim primer base and the first color
      (which is the transition to the first nucleotide)
    inputBinding:
      prefix: --trim-primmer
  strip-f3:
    type: boolean
    default: false
    doc: Strip the _F3 suffix of read names
    inputBinding:
      prefix: --strip-f3
  maq:
    type: boolean
    default: false
    doc: |
      MAQ- and BWA-compatible colorspace output. 
      This enables -c, -d, -t, --strip-f3 and -y '/1'.
    inputBinding:
      prefix: --maq
  no-zero-cap:
    type: boolean
    default: false
    doc: |
      Do not change negative quality values to zero in colorspace data. By 
      default, they are since many tools have problems with negative qualities.
    inputBinding:
      prefix: --no-zero-cap
  zero-cap:
    type: boolean
    default: false
    doc: |
      Change negative quality values to zero. This is enabled by default when
      -c/--colorspace is also enabled. Use the above option to disable it.
    inputBinding:
      prefix: --zero-cap

# Paired-end options:

  adapter-R2:
    type: string?
    doc: 3' adapter to be removed from second read in a pair.
    inputBinding:
      prefix: -A
  front-R2:
    type: string?
    doc: 5' adapter to be removed from second read in a pair.
    inputBinding:
      prefix: -G
  anywhere-R2:
    type: string?
    doc: 5'/3 adapter to be removed from second read in a pair.
    inputBinding:
      prefix: -B
  cut-R2:
    type: int?
    doc: Remove LENGTH bases from second read in a pair (see --cut).
    inputBinding:
      prefix:  -U
  output-R2:
    type: string?
    doc: Write second read in a pair to FILE.
    inputBinding:
      prefix: --paired-output
      separate: false
  pair-filter:
    type: string?
    doc: |
      Which of the reads in a paired-end read have to match the filtering 
      criterion in order for it to be filtered. Values any or both. Default any
    inputBinding:
      prefix: --pair-filter=
      separate: false
  interleaved:
    type: boolean
    default: false
    doc: Read and write interleaved paired-end reads.
    inputBinding:
      prefix: --interleaved
  untrimmed-output-R2:
    type: string?
    doc: |
      Write second read in a pair to this FILE when no adapter was found in the 
      first read. Use this option together with --untrimmed-output when trimming
      paired-end reads. Default output to same file as trimmed reads
    inputBinding:
      prefix: --untrimeed-paired-output=
      separate: false
  too-short-output-R2:
    type: string?
    doc: |
      Write second read in a pair to this file if pair is too short. Use 
      together with --too-short-output.
    inputBinding:
      prefix: --too-short-paired-output==
      separate: false
  too-long-output-R2:
    type: string?
    doc: |
      Write second read in a pair to this file if pair is too long. Use together
      with --too-long-output.
    inputBinding:
      prefix: --too-long-paired-output=
      separate: false

outputs:

  output-file-R1:
    type: File?
    outputBinding:
      glob: $(inputs.output-R1)
  info-file:
    type: File?
    outputBinding:
      glob: $(inputs.file-info)
  rest-file:
    type: File?
    outputBinding:
      glob: $(inputs.rest-file)
  wildcard-file:
    type: File?
    outputBinding:
      glob: $(inputs.wildcard-file)
  too-short-output-file-R1:
    type: File?
    outputBinding:
      glob: $(inputs.too-short-output-R1)
  too-long-output-file-R1:
    type: File?
    outputBinding:
      glob: $(inputs.too-long-output-R1)
  untrimmed-output-file-R1:
    type: File?
    outputBinding:
      glob: $(inputs.untrimmed-output-R1)
  output-file-R2:
    type: File?
    outputBinding:
      glob: $(inputs.output-R1)
  untrimmed-output-file-R2:
    type: File?
    outputBinding:
      glob: $(inputs.untrimeed-output-R2)
  too-short-output-file-R2:
    type: File?
    outputBinding:
      glob: $(inputs.too-short-output-R2)
  too-long-output-file-R2:
    type: File?
    outputBinding:
      glob: $(inputs.too-long-output-R2)
