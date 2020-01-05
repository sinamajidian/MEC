MEC
======


Evaluating MEC metric



## Performance curves

For drawing performance curves for MEC, you can use `performance_curve.m` The y-axis indicates the probability of obtaining a correct MEC P{c-MEC} and the x-axis the bi-substitution error probability.



## Evaluation of sequencing technologies

## prereqresite


- haplogenerator python code of the [haplosim](https://github.com/EhsanMotazedi/Haplosim) package. 
- Illumina read simulator [art_illumina](https://www.niehs.nih.gov/research/resources/software/biostatistics/art/index.cfm)

- Burrows-Wheeler Aligner [bwa](http://bio-bwa.sourceforge.net/)

- [samtools](http://www.htslib.org/)

- [minimap2](https://github.com/lh3/minimap2)

- PacBio read simulator [pbsim](https://github.com/pfaucon/PBSIM-PacBio-Simulator)

- Hapcut first version [hapcut](https://github.com/vibansal/hapcut)

### Illumina test

we provide a bash script for generating read dataset and the haplotyping pipeline. You may need the change the `ref_path` and also `haplogen_path`.

```
./illumina.sh
```



### Pacbio test

It's similar to that of Illumina. Please set `pbsim_model_path` somewhere in the folder that pbsim was installed.

```
./pacbio.sh
```


## haplotyping

```
extractHAIRS --mbq 1 --mmq 1  --bam read.bam --VCF ${haplogen_path}/out.vcf > frag.txt 
HAPCUT --fragments frag.txt --VCF  ${haplogen_path}/out.vcf --output out.hap > hapcut.log
```


## Comparison

`len_hap.py`



## citation

Sina Majidian, Mohammad Hossein Kahaei and Dick de Ridder,  "Minimum error correction-based haplotype assembly: considerations for long read data" Submitted to PloS one. 2020
https://arxiv.org/abs/1803.05019v2


