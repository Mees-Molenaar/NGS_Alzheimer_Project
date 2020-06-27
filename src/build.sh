#! /bin/sh

# Default
GENOME="data/genomes/genome.fa"
OUTPUT="/data/genomes/ref_genome/"

while getopts "g:o:" opt; do
    case $opt in
        g) GENOME=$OPTARG  
        ;;
        o) OUTPUT=$OPTARG
        ;;
        *) echo 'error' >&2
            exit 1
    esac
done

if [ ! -f $GENOME ]; then
    echo "Could not find genome: $GENOME, exiting. Please make sure the genome exists"
    exit 1
fi

# If output directory doesn't exist, make it
mkdir -p $OUTPUT

/home/mees/NGS_Alzheimer/hisat2-2.2.0/hisat2-build -p 4 $GENOME $OUTPUT/ref_genome