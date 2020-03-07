Automated mermaid diagram generation for GitHub documentation, using git hooks.

Identifies .mmd files added/changed and generates corresponding images for them, which can be referenced from documentation files.

Usage: Add this to your pre-commit script (or create a new one with these contents):
exec ./mermaid-gen.pre-commit

TODO: - Caution - self-referencing repo. Should test on another.

Copyright Luke S. D. McQuade 2020