#!/bin/bash

# Input and output file paths
INPUT_FILE="cyclonedx.table"
MARKDOWN_FILE="cyclonedx.md"

# Step 1: Convert the .table file directly to Markdown format
{
echo "| NAME                | INSTALLED                | FIXED-IN             | TYPE  | VULNERABILITY   | SEVERITY   |"
echo "|---------------------|--------------------------|----------------------|-------|-----------------|------------|"
awk 'NR > 1 {
    # Split the line into fields based on whitespace
    name = $1;
    installed = $2;
    fixed_in = ($3 ~ /^[a-zA-Z]/ ? "" : $3); # Check if $3 is empty or part of the next column
    type = ($3 ~ /^[a-zA-Z]/ ? $3 : $4);
    vulnerability = ($3 ~ /^[a-zA-Z]/ ? $4 : $5);
    severity = ($3 ~ /^[a-zA-Z]/ ? $5 : $6);

    # Print the fields in Markdown table format
    printf "| %-20s | %-24s | %-20s | %-5s | %-15s | %-10s |\n", name, installed, fixed_in, type, vulnerability, severity;
}' "$INPUT_FILE"
} > "$MARKDOWN_FILE"

# Output success message
echo "Markdown table saved to $MARKDOWN_FILE"