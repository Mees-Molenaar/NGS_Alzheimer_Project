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



if prefetch --option-file SraAccList.txt -O $WORKDIR ; then
    echo "Succesfully dowloaded the SRA data."
else
    echo "Data was not downloaded."
    exit 1
fi

cd $WORKDIR

for i in *.sra;
do
    echo "Converting ${i} to fastq."
    SRA="${i%.*}"
    mkdir -p $SRA
    if fasterq-dump $i -O $SRA -t /tmp/ ; then
        echo "Succesfully converted ${i}."
    else
        echo "Error while converting ${i}."
    fi
done