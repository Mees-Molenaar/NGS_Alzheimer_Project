#! /bin/bash

# Default directory to store data is in the data folder, otherwise you can give your directory with -d flag
WORKDIR="data/"

while getopts "d:" opt; do
    case $opt in
        d) WORKDIR=$OPTARG  ;;
        *) echo 'error' >&2
            exit 1
    esac
done

if [ ! -d $WORKDIR ]; then
    echo "Could not find working directory: $WORKDIR, exiting. Please make sure the working directory exists"
    exit 1
fi

cd $WORKDIR

for dir in /$WORKDIR/*/; do 
    dir=${dir%*/}
    dir=${dir##*/}

    if [[ $dir =~ "SRR" ]]; then
        mkdir -p $WORKDIR/$dir/FastQC

        perl /home/mees/NGS/FastQC/fastqc -f fastq -o $WORKDIR/$dir/FastQC $WORKDIR/$dir/$dir.sra.fastq
        cp -avr $WORKDIR/$dir/FastQC /home/mees/NGS_Alzheimer/data/
    fi
done