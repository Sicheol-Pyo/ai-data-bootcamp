import os
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

DATA_PATH = "Dataset/TB_Burden_Country.csv"
OUT_DIR = "EDA/images"
os.makedirs(OUT_DIR, exist_ok=True)

df = pd.read_csv(DATA_PATH)

INCIDENCE = "Estimated incidence (all forms) per 100 000 population"
PREVALENCE = "Estimated prevalence of TB (all forms) per 100 000 population"
MORTALITY = "Estimated mortality of TB cases (all forms, excluding HIV) per 100 000 population"
CASE_DETECTION = "Case detection rate (all forms), percent"
POPULATION = "Estimated total population number"

def save(fig, name):
    path = os.path.join(OUT_DIR, name)
    fig.savefig(path, dpi=110, bbox_inches="tight")
    plt.close(fig)
    print(f"saved: {path}")

def dist_chart(col, name, log_x=False):
    data = df[col].dropna()
    fig, axes = plt.subplots(1, 2, figsize=(10, 4))
    axes[0].hist(data, bins=40, color="#4C72B0")
    if log_x:
        axes[0].set_xscale("log")
    axes[0].set_title(f"Histogram: {col}")
    axes[1].boxplot(data)
    axes[1].set_title(f"Boxplot: {col}")
    fig.tight_layout()
    save(fig, name)

def region_hist_grid(col, name):
    regions = sorted(df["Region"].dropna().unique())
    fig, axes = plt.subplots(2, 3, figsize=(13, 7))
    for ax, region in zip(axes.flat, regions):
        data = df.loc[df["Region"] == region, col].dropna()
        ax.hist(data, bins=30, color="#4C72B0")
        ax.set_title(region)
    fig.suptitle(f"Histogram by Region: {col}")
    fig.tight_layout()
    save(fig, name)

region_hist_grid(INCIDENCE, "dist_incidence_by_region.png")
dist_chart(CASE_DETECTION, "dist_case_detection.png")
dist_chart(POPULATION, "dist_population.png", log_x=True)

corr_cols = [PREVALENCE, INCIDENCE, MORTALITY, CASE_DETECTION]
corr = df[corr_cols].corr()
fig, ax = plt.subplots(figsize=(6, 5))
im = ax.imshow(corr, cmap="coolwarm", vmin=-1, vmax=1)
ax.set_xticks(range(len(corr_cols)))
ax.set_yticks(range(len(corr_cols)))
short_labels = ["Prevalence", "Incidence", "Mortality", "CaseDetectionRate"]
ax.set_xticklabels(short_labels, rotation=45, ha="right")
ax.set_yticklabels(short_labels)
for i in range(len(corr_cols)):
    for j in range(len(corr_cols)):
        ax.text(j, i, f"{corr.iloc[i, j]:.2f}", ha="center", va="center", color="black")
fig.colorbar(im, ax=ax)
ax.set_title("Correlation matrix: core TB indicators")
fig.tight_layout()
save(fig, "corr_heatmap.png")

def region_box_chart(col, name):
    fig, ax = plt.subplots(figsize=(8, 5))
    regions = sorted(df["Region"].dropna().unique())
    data = [df.loc[df["Region"] == r, col].dropna() for r in regions]
    ax.boxplot(data, tick_labels=regions)
    ax.set_title(f"By Region: {col}")
    ax.set_ylabel(col)
    fig.tight_layout()
    save(fig, name)

region_box_chart(INCIDENCE, "region_box_incidence.png")
region_box_chart(CASE_DETECTION, "region_box_case_detection.png")

def set_xticks_with_last(ax, years):
    last_year = years.max()
    ticks = sorted(set(ax.get_xticks().tolist()) | {last_year})
    ticks = [t for t in ticks if years.min() <= t <= last_year]
    ax.set_xticks(ticks)

def timeseries_chart(col, name):
    yearly = df.groupby("Year")[col].mean()
    fig, ax = plt.subplots(figsize=(8, 4.5))
    ax.plot(yearly.index, yearly.values, marker="o", color="#4C72B0")
    ax.set_title(f"Yearly mean: {col}")
    ax.set_xlabel("Year")
    ax.set_ylabel(col)
    set_xticks_with_last(ax, yearly.index)
    fig.tight_layout()
    save(fig, name)

timeseries_chart(INCIDENCE, "timeseries_incidence.png")
timeseries_chart(CASE_DETECTION, "timeseries_case_detection.png")

fig, ax = plt.subplots(figsize=(9, 5))
for region, sub in df.groupby("Region"):
    yearly = sub.groupby("Year")[INCIDENCE].mean()
    ax.plot(yearly.index, yearly.values, marker="o", label=region)
ax.set_title(f"By Region, yearly mean: {INCIDENCE}")
ax.set_xlabel("Year")
ax.set_ylabel(INCIDENCE)
set_xticks_with_last(ax, df["Year"])
ax.legend()
fig.tight_layout()
save(fig, "timeseries_region_incidence.png")

print("done")
