#!/bin/bash

# Script: count_organisms.sh
# Purpose: Count Sequences per organism (Uniprot format)
# Usage: ./count_organism.sh <fasta_file>

if [ $# -lt 1 ]; then
    echo "Error"
    echo "Usage: ${0} <fasta_file>"
    exit 1
fi

# Store filename in variable
fasta_file=${1}

# Check if file exits or not
if [ ! -f "$fasta_file" ]; then
    echo "Error: File '$fasta_file' not found"
    exit 2
fi

if [ ! -r "$fasta_file" ]; then
    echo "Error: File '$fasta_file' not readable"
    exit 3
fi

awk '
/^>/ {
    if($0 ~ /OS=/)
    {
        split($0, temp, "OS=")
        split(temp[2], org_parts, " OX=")
        organism = org_parts[1]
        count[organism]++
    }
}

END {
    for (organism in count)
    {
        print organism ": " count[organism]
    }
}' "$fasta_file" | sort -t: -k2 -nr