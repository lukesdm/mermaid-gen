# mermaid-gen
Automated [mermaid](https://mermaid-js.github.io/mermaid/#/) diagram generation for GitHub documentation, using git hooks and [mermaid.cli](https://github.com/mermaid-js/mermaid.cli#mermaidcli).

Identifies .mmd files added/changed and generates corresponding images for them, which can be referenced from documentation files.

## Usage
1. **Dependencies** - Make sure the `git` and [`mmdc`](https://github.com/mermaid-js/mermaid.cli#mermaidcli) commands are accessible by your git client. Note: despite the warning, global install worked for me (Windows 10).  `mmdc` version 8.4.8 and `git` version 2.23.0.windows.1 have been using during development.

2. Copy the following to your repository root:
```
mermaid-gen_pre-commit.sh
mermaid-gen.sh
mermaid-gen.params
```

3. Add this to your .git/hooks/pre-commit script file (or create a new one* with these contents):  
```
exec ./mermaid-gen_pre-commit.sh
```

*You may also need to add an opening `#!/bin/sh`  

Adjust parameters in `./mermaid-gen.params` - the first line specifies the output type (`png`, `svg` or `pdf`), the second line specifies additional parameters of `mmdc`, according to https://github.com/mermaid-js/mermaid.cli#options. Take care not to change the line numbers.

See [doc.md](./test/doc.md) for a basic demonstration of a typical use case.

## Known Issues/Limitations
This project is currently at the experimental stage. Suggestions on improvements are welcome, especially relating to the bash scripting, which I'm not that familiar with.
Some specific issues:
- Partial commits are not supported - the diagram will be rendered based on its entire file contents.
- Local only - won't see updates on server-side merges (see Next Steps).
- Storing generated artifacts alongside the diagram source isn't ideal.
- Error handling - still need to work out the best approach for this. A syntax error can cause a hang during the pre-commit hook.
- Configuration is fragile (the mermaid-gen.params file format). Also, when changed, diagrams will have to be manually re-rendered. Running `./mermaid-gen.sh` without parameters will [re-]render all .mmd files.

## Tests
A start has been made on some automated end-to-end testing. Call `./run-tests {TestBase}` from the repo root, where `{TestBase}` is a non-existent folder outside of source control.

## Next Steps
As pre-commit scripts are run locally, it depends on each team member having this set up. The next step would be to look into creating a GitHub Action to automatically update the diagrams server-side.

Copyright (c) Luke McQuade 2020
