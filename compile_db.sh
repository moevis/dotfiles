#install compdb command
pip install --user compdb

# produce compile_commands.json
compdb -p build/ list > compile_commands.json