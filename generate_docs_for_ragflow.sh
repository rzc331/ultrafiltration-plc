#!/bin/bash

# Generate a comprehensive Markdown file from repository files for RAGFlow
# Usage: ./generate_docs_for_ragflow.sh [output_file] [file_extensions]
# Example: ./generate_docs_for_ragflow.sh all_files.md "st xml md"

# Default output file
OUTPUT_FILE=${1:-"ragflow_docs.md"}
# Default file extensions to include (space-separated)
FILE_EXTENSIONS=${2:-"st xml md"}

# Create output directory if it doesn't exist
OUTPUT_DIR=$(dirname "$OUTPUT_FILE")
mkdir -p "$OUTPUT_DIR"

# Convert space-separated extensions to find-compatible pattern
FIND_PATTERN=""
for ext in $FILE_EXTENSIONS; do
  if [ -z "$FIND_PATTERN" ]; then
    FIND_PATTERN="-name \"*.$ext\""
  else
    FIND_PATTERN="$FIND_PATTERN -o -name \"*.$ext\""
  fi
done

# Create header for the markdown file
REPO_NAME=$(basename $(pwd))
echo "# $REPO_NAME Documentation" > "$OUTPUT_FILE"
echo -e "\nThis file contains all project files compiled for RAGFlow.\n" >> "$OUTPUT_FILE"
echo -e "Generated on: $(date)\n" >> "$OUTPUT_FILE"
echo -e "Included file types: $FILE_EXTENSIONS\n" >> "$OUTPUT_FILE"

# Find and process files
eval "find . -type f \( $FIND_PATTERN \) -not -path \"./node_modules/*\" -not -path \"./.git/*\" -not -path \"$OUTPUT_DIR/*\"" | sort | while read file; do
  # Get file info
  filename=$(basename "$file")
  
  # Add file header to the markdown
  echo -e "## $filename\n" >> "$OUTPUT_FILE"
  echo -e "Source: \`$file\`\n" >> "$OUTPUT_FILE"
  
  # Get file extension for proper code block formatting
  file_ext="${filename##*.}"
  
  # Add file contents
  echo -e "\`\`\`$file_ext" >> "$OUTPUT_FILE"
  cat "$file" >> "$OUTPUT_FILE"
  echo -e "\`\`\`\n" >> "$OUTPUT_FILE"
done

FILE_COUNT=$(grep -c "^## " "$OUTPUT_FILE")
echo "Successfully created $OUTPUT_FILE with $FILE_COUNT files included."
echo "Total size: $(du -h "$OUTPUT_FILE" | cut -f1)" 