#!/usr/bin/env bash
# Script which takes a csv with a list of names of the read 1 of pair of paired end reads.
# Merges them together using vsearch. Read 2 must be in the same directory.

# Get filename from user
read -ep "Please enter name of file with file list: " fname

# Check file exists
if [ -f $fname ]; then
    echo "$fname exists, proceeding with merge..."
else
    echo "$fname does not exist, please add it to the directory."
    echo 'Exiting.'
    if [ $sourced -eq 1 ]; then
        return
    else
        exit
    fi
fi

# Create log directory
echo "Creating dir for logs..."
mkdir logs

# Define pattern and replacement
pattern="1.fq.gz"
replacement="2.fq.gz"

# Loop over files in the csv supplied
while IFS=',' read -r R1; do
	R2="${R1/$pattern/$replacement}"

	if [[ -f "$R2" ]]; then
		echo "Merging $R1 with $R2"
		vsearch --fastq_mergepairs ${R1} --reverse ${R1/$pattern/$replacement} --fastqout ${R1/$pattern/merge.fq} --fastq_allowmergestagger --log logs/${R1/$pattern/merge.log};
		gzip ${R1/$pattern/merge.fq}
	else
		echo "Read pair $R2 for $R1 not found."
	fi
done < "$fname"

