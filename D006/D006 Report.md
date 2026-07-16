# ===== 데이터 정제 리포트 =====

## ▸ 입력 행 수: 1,500
## ▸ 출력 행 수: 1,500
## ▸ 제거된 비율: 0.00%

## ▸ 컬럼별 결측 비율(상위 5개)
- amount                 4.0
- amount_scaled          4.0
- customer_age_scaled    2.1
- customer_age           2.1
- order_id               0.0
- dtype: float64

## ▸ 새로 만들어진 파생/인코딩 컬럼 수: 16
- 신규 생성: ['amount_scaled', 'category_가전', 'category_도서', 'category_뷰티', 'category_식품', 'category_패션', 'customer_age_scaled', 'price_scaled', 'quantity_scaled', 'region_경기', 'region_대구', 'region_부산', 'region_서울', 'region_인천']
- 기존 컬럼 인코딩: ['membership', 'channel']

## ▸ 자료형 분포 요약
- int64      13
- float64     6
- str         1
- Int64       1
Name: count, dtype: int64