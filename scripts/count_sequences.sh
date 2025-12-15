#!/bin/bash

# Script: count_sequences.sh
# Purpose: Count total number of sequences in FASTA file
# Usage: ./count_sequences.sh <fasta_file>

# Check if file input is provided
if [ $# -eq 0 ]; then
	echo "Error: No input provided"
	echo "Usage: $0 <fasta_file>"
	exit 1
fi

# Store filename in variable
fasta_file=$1

# Check if file exits or not
if [ ! -f "$fasta_file" ]; then
	echo "Error: File '$fasta_file' not found"
	exit 1
fi


if [ ! -r "$fasta_file" ]; then
	echo "Error: File '$fasta_file' is not readable"
	exit 1
fi


COUNT=$(grep -c "^>" "$fasta_file")

echo "$COUNT"
