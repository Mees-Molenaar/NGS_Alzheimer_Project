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

        echo "Samtools is converting ${dir}.sam to a bam file."
        samtools view -bS $WORKDIR/$dir/Hisat2/$dir.sam > $WORKDIR/$dir/Hisat2/$dir.bam
        echo "Samtools is sorting ${dir}.bam"
        samtools sort $WORKDIR/$dir/Hisat2/$dir.bam -o $WORKDIR/$dir/Hisat2/$dir.sorted.bam
        echo "Samtools is indexing ${dir}.sorted.bam"
        samtools index $WORKDIR/$dir/Hisat2/$dir.sorted.bam

    fi
done