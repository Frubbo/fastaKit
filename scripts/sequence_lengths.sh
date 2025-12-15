#!/bin/bash

# Script: sequence_lengths.sh
# Purpose: Count Lengths of sequences in a fasta file - longest seq, shortest seq and average len
# Usage: ./sequence_lengths.sh <fasta_file>

if [ $# -eq 0 ]; then
    echo "Error: No Input Provided"
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

# seq_count          - total number of sequences found
#current_length     - length of sequence currently being built
#current_name       - name/header of sequence currently being processed
#total_length       - sum of all sequence lengths (for average calculation)

#max_length         - length of longest sequence found
#max_name           - name of longest sequence

#min_length         - length of shortest sequence found
#min_name           - name of shortest sequence

awk '
BEGIN {
    # Initialize variables
    seq_count = 0
    current_length = 0
    current_name = ""
    total_length = 0
    max_length = 0
    max_name = ""
    min_length = 999999999999
    min_name = ""
}

/^>/ {
    # When you see a header line
    if (current_length > 0){
        total_length += current_length
        if (current_length > max_length){
            max_length = current_length
            max_name = current_name
        }
        if (current_length < min_length){
            min_length = current_length
            min_name = current_name
        }
    }
    seq_count++
    current_length = 0
    current_name = $0
}

!/^>/ {
    # When you see sequence data
    current_length += length($0)
}

END {
    # Final processing
    if (current_length > 0)
    {
        total_length += current_length
        if (current_length > max_length)
        {
            max_length = current_length
            max_name = current_name
        }
        if (current_length < min_length)
        {
            min_length = current_length
            min_name = current_name
        }
    }
    average = total_length / seq_count

    print "Total Number of sequences: " seq_count
    print "Average sequence length: " average
    print ""
    print "Longest Sequence: " max_name
    print "Length (aa): " max_length
    print ""
    print "Shortest Sequence: " min_name
    print "Length (aa): " min_length
}
' "$fasta_file"