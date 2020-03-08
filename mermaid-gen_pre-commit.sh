if git rev-parse --verify HEAD >/dev/null 2>&1
then
    against=HEAD
else
    # Initial commit: diff against an empty tree object
    against=$(git hash-object -t tree /dev/null)
fi

# TODO: Check if args file has changed - if so, [re-]render all .mmd files.

# Get changed/added .mmd files (exclude deleted)
# Note - simplifying by not using -z, won't handle weird chars like newlines in filenames.
mmdFiles=$(git diff --cached --name-only --diff-filter=dx $against | grep -i ".mmd$")
IFS=$'\n'
for file in $mmdFiles
do 
    if test -f "$file"; then
        # Render diagram and stage
        ./mermaid-gen.sh "$file"
    else
        echo "ERROR: Couldn't access input file, or encountered an unexpected input" 1>&2
	    exit 1
    fi
done
