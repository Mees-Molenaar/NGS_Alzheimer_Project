#! /bin/bash

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

for dir in /$WORKDIR/*/; do 
    dir=${dir%*/}
    dir=${dir##*/}

    if [[ $dir =~ "SRR" ]]; then

        echo "HTSeq is counting ${dir}.sorted.bam."
        python -m HTSeq.scripts.count -f bam -r pos -s no $WORKDIR/$dir/Hisat2/$dir.sorted.bam $GTF > $WORKDIR/$dir/Hisat2/${dir}_HTScount.txt

    fi
done