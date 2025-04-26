rdt <- readAAStringSet("/home/vzscyborg/datasets/pdb8z73.fasta")
protein_seq <- as.character(rdt[[1]])
head(protein_seq)

#amino acid composition
aa_table <- table(strsplit(protein_seq, "")[[1]])
aa_freq <- aa_table / sum(aa_table)
aa_freq


#molecular weight
library(seqinr)
aa_weights <- c(
  A = 89.1,  R = 174.2, N = 132.1, D = 133.1, C = 121.2,
  Q = 146.2, E = 147.1, G = 75.1,  H = 155.2, I = 131.2,
  L = 131.2, K = 146.2, M = 149.2, F = 165.2, P = 115.1,
  S = 105.1, T = 119.1, W = 204.2, Y = 181.2, V = 117.1
)
aa_vec <- s2c(protein_seq) 
aa_vec <- aa_vec[aa_vec %in% names(aa_weights)]
mw_val <- sum(aa_weights[aa_vec]) - (length(aa_vec) - 1) * 18.02
cat("Molecular weight:", round(mw_val, 2), "Daltons\n")


#isoelectric point charge
library(seqinr)
aa_vec <- s2c(protein_seq)
pI <- computePI(aa_vec)
print(paste("Isoelectric Point (pI):", pI))

#hydrophobicity
kd_scale <- c(
  A = 1.8, R = -4.5, N = -3.5, D = -3.5, C = 2.5, 
  Q = -3.5, E = -3.5, G = -0.4, H = -3.2, I = 4.5, 
  L = 3.8, K = -3.9, M = 1.9, F = 2.8, P = -1.6, 
  S = -0.8, T = -0.7, W = -0.9, Y = -1.3, V = 4.2
) #Kyte-Doolittle hydrophobicity scale

kd <- function(seq) {
  values <- kd_scale[seq]
  mean(values, na.rm = TRUE)
}
hydrophobicity <- kd(strsplit(protein_seq, "")[[1]])
cat("Average Hydrophobicity (Kyte-Doolittle scale):", round(hydrophobicity, 3), "\n")


#shanon entropy
entropy <- function(seq) {
  freq <- table(seq) / length(seq)
  -sum(freq * log2(freq))
}

shannon <- entropy(strsplit(protein_seq, "")[[1]])
print(paste("Shannon Entropy:", shannon))

#richness
unique_aa <- length(unique(strsplit(protein_seq, "")[[1]]))
print(paste("Amino Acid Richness:", unique_aa))

#Secondary strcture composition (alpha type 1, beta type 5)
library(bio3d)
pdb <- read.pdb("8Z73")
sec_struct <- pdb$helix
print(sec_struct)

library(bio3d)
pdb <- read.pdb("/home/vzscyborg/datasets/8z73.pdb")
torsion_angles <- torsion.pdb(pdb)
phi_angles <- torsion_angles$phi
psi_angles <- torsion_angles$psi
plot(
  phi_angles, psi_angles,
  xlab = expression(phi~"(degrees)"),
  ylab = expression(psi~"(degrees)"),
  main = "Ramachandran Plot for 8Z73",
  xlim = c(-180, 180),
  ylim = c(-180, 180),
  pch = 20, col = "blue"
)
abline(h = 0, v = 0, lty = 2, col = "gray")

#B-factor calculation
b_factors <- pdb$atom$b
summary(b_factors)
hist(b_factors, 
     main="B-factor Distribution (Flexibility of Atoms)", 
     xlab="B-factor", 
     col="lightblue", 
     border="black")  # plot for b-factor distribution 

plot(b_factors, 
     type='l', 
     main="B-factor per Atom", 
     xlab="Atom Index", 
     ylab="B-factor",
     col="blue")  # plot for b factor along sequence

# hydrogen bond count
library(bio3d)
pdb <- read.pdb("/home/vzscyborg/datasets/8z73.pdb")
donors <- atom.select(pdb, elety = "N")
acceptors <- atom.select(pdb, elety = "O")
donor_coords <- matrix(pdb$xyz[donors$xyz], ncol = 3, byrow = TRUE)
acceptor_coords <- matrix(pdb$xyz[acceptors$xyz], ncol = 3, byrow = TRUE)
dists <- dist.xyz(donor_coords, acceptor_coords)
hbond_indices <- which(dists <= 3.5, arr.ind = TRUE)
cat("Estimated number of hydrogen bonds:", nrow(hbond_indices), "\n")

# accessible surface area
library(bio3d)
pdb <- read.pdb("/home/vzscyborg/datasets/8z73.pdb")
protein_only <- trim.pdb(pdb, type = "protein")
backbone_atoms <- atom.select(protein_only, elety = c("N", "CA", "C", "O"))
protein_backbone <- trim.pdb(protein_only, backbone_atoms)
asa_result <- dssp(protein_only)
head(asa_result$acc)
total_asa <- sum(asa_result$acc, na.rm = TRUE)
cat("Total Accessible Surface Area (ASA):", total_asa, "Å²\n")
# if output is No residue found, choose another protein structure not partial one.

#RMSD
library(bio3d)
pdb <- read.pdb("/home/vzscyborg/datasets/8z73.pdb")
ca.inds <- atom.select(pdb, "calpha") #Select protein atoms (backbone or C-alpha atoms usually)
rmsd_val <- rmsd(pdb$xyz[ca.inds$xyz], pdb$xyz[ca.inds$xyz])
cat("RMSD (self comparison):", rmsd_val, "\n") #RMD calculated

#RMSF
ca.inds <- atom.select(pdb, "calpha")
xyz <- pdb$xyz[ca.inds$xyz]
traj <- rbind(xyz, xyz + rnorm(length(xyz), 0, 0.5))
rmsf_val <- rmsf(traj)
plot(rmsf_val, type = "h", main = "RMSF per residue", xlab = "Residue", ylab = "Fluctuation (Å)")