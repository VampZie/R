# Protein Structure Analysis - Extension of Exercise 1

This exercise is an application-based extension of Exercise 1 over protein structure data and sequence using statistical parameters.

---

**I am using PDB FASTA format file, PDB ID: 8Z73**

---

## Following are the tasks I'll be showing:

### 1. Statistical Parameters You Can Analyze  
**For Sequences (Primary Structure)**  
_Required packages_: `Biostrings` or `seqinr`

- Amino acid frequency or composition (e.g., % of Gly, Ala, etc.)
- Molecular weight of the sequence
- Isoelectric point (pI) and charge at different pH
- Hydrophobicity index (e.g., using Kyte-Doolittle scale)
- Shannon entropy (sequence complexity)
- Amino acid diversity / richness

### 2. Secondary structure composition (α-helix, β-sheet, coils)  
**For Sequences (Secondary Structure)**  
_Required packages_: `bio3d`

- Secondary structure composition (α-helix, β-sheet, coils)
- Ramachandran plot stats (phi/psi angle distribution)
- B-factor (flexibility of atoms)
   called temperature factor or atomic displacement parameter) measures the flexibility or movement of atoms in a crystal structure.
  FASTA files can't give B-factors (no atomic details)
  PDB files contain B-factors for each atom.
  summary(b_factors): Mean, median, min, max B-factor → how flexible the protein is overall.
  hist(b_factors): A histogram of flexibility across the protein.
  plot(b_factors): Line plot along atoms (peaks = flexible regions).
  Low B-factor (~10-20) → Stable, rigid part.
  High B-factor (>50) → Flexible, mobile loops or disordered regions.
- Hydrogen bond counts
- Accessible surface area (ASA)
- Contact maps and distance matrices
- RMSD / RMSF (for comparing structures or dynamics)
