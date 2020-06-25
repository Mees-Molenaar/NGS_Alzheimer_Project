#! /bin/sh

# Default
GTF="data/genomes/genome.gtf"
WORKDIR="/data/"

while getopts "g:d:" opt; do
    case $opt in
        g) GTF=$OPTARG  
        ;;
        d) WORKDIR=$OPTARG
        ;;
        *) echo 'error' >&2
            exit 1
    esac
done

if [ ! -f $GENOME ]; then
    echo "Could not find genome: $GENOME, exiting. Please make sure the genome exists"
    exit 1
fi

if [ ! -d $WORKDIR ]; then
    echo "Could not find working directory: $WORKDIR, exiting. Please make sure the working directory exists"
    exit 1
fi

cd $WORKDIR

for i in *.sam.sorted.bam; do
    echo "Counting ${i}."
    python -m HTSeq.scripts.count -f bam -r pos -s no $i $GTF > ${i}_count_2.txt
done 