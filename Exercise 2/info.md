# 🧬 Protein Structure Analysis - Extension of Exercise 1

This exercise is an **application-based extension** of **Exercise 1** over **protein structure data** and **sequence analysis** using **statistical parameters**.

---

**🔹 I am using PDB FASTA format file, PDB ID: `8Z73`**

---

## 📌 Following are the tasks I'll be showing:

---

### 1️⃣ Statistical Parameters You Can Analyze  
**For Sequences (Primary Structure)**  
_Required packages_: `Biostrings` or `seqinr`

- Amino acid frequency or composition (e.g., % of Gly, Ala, etc.)
- Molecular weight of the sequence
- Isoelectric point (pI) and charge at different pH
- Hydrophobicity index (e.g., using Kyte-Doolittle scale)
- Shannon entropy (sequence complexity)
- Amino acid diversity / richness

---

### 2️⃣ Secondary Structure Composition (α-helix, β-sheet, coils)  
**For Sequences (Secondary Structure)**  
_Required packages_: `bio3d`

- Secondary structure composition:
  - `start`: The starting residue number of a secondary structure (like a helix or sheet)
  - `end`: The ending residue number of that structure
  - `chain`: The chain ID (e.g., "A", "B", "D", "F" — different chains in the protein)
  - `type`: Type of secondary structure

- Ramachandran plot stats (phi/psi angle distribution)

- **B-Factor (Flexibility of Atoms)**  
  *(also called temperature factor or atomic displacement parameter)*

  - Measures the flexibility or movement of atoms in a crystal structure.
  - **Important**:
    - FASTA files ❌ can't provide B-factors (no atomic details).
    - PDB files ✅ contain B-factors for each atom.
  
  - **Summary Statistics** (`summary(b_factors)`):
    - Mean, median, minimum, maximum B-factors → How flexible the protein is overall.
  
  - **Histogram** (`hist(b_factors)`):
    - Shows flexibility distribution across the protein.

  - **Line Plot** (`plot(b_factors)`):
    - Plots B-factor values along atoms.
    - **Peaks** → Flexible regions.
  
  - **Interpretation**:
    - Low B-factor (~10–20) → Stable, rigid parts.
    - High B-factor (>50) → Flexible, mobile loops or disordered regions.

- Hydrogen bond counts
- Accessible surface area (ASA)
- Contact maps and distance matrices
- RMSD / RMSF (for comparing structures or dynamics)
   - For single structure, rmsd is 0.
