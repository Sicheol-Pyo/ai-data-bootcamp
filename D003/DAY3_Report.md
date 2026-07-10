# 옷장패션 데이터 정제 보고서

## 1. 데이터 개요
- 행/열: 1,500 × 8
- 주요 컬럼: order_id, customer_age, category, channel, price, quantity, amount, return_amount

- column 별 data type
1. oder_id / str
2. customer_age / int
3. category / str
4. channel / str
5. price / float
6. quantity / int
7. amount / float
8. return_amount / float


## 2. 진단 결과
- 결측: amount 3.4%, price 0.3% 그외 column 결측치 없음.
- 이상치(IQR): customer_age(0, 2건 / 999·0, 3건), quantity(200, 1건), amount(50,000,000, ___건)
- 의심되는 결측 유형: amount는 app 채널에 쏠림 → MAR

## 3. 처리 결정과 근거
| 이슈 | 결정 | 근거 | 한계 |
| --- | --- | --- | --- |
| amount 결측 | 채널별 중앙값 대체 | MAR 가설 부합 | ... |
| ... | ... | ... | ... |

## 4. 처리 후 검증
- 결측 0건(설계상 NaN 유지가 필요한 컬럼 제외)
- customer_age 범위: __ ~ __ (정상)
- amount_outlier 플래그 ___건 보존

## 5. 후속 권고
- (도매 가능 고객 식별을 위해 customer_id 단위 과거 이력 확보 필요 등)

