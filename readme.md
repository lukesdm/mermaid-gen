Automated mermaid diagram generation for Github Wikis, using git hooks.

Identifies .mmd files added/changed and generates corresponding images for them, which can be referenced from documentation files.

Usage: Copy pre-commit into the .git/hooks folder
Or - create a symlink. When working directory is the repository root:
Linux (TODO: Fix this command - get a file not found error):
ln -s pre-commit .git/hooks/pre-commit

Windows (Run as admin, or as user which has been assigned symlink permission):
mklink ".git/hooks/pre-commit" "pre-commit"

TODO: - Caution - self-referencing repo. Should test on another.

Copyright Luke S. D. McQuade 2020