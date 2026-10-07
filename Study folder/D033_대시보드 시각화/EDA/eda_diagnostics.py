import sys
import pandas as pd
import numpy as np

# ==== 데이터셋별 설정 (데이터가 바뀌면 이 부분만 확인/수정) ====
NATURAL_KEY_COLUMNS = ['Country or territory name', 'Year']  # 행을 고유하게 식별하는 컬럼 조합
OUTLIER_EXCLUDE_COLUMNS = ['ISO numeric country/territory code', 'Year']  # 이상치 분석에서 제외할 식별자/차원 컬럼
# ================================================================

def compute_missing(df):
    rows = []
    for col in df.columns:
        n_missing = int(df[col].isna().sum())
        if n_missing > 0:
            rows.append((col, n_missing, round(n_missing/len(df)*100, 2)))
    rows.sort(key=lambda x: -x[1])
    return rows

def iqr_flag(s):
    q1, q3 = s.quantile(.25), s.quantile(.75)
    iqr = q3 - q1
    return (s < q1-1.5*iqr) | (s > q3+1.5*iqr)

def z_flag(s):
    z = (s - s.mean())/s.std()
    return z.abs() > 3

def mad_flag(s):
    med = s.median()
    mad = (s-med).abs().median()
    if mad == 0:
        return pd.Series(False, index=s.index)
    mz = 0.6745*(s-med)/mad
    return mz.abs() > 3.5

def compute_outliers(df):
    rows = []
    numeric_cols = df.select_dtypes(include=[np.number]).columns
    for col in numeric_cols:
        if col in OUTLIER_EXCLUDE_COLUMNS:
            continue
        s = df[col].dropna()
        n = len(s)
        if n == 0:
            continue
        i = int(iqr_flag(s).sum())
        z = int(z_flag(s).sum())
        m = int(mad_flag(s).sum())
        rows.append((col, n, i, round(i/n*100,2), z, round(z/n*100,2), m, round(m/n*100,2)))
    return rows

def compute_duplicates(df):
    full_dup = int(df.duplicated().sum())
    key_dup = None
    if all(c in df.columns for c in NATURAL_KEY_COLUMNS):
        key_dup = int(df.duplicated(subset=NATURAL_KEY_COLUMNS).sum())
    return full_dup, key_dup

def main():
    path = sys.argv[1]
    df = pd.read_csv(path)

    print(f"# 진단 결과 (입력: {path})\n")
    print(f"행/열: {df.shape[0]} x {df.shape[1]}\n")

    print("## 결측값\n")
    print("| 컬럼명 | 결측 개수 | 결측률(%) |")
    print("|---|---|---|")
    for col, cnt, pct in compute_missing(df):
        print(f"| {col} | {cnt} | {pct} |")

    print("\n## 이상치 (IQR / Z-score / MAD)\n")
    print("| 컬럼명 | 유효건수 | IQR 건수(%) | Z-score 건수(%) | MAD 건수(%) |")
    print("|---|---|---|---|---|")
    for col, n, i, ip, z, zp, m, mp in compute_outliers(df):
        print(f"| {col} | {n} | {i}({ip}%) | {z}({zp}%) | {m}({mp}%) |")

    print("\n## 중복\n")
    full_dup, key_dup = compute_duplicates(df)
    print("| 기준 | 중복 행 수 |")
    print("|---|---|")
    print(f"| 전체 행 기준 | {full_dup}건 |")
    if key_dup is not None:
        print(f"| 자연키({' + '.join(NATURAL_KEY_COLUMNS)}) 기준 | {key_dup}건 |")

if __name__ == '__main__':
    main()
