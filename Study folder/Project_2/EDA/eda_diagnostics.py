"""
EDA_Pipeline 1단계 진단 스크립트.
사용법: python eda_diagnostics.py <입력 파일 경로(.csv 또는 .json)> [--natural-key col1,col2,...] [--exclude-outlier col1,col2,...]

데이터셋이 바뀔 때마다 아래 두 값을 확인/수정한다 (또는 CLI 인자로 override).
"""
import sys
import argparse
import numpy as np
import pandas as pd

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

# ==== 데이터셋이 바뀔 때마다 사용자가 직접 확인/수정 ====
NATURAL_KEY_COLUMNS = []       # 예: ['id']  또는 ['person', 'event', 'time', 'value']
OUTLIER_EXCLUDE_COLUMNS = []   # 예: ['became_member_on'] (날짜가 정수로 인코딩된 컬럼 등)
# ========================================================


def load_data(path):
    if path.lower().endswith(".json"):
        try:
            return pd.read_json(path, orient="records", lines=True)
        except ValueError:
            return pd.read_json(path)
    return pd.read_csv(path)


def to_hashable(df):
    df2 = df.copy()
    for c in df2.columns:
        if df2[c].apply(lambda v: isinstance(v, (list, dict))).any():
            df2[c] = df2[c].astype(str)
    return df2


def dtype_label(series):
    s = series.dropna()
    if pd.api.types.is_bool_dtype(series.dtype):
        return "bool"
    if pd.api.types.is_integer_dtype(series.dtype):
        return "int64"
    if pd.api.types.is_float_dtype(series.dtype):
        return "float64"
    if pd.api.types.is_datetime64_any_dtype(series.dtype):
        return "datetime64"
    if len(s) > 0:
        sample = s.iloc[0]
        if isinstance(sample, dict):
            return "object(dict)"
        if isinstance(sample, list):
            return "object(list)"
    return "object(str)"


def print_overview(df):
    print("=== 1. 데이터 개요 ===")
    print(f"행/열: {df.shape[0]} x {df.shape[1]}")
    print()
    print("순번 | 컬럼명(원본) | Datatype")
    for i, col in enumerate(df.columns, 1):
        print(f"{i} | {col} | {dtype_label(df[col])}")
    print()


def detect_group_columns(df, exclude):
    candidates = []
    for col in df.columns:
        if col in exclude:
            continue
        series = df[col]
        if series.apply(lambda v: isinstance(v, (list, dict))).any():
            continue
        nun = series.nunique(dropna=True)
        if 1 < nun <= 20:
            candidates.append(col)
    return candidates


def print_missing(df):
    print("=== 2. 진단 결과 - 결측 ===")
    miss = df.isna().sum()
    miss = miss[miss > 0].sort_values(ascending=False)
    if miss.empty:
        print("결측 컬럼 없음 (0건)")
        print()
        return
    print("컬럼명 | 결측 개수 | 결측률(%)")
    for col, cnt in miss.items():
        pct = cnt / len(df) * 100
        print(f"{col} | {cnt} | {pct:.2f}")
    print()

    group_cols = detect_group_columns(df, exclude=set(miss.index))
    if group_cols:
        top_col = miss.index[0]
        for gcol in group_cols:
            print(f"-- 그룹별 결측률 ({top_col} 기준, 그룹 컬럼: {gcol}) --")
            print("그룹값 | 결측률(%)")
            grp = df.groupby(gcol, dropna=False)[top_col].apply(lambda s: s.isna().mean() * 100)
            for gv, pct in grp.items():
                print(f"{gv} | {pct:.2f}")
            print()
    else:
        print("(그룹/시간 변수 후보 없음 → 그룹별 결측률 표 생략)")
        print()


def find_id_column(df):
    for col in df.columns:
        series = df[col]
        if series.apply(lambda v: isinstance(v, (list, dict))).any():
            continue
        if series.nunique(dropna=True) == len(df) and (df[col].dtype == object or "id" in col.lower() or "person" in col.lower() or "name" in col.lower()):
            return col
    return None


def print_outliers(df, exclude_cols):
    print("=== 2. 진단 결과 - 이상치 ===")
    numeric_cols = [c for c in df.columns if pd.api.types.is_numeric_dtype(df[c]) and not pd.api.types.is_bool_dtype(df[c]) and c not in exclude_cols]
    if not numeric_cols:
        print("수치형 컬럼 없음 (분석 대상 없음)")
        print()
        return

    id_col = find_id_column(df)
    print("컬럼명 | 유효건수 | 왜도 | IQR 건수(%) | Z-score 건수(%) | MAD 건수(%)")
    top5_records = {}
    for col in numeric_cols:
        s = df[col].dropna()
        n = len(s)
        skew = s.skew()

        q1, q3 = s.quantile(0.25), s.quantile(0.75)
        iqr = q3 - q1
        lo, hi = q1 - 1.5 * iqr, q3 + 1.5 * iqr
        iqr_mask = (s < lo) | (s > hi)
        iqr_pct = iqr_mask.mean() * 100

        mean, std = s.mean(), s.std()
        if std == 0:
            z_mask = pd.Series(False, index=s.index)
        else:
            z = (s - mean) / std
            z_mask = z.abs() > 3
        z_pct = z_mask.mean() * 100

        median = s.median()
        mad = (s - median).abs().median()
        if mad == 0:
            mad_mask = pd.Series(False, index=s.index)
        else:
            mod_z = 0.6745 * (s - median) / mad
            mad_mask = mod_z.abs() > 3.5
        mad_pct = mad_mask.mean() * 100

        print(f"{col} | {n} | {skew:.4f} | {iqr_pct:.2f} | {z_pct:.2f} | {mad_pct:.2f}")

        if id_col:
            top5_records[col] = {
                "IQR": df.loc[s[iqr_mask].index].nlargest(5, col)[[id_col, col]] if iqr_mask.any() else None,
                "Z-score": df.loc[s[z_mask].index].nlargest(5, col)[[id_col, col]] if z_mask.any() else None,
                "MAD": df.loc[s[mad_mask].index].nlargest(5, col)[[id_col, col]] if mad_mask.any() else None,
            }
    print()

    if id_col and top5_records:
        print(f"-- 방법별 상위 이상치 5건 (식별 컬럼: {id_col}) --")
        for col, methods in top5_records.items():
            for method, tbl in methods.items():
                if tbl is None or tbl.empty:
                    continue
                print(f"[{col} / {method}]")
                print(f"{id_col} | {col}")
                for _, row in tbl.iterrows():
                    print(f"{row[id_col]} | {row[col]}")
                print()


def print_duplicates(df, natural_key_columns):
    print("=== 2. 진단 결과 - 중복 ===")
    hdf = to_hashable(df)
    full_dup = hdf.duplicated().sum()
    print("기준 | 중복 행 수")
    print(f"전체 행 기준 | {full_dup}건")

    if natural_key_columns:
        nk_dup_mask = hdf.duplicated(subset=natural_key_columns, keep=False)
        nk_dup_count = hdf.duplicated(subset=natural_key_columns, keep="first").sum()
        print(f"자연키({', '.join(natural_key_columns)}) 기준 | {nk_dup_count}건")
        print()
        if nk_dup_count > 0:
            print(f"-- 자연키({', '.join(natural_key_columns)}) 중복 행 전체 --")
            print(" | ".join(natural_key_columns) + " | 중복 횟수")
            dup_rows = hdf[nk_dup_mask]
            counts = dup_rows.groupby(natural_key_columns).size()
            for keys, cnt in counts.items():
                keys = keys if isinstance(keys, tuple) else (keys,)
                print(" | ".join(str(k) for k in keys) + f" | {cnt}")
            print()
    else:
        print("자연키(NATURAL_KEY_COLUMNS) 미지정 | -")
        print()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("path")
    parser.add_argument("--natural-key", default=None)
    parser.add_argument("--exclude-outlier", default=None)
    args = parser.parse_args()

    natural_key = args.natural_key.split(",") if args.natural_key else NATURAL_KEY_COLUMNS
    exclude_outlier = args.exclude_outlier.split(",") if args.exclude_outlier else OUTLIER_EXCLUDE_COLUMNS

    df = load_data(args.path)

    print_overview(df)
    print_missing(df)
    print_outliers(df, set(exclude_outlier))
    print_duplicates(df, natural_key)


if __name__ == "__main__":
    main()
