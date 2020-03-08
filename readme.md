# mermaid-gen
Automated mermaid diagram generation for GitHub documentation, using git hooks.

Identifies .mmd files added/changed and generates corresponding images for them, which can be referenced from documentation files.

## Usage
1. Copy these to your repository root:
./mermaid-gen_pre-commit.sh
./mermaid-gen.params

2. Add this to your .git/hooks/pre-commit script file (or create a new one with these contents):
exec ./mermaid-gen_pre-commit.sh

Adjust parameters in `./mermaid-gen.params` - the first line specifies the output type (`png`, `svg` or `pdf`), the second line specifies additional parameters of `mmdc`, according to https://github.com/mermaidjs/mermaid.cli#options. Take care not to change the line numbers.

## Limitations
- Partial commits are not supported - the diagram will be rendered based on its entire file contents

TODO: - Caution - self-referencing repo. Should test on another.

Copyright Luke S. D. McQuade 2020