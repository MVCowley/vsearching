# `vsearching`

A repo containing scripts for utilising vsearch to perform data management for [decombinator](https://github.com/innate2adaptive/decombinator).

## `merge_reads.sh`

Script to merge a set of paired-end reads in a directory together.

Example usage:

```shell
❯ ./merge_reads.sh
Please enter name of file with file list: example.csv
example.csv exists, proceeding with merge...
```

Where example.csv is a column csv of read 1 filenames:

```csv
INS_0007W8_FFPE_1.fq.gz
INS_0008W6_FFPE_1.fq.gz
INS_00123M_FFPE_1.fq.gz
INS_0012W8_FFPE_1.fq.gz
INS_00133M_FFPE_1.fq.gz
INS_0013BL_FFPE_1.fq.gz
INS_0013W6_FFPE_1.fq.gz
INS_0111W3_FFPE_1.fq.gz
INS_02008W6_FFPE_1.fq.gz
INS_0211W3_FFPE_1.fq.gz
WWM_N51_CD8_1.fq.gz
WWM_N63_CD8_1.fq.gz
```

> [!IMPORTANT]
> Both read 1 and read 2 must be in the same directory and have matching names except for (by default) `_1.fq.gz` and `_2.fq.gz` to denote the read number.

Check the output in logs easily with `grep "Merged" *.log` to see statistics on the lines successfully merged per file.

> [!TIP]
> To modify the script to fit your exact file naming conventions, some understanding of glob patterns and parameter expansion is required.
> `${R1/$pattern/$replacement}` is a parameter expansion where `R1` is the name of the read 1 file, `$pattern` is a string variable matching the ending name convention of your read 1 file, and `$replacement` is a string variable matching the ending name convention of your read 2 file.
> This expansion uses the pattern `${parameter/pattern/string}`, where the longest match of `pattern` is replaced with `string`.
> You can edit the strings assigned to `pattern` and `replacement` to fit your use case.
> As an example, to alter your filenames to accept un-gzipped FASTQ files using the long form of the extension, you would instead enter `pattern="1.fastq"` and `replacement="2.fastq"`.
> For futher details see the [bash parameter expansion documentation](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html).
