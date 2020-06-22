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

if [[ ! -d $WORKDIR ]]; then
    echo "Could not find working directory: $WORKDIR, exiting. Please make sure the working directory exists"
    exit 1
fi

prefetch --option-file SraAccList.txt -O $WORKDIR
fasterq-dump --split-files $WORKDIR/*.sra -p
echo 'Download and conversion to .fastq succesfull.'