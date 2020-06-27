#! /bin/bash

while getopts "g:f:o:" opt; do
    case $opt in
        g) GENOME=$OPTARG  
        ;;
        f) FOLDER_IN=$OPTARG
        ;;
        *) echo 'error' >&2
            exit 1
    esac
done

if [ ! -d $GENOME ]; then
    echo "Could not find genome: $GENOME, exiting. Please make sure the genome exists"
    exit 1
fi

if [ ! -d $FOLDER_IN ]; then
    echo "Could not find input folder: $FOLDER_IN, exiting. Please make sure the input exists"
    exit 1
fi

cd $FOLDER_IN

for dir in /$WORKDIR/*/; do 
    dir=${dir%*/}
    dir=${dir##*/}

    if [[ $dir =~ "SRR" ]]; then
        mkdir -p $WORKDIR/$dir/Hisat2

        echo "Hisat2 is aligning ${dir} to the reference genome."
        /home/mees/NGS_Alzheimer/hisat2-2.2.0/hisat2 -p 4 -x $GENOME/ref_genome -U $WORKDIR/$dir/$dir.sra.fastq -S $WORKDIR/$dir/Hisat2/$dir.sam

    fi
done