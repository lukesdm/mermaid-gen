# mermaid-gen
Automated [mermaid](https://mermaid-js.github.io/mermaid/#/) diagram generation for GitHub documentation, using git hooks and [mermaid.cli](https://github.com/mermaid-js/mermaid.cli#mermaidcli).

Identifies .mmd files added/changed and generates corresponding images for them, which can be referenced from documentation files.

## Usage
1. Make sure the `git` and [`mmdc`](https://github.com/mermaid-js/mermaid.cli#mermaidcli) commands are accessible by your git client. Note: despite the warning global install worked for me (Windows 10).

2. Copy these to your repository root:
./mermaid-gen_pre-commit.sh
./mermaid-gen.params

3. Add this to your .git/hooks/pre-commit script file (or create a new one with these contents):
exec ./mermaid-gen_pre-commit.sh

Adjust parameters in `./mermaid-gen.params` - the first line specifies the output type (`png`, `svg` or `pdf`), the second line specifies additional parameters of `mmdc`, according to https://github.com/mermaid-js/mermaid.cli#options. Take care not to change the line numbers.

## Known issues/limitations
This project is currently at the experimental stage. Suggestions on improvements are welcome, especially relating to the bash scripting.
Some specific issues:
- Partial commits are not supported - the diagram will be rendered based on its entire file contents
- Local only (see Next Steps)

## Tests
A start has been made on some automated end-to-end testing . Call `./run-tests {TestBase}` from the repo root, where `{TestBase}` is a non-existent folder outside of source control.

## Next Steps
As pre-commit scripts are run locally, it depends on each team member having this set up. The next step would be to look into creating a GitHub Action to automatically update the diagrams server-side.

Copyright Luke McQuade 2020