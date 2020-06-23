#! /bin/sh

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

for i in *.fastq; do
    OUT="${i%.*}"
    echo "Hisat2 is aligning $i"
    /home/mees/NGS_Alzheimer/hisat2-2.2.0/hisat2 -p 4 -x $GENOME/ref_genome -U $i -S ${OUT}_out.sam
done