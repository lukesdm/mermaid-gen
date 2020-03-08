#!/bin/sh

if git rev-parse --verify HEAD >/dev/null 2>&1
then
    against=HEAD
else
    # Initial commit: diff against an empty tree object
    against=$(git hash-object -t tree /dev/null)
fi

# Redirect output to stderr.
exec 1>&2

# Get changed/added .mmd files (exclude deleted)
# Note - simplifying by not using -z, won't handle weird chars like newlines in filenames.
mmdFiles=$(git diff --cached --name-only --diff-filter=dx $against | grep -i ".mmd$")
IFS=$'\n'
for file in $mmdFiles
do 
    if test -f "$file"; then
        outFile="${file%.*}.png"
        
        # Get additional mmdc args, from the last line of file
        while IFS= read -r line; do mmdArgs=$line; done < mermaid-gen.args
        
        # Render diagram and stage
        echo "-i \"$file\" -o \"$outFile\" $mmdArgs" | xargs mmdc
        git add "$outFile"
    else
        cat <<\EOF
Error: Couldn't access input file, or encountered an unexpected input
EOF
	exit 1
    fi
done
