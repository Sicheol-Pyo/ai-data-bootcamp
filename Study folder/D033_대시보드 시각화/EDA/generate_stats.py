import pandas as pd

DATA_PATH = "Dataset/TB_Burden_Country.csv"
df = pd.read_csv(DATA_PATH)

COLUMNS = [
    ("Estimated total population number", "Population"),
    ("Estimated prevalence of TB (all forms) per 100 000 population", "Prevalence"),
    ("Estimated incidence (all forms) per 100 000 population", "Incidence"),
    ("Estimated number of deaths from TB (all forms, excluding HIV)", "Deaths"),
    ("Case detection rate (all forms), percent", "CaseDetectionRate"),
]

regions = sorted(df["Region"].dropna().unique())

for col, label in COLUMNS:
    print(f"### {label} ({col}) - Region별 기초 통계량\n")
    print("| Region | 평균 | 중앙값 | 표준편차 | Q1 | Q3 |")
    print("|---|---|---|---|---|---|")
    for region in regions:
        s = df.loc[df["Region"] == region, col].dropna()
        print(f"| {region} | {s.mean():.2f} | {s.median():.2f} | {s.std():.2f} | {s.quantile(.25):.2f} | {s.quantile(.75):.2f} |")
    print()
