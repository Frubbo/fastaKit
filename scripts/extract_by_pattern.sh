#!/bin/bash

# Script: extract_by_pattern.sh
# Purpose: Extracts each line which has the header matching with the pattern
# Usage: ./extract_by_pattern.sh <fasta_file> "pattern"

if [ $# -lt 2 ]; then
    echo "Error"
    echo "Usage: ${0} <fasta_file> \"pattern\""
    exit 1
fi

# Store filename in variable
fasta_file=${1}
pattern=${2}

if [ -z "$pattern" ]; then
    echo "Error: No pattern provided"
    echo "Usage: ${0} <fasta_file> \"pattern\""
    exit 2
fi

# Check if file exits or not
if [ ! -f "$fasta_file" ]; then
    echo "Error: File '$fasta_file' not found"
    exit 3
fi

if [ ! -r "$fasta_file" ]; then
    echo "Error: File '$fasta_file' not readable"
    exit 4
fi

awk -v pattern="$pattern" '
BEGIN {
    # Flag
    match_found = 0
}

/^>/ {
    if($0 ~ pattern)
    {
        print ""
        match_found = 1
        print $0
    }
    else
    {
        match_found = 0
    }
}

!/^>/ {
    if(match_found == 1)
    {
        print $0
    }
}' "$fasta_file"