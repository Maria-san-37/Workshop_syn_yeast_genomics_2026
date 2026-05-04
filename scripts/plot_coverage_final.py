import sys
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np

file_path = sys.argv[1]
df = pd.read_csv(file_path, sep="\t", header=None)
df.columns = ["chrom", "start", "end", "cov_norm"]

window_size = 1000
step_size = 100

def moving_window_weighted(df_chrom, window_size, step_size):
    starts = np.arange(df_chrom["start"].min(), df_chrom["end"].max(), step_size)
    bin_starts = df_chrom["start"].values
    bin_ends = df_chrom["end"].values
    cov = df_chrom["cov_norm"].values
    
    results = []
    for s in starts:
        e = s + window_size
        mask = (bin_starts < e) & (bin_ends > s)
        
        if not mask.any():
            results.append(0)
            continue
        
        overlap_start = np.maximum(bin_starts[mask], s)
        overlap_end = np.minimum(bin_ends[mask], e)
        overlap_len = overlap_end - overlap_start
        
        weighted_mean = (cov[mask] * overlap_len).sum() / overlap_len.sum()
        results.append(weighted_mean)
    
    return pd.DataFrame({"chrom": df_chrom["chrom"].iloc[0], "pos": starts, "cov_norm": results})

binned_list = []
for chrom, group in df.groupby("chrom"):
    binned_list.append(moving_window_weighted(group, window_size, step_size))

binned = pd.concat(binned_list, ignore_index=True)

# Calculate fold change from mean per chromosome
binned["fold_change"] = binned.groupby("chrom")["cov_norm"].transform(lambda x: x / x.mean())

sns.set(style="whitegrid")
g = sns.FacetGrid(binned, col="chrom", hue="chrom", col_wrap=3, 
                  sharex=False, sharey=False, height=4, palette="viridis")
g.map(plt.plot, "pos", "cov_norm", linewidth=0.9)

# Add reference line at 1.0 (mean)
for ax in g.axes.flat:
    ax.axhline(1.0, color="red", linestyle="--", linewidth=0.8, alpha=0.7)

g.set_axis_labels("Position (bp)", "Coverage (fold change from mean)")
g.set_titles("{col_name}")
plt.tight_layout()
plt.savefig("coverage_foldchange.png", dpi=150)
plt.show()
