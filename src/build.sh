#! /bin/sh

# Default
GENOME="data/genomes/genome.fa"
OUTPUT="data/genomes/ref_genome/"
HISAT_BUILD="hisat2/hisat2-build"

while getopts "g:o:l:" opt; do
    case $opt in
        g) GENOME=$OPTARG  
        ;;
        o) OUTPUT=$OPTARG
        ;;
        l) HISAT_BUILD=$OPTARG
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


if $HISAT_BUILD -p 4 $GENOME $OUTPUT/ref_genome ; then
    echo "Succesfully build the reference genome."
else
    echo "Error while building reference genome."
fi