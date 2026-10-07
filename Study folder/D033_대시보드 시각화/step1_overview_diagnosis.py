import pandas as pd
import numpy as np
from scipy import stats
import os
from datetime import datetime

# 데이터 로드
data_path = "Dataset/TB_Burden_Country.csv"
df = pd.read_csv(data_path)

# 출력 디렉토리 생성
output_dir = "EDA"
os.makedirs(output_dir, exist_ok=True)

# 리포트 파일 경로
report_path = os.path.join(output_dir, "TB_Burden_Country_EDA_Report.md")

# 리포트 내용 작성
report = []

report.append("# TB_Burden_Country 탐색적 데이터 분석 보고서\n")
report.append(f"**작성일**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")

# 1. 데이터 개요
report.append("## 1. 데이터 개요\n")
report.append(f"- 행/열: {df.shape[0]:,} 행 × {df.shape[1]} 열\n")
report.append(f"- 주요 컬럼: {', '.join(df.columns[:10].tolist())}" +
              (f"... (총 {df.shape[1]}개 컬럼)" if df.shape[1] > 10 else "") + "\n\n")

# Column별 data type
report.append("- **Column별 Data Type**\n\n")
report.append("| 번호 | 컬럼명(원본) | Datatype |\n")
report.append("|---|---|---|\n")
for i, (col, dtype) in enumerate(df.dtypes.items(), 1):
    report.append(f"| {i} | {col} | {dtype} |\n")

report.append("\n")

# 2. 진단 결과
report.append("## 2. 진단 결과\n\n")

# 2.1 결측값 분석
report.append("### 2.1 결측값 분석\n\n")
missing_info = pd.DataFrame({
    '컬럼명': df.columns,
    '결측값 개수': df.isnull().sum().values,
    '결측률(%)': (df.isnull().sum().values / len(df) * 100).round(2)
})
missing_info = missing_info[missing_info['결측값 개수'] > 0]

if len(missing_info) > 0:
    report.append("| 컬럼명 | 결측값 개수 | 결측률(%) |\n")
    report.append("|---|---|---|\n")
    for _, row in missing_info.iterrows():
        report.append(f"| {row['컬럼명']} | {int(row['결측값 개수'])} | {row['결측률(%)']} |\n")
else:
    report.append("**결측값 없음** - 모든 컬럼에서 결측값이 발견되지 않았습니다.\n")

report.append("\n")

# 2.2 이상치 분석
report.append("### 2.2 이상치 분석\n\n")
report.append("**IQR, Z-score, MAD 방법으로 이상치 검출**\n\n")

# 수치형 컬럼만 선택
numeric_cols = df.select_dtypes(include=[np.number]).columns.tolist()

outlier_results = []

for col in numeric_cols:
    data = df[col].dropna()
    if len(data) == 0:
        continue

    # IQR 방법
    Q1 = data.quantile(0.25)
    Q3 = data.quantile(0.75)
    IQR = Q3 - Q1
    iqr_outliers = ((data < Q1 - 1.5*IQR) | (data > Q3 + 1.5*IQR)).sum()
    iqr_pct = (iqr_outliers / len(data) * 100)

    # Z-score 방법
    z_scores = np.abs(stats.zscore(data))
    z_outliers = (z_scores > 3).sum()
    z_pct = (z_outliers / len(data) * 100)

    # MAD 방법
    median = data.median()
    mad = stats.median_abs_deviation(data)
    if mad != 0:
        modified_z_scores = 0.6745 * (data - median) / mad
        mad_outliers = (np.abs(modified_z_scores) > 3.5).sum()
        mad_pct = (mad_outliers / len(data) * 100)
    else:
        mad_outliers = 0
        mad_pct = 0.0

    outlier_results.append({
        '컬럼명': col,
        '유효건수': len(data),
        'IQR건수(%)': f"{iqr_outliers}({iqr_pct:.2f}%)",
        'Z-score건수(%)': f"{z_outliers}({z_pct:.2f}%)",
        'MAD건수(%)': f"{mad_outliers}({mad_pct:.2f}%)"
    })

if len(outlier_results) > 0:
    report.append("| 컬럼명 | 유효건수 | IQR 건수(%) | Z-score 건수(%) | MAD 건수(%) |\n")
    report.append("|---|---|---|---|---|\n")
    for row in outlier_results:
        report.append(f"| {row['컬럼명']} | {row['유효건수']} | {row['IQR건수(%)']} | {row['Z-score건수(%)']} | {row['MAD건수(%)']} |\n")
else:
    report.append("**수치형 컬럼 없음** - 이상치 분석을 수행할 수 없습니다.\n")

report.append("\n")

# 2.3 중복 분석
report.append("### 2.3 중복 분석\n\n")
total_duplicates = df.duplicated().sum()
report.append(f"| 기준 | 중복 행 수 |\n")
report.append("|---|---|\n")
report.append(f"| 전체 행 기준 | {total_duplicates}건 |\n")

if total_duplicates > 0:
    report.append("\n**중복된 행 상세:**\n")
    dup_rows = df[df.duplicated(keep=False)].sort_values(by=list(df.columns))
    report.append("\n```\n")
    report.append(dup_rows.to_string())
    report.append("\n```\n")
else:
    report.append("\n**중복 없음** - 전체 행 기준 완벽하게 일치하는 중복이 없습니다.\n")

report.append("\n")

# 2.4 특이사항
report.append("### 2.4 특이사항\n\n")

special_notes = []

# 상수 컬럼 확인
for col in df.columns:
    if df[col].nunique() == 1:
        special_notes.append(f"- **{col}**: 모든 값이 동일 (상수 컬럼) - 값: {df[col].iloc[0]}")

# 객체형 컬럼의 고유값 개수
object_cols = df.select_dtypes(include='object').columns
for col in object_cols:
    unique_count = df[col].nunique()
    if unique_count > 50:
        special_notes.append(f"- **{col}**: 고유값이 많음 ({unique_count}개)")

if special_notes:
    for note in special_notes:
        report.append(note + "\n")
else:
    report.append("발견된 특이사항이 없습니다.\n")

report.append("\n---\n\n")
report.append("### 📌 1단계 완료\n")
report.append("**위 진단 결과를 검토한 후, 데이터 처리 방향에 대한 의견을 제시해주세요.**\n")
report.append("- 결측값 처리 방안\n")
report.append("- 이상치 처리 방안\n")
report.append("- 중복 제거 여부\n\n")

# 리포트 저장
with open(report_path, 'w', encoding='utf-8') as f:
    f.writelines(report)

print(f"✓ 1단계 완료: {report_path}")
print(f"\n데이터 요약:")
print(f"  - 전체 행: {df.shape[0]:,}")
print(f"  - 전체 열: {df.shape[1]}")
print(f"  - 결측값 컬럼: {len(missing_info)if len(missing_info) > 0 else 0}")
print(f"  - 중복 행: {total_duplicates}")
