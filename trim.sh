#! /bin/sh

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

mkdir -p trimmed

for i in *.fastq; do
    cutadapt -a NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN -a GATCGGAAGAGCACACGTCTGAACTCCAGTCACGAGATTCCATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAA -a GATCGGAAGAGCACACGTCTGAACTCCAGTCACGAGATTCCATCTCGTATGCCGTCTTCTGCTTGAAAAAAAAAT -o trimmed/$i $i
done