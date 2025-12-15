#!/bin/bash

# Script: fasta_inspector.sh
# Purpose: Master script that runs all FASTA analysis tools
# Usage: ./fasta_inspector.sh <fasta_file>

# Check if file argument provided
if [ $# -lt 1 ]; then
    echo "Error: No file provided"
    echo "Usage: $0 <fasta_file>"
    exit 1
fi

FASTA_FILE=$1

# Check if file exists
if [ ! -f "$FASTA_FILE" ]; then
    echo "Error: File '$FASTA_FILE' not found"
    exit 2
fi

# Check if file is readable
if [ ! -r "$FASTA_FILE" ]; then
    echo "Error: File '$FASTA_FILE' is not readable"
    exit 3
fi

# Display header
echo "=========================================="
echo "       FASTA File Inspector"
echo "       File: $FASTA_FILE"
echo "=========================================="
echo ""

# Script 1: Count sequences
echo "=== SEQUENCE COUNT ==="
if [ -x "./scripts/count_sequences.sh" ]; then
    ./scripts/count_sequences.sh "$FASTA_FILE"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to count sequences"
    fi
else
    echo "Error: count_sequences.sh not found or not executable"
fi
echo ""

# Script 2: Sequence lengths
echo "=== LENGTH STATISTICS ==="
if [ -x "./scripts/sequence_lengths.sh" ]; then
    ./scripts/sequence_lengths.sh "$FASTA_FILE"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to calculate lengths"
    fi
else
    echo "Error: sequence_lengths.sh not found or not executable"
fi
echo ""

# Script 3: Pattern extraction (interactive)
echo "=== PATTERN EXTRACTION ==="
read -p "Do you want to extract sequences by pattern? (y/n): " extract_choice

if [ "$extract_choice" = "y" ] || [ "$extract_choice" = "Y" ]; then
    read -p "Enter pattern to search for: " pattern
    
    if [ -z "$pattern" ]; then
        echo "Error: Empty pattern provided, skipping extraction"
    elif [ -x "./scripts/extract_by_pattern.sh" ]; then
        ./scripts/extract_by_pattern.sh "$FASTA_FILE" "$pattern"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to extract sequences"
        fi
    else
        echo "Error: extract_by_pattern.sh not found or not executable"
    fi
else
    echo "Skipping pattern extraction"
fi
echo ""

# Script 4: Organism distribution
echo "=== ORGANISM DISTRIBUTION (Top 10) ==="
if [ -x "./scripts/count_organisms.sh" ]; then
    ./scripts/count_organisms.sh "$FASTA_FILE" | head -10
    if [ $? -ne 0 ]; then
        echo "Error: Failed to count organisms"
    fi
else
    echo "Error: count_organisms.sh not found or not executable"
fi
echo ""

# Closing message
echo "=========================================="
echo "       Analysis Complete!"
echo "=========================================="