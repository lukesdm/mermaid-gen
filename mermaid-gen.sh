#!/bin/sh

# Generates rendered diagrams
# Input: .mmd file to render. If not specified, renders all .mmd files, inc. subfolders
# Run it from the repository root

if test ! -z $2; then
    echo "ERROR: Only expected a single argument - the .mmd file to render" 1>&2
    exit 1
fi

if test ! -z $1; then
    # Single file mode
    if test -f "$1"; then
        mmdFiles=$1
    else
        echo "ERROR: Invalid file specified" 1>&2
        exit 1
    fi
else
    # Batch mode
    mmdFiles=$(find . -iname '*.mmd' -type f)
fi

# Read parameters from file
readarray -t argLines < mermaid-gen.params
outputType=${argLines[1]}
mmdcArgs=${argLines[2]}

IFS=$'\n'
for inFile in $mmdFiles; do 
    outFile="${inFile%.*}.$outputType"
    # Render diagram and stage
    echo "-i \"$inFile\" -o \"$outFile\" $mmdcArgs" | xargs mmdc
    git add "$outFile"
done