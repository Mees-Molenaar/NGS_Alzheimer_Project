#! /bin/bash

while getopts "g:f:l:" opt; do
    case $opt in
        g) GENOME=$OPTARG  
        ;;
        f) FOLDER_IN=$OPTARG
        ;;
        l) HISAT=$OPTARG
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

        if $HISAT -p 4 -x $GENOME/ref_genome -U $WORKDIR/$dir/$dir.sra.fastq -S $WORKDIR/$dir/Hisat2/$dir.sam --summary-file $WORKDIR/$dir/Hisat2/${dir}_out.txt; then
            echo "Hisat2 succesfully aligned ${dir} to the reference genome."
        else
            echo "Error while aligning ${dir} to the reference genome"
        fi
    fi
done