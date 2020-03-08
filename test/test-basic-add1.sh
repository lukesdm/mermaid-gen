# Assume running in a testBase folder, with relevant files copied (most of the repo contents).

# Derive test name and folder from script name, e.g.
# ./test/test-basic-add1.sh --> test-basic-add1.sh --> test-basic-add1
scriptPath=$0
scriptFilename=${scriptPath##*/}
testName=${scriptFilename%.*}
testDir="$testName"
oldTestDir="$testName-old"

# Clean up old test files
if [ -d "$oldTestDir" ]; then
    rm -rf "$oldTestDir"
fi
if [ -d "$testDir" ]; then
    mv "$testDir" "$oldTestDir"
fi

# 1. Init fresh repo (unique per test)
git init "$testDir"

# 2. Install pre-commit script
cp "mermaid-gen_pre-commit.sh" "$testDir/" 
cp "mermaid-gen.sh" "$testDir/" 
cp "mermaid-gen.params" "$testDir/" 
cp "test/pre-commit" "./$testDir/.git/hooks/"

# 3. Create .mmd file
cp "test/system1.mmd" "$testDir/"

# 4. Stage file
pushd "$testDir"
git add "system1.mmd"

# 5. Commit
git commit -m "Test - added diagram"

# If there were no errors, the test passed. 
# TODO: More robust assertion