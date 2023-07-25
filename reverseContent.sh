#Write a shell script to reverse the content of the file
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

file="$1"

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "Error: File '$file' not found."
    exit 1
fi

# Create a temporary file to store the reversed content
temp_file=$(mktemp)

# Reverse the content of the file and save it in the temporary file
tac "$file" > "$temp_file"

# Overwrite the original file with the reversed content
mv "$temp_file" "$file"

echo "Content of '$file' has been reversed."


#to execute above script --
#chmod +x reverse_content.sh
#  ./reverse_content.sh your_file.txt
