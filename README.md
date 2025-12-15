# FASTA File Inspector

A collection of bash scripts for analyzing FASTA files.

## What It Does

- Counts sequences in FASTA files
- Calculates sequence length statistics (average, longest, shortest)
- Extracts sequences by pattern matching
- Counts sequences per organism (UniProt format only)

## Requirements

- Linux or WSL (Windows Subsystem for Linux)
- Standard Unix tools: bash, grep, awk, sort

## Usage

### Master Script (runs everything)

```bash
./fasta_inspector.sh test_data/sample.fasta
```

### Individual Scripts

```bash
# Count sequences
./scripts/count_sequences.sh test_data/sample.fasta

# Get length statistics
./scripts/sequence_lengths.sh test_data/sample.fasta

# Extract sequences matching a pattern
./scripts/extract_by_pattern.sh test_data/sample.fasta "sapiens"

# Count organisms (UniProt format only)
./scripts/count_organisms.sh test_data/sample.fasta
```

## File Structure

```
fasta_inspector/
├── scripts/
│   ├── count_sequences.sh
│   ├── sequence_lengths.sh
│   ├── extract_by_pattern.sh
│   └── count_organisms.sh
├── test_data/
│   └── sample.fasta
├── fasta_inspector.sh
└── README.md
```

## How It Works

Each script processes FASTA files line by line:

- **count_sequences.sh** - Counts header lines (starting with `>`)
- **sequence_lengths.sh** - Tracks sequence lengths across multiple lines
- **extract_by_pattern.sh** - Filters sequences by header content
- **count_organisms.sh** - Parses organism names from UniProt headers (`OS=`)

The master script runs all analyses and presents organized results.

## Important Note

`count_organisms.sh` requires **UniProt format** FASTA headers:

```
>sp|P12345|PROT_HUMAN Protein name OS=Homo sapiens OX=9606
```

## Future Ideas

- Support for non-UniProt FASTA formats
- Save results to file option
- Handle compressed files (.gz)
- More detailed statistics

## Credits

Test data from UniProt. Built as part of learning computational biology with Linux.
