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
- 이상치(IQR): customer_age(0, 2건 / 999·0, 3건), quantity(200, 1건), amount(25,9800, 95건 / 38,9700, 49건 / 50,000,000, 1건)
- 의심되는 결측 유형:
1. customer_age 0의 2건, 999 3건의 경우 channel 'web'에서만 확인되었음, 'web'에서만 해당 오류가 발생한 원인 파악이 필요할 것 같음 MAR
2. quantity '200'의 경우 price '29900' amount '89700'을 보았을 때 2의 오기로 200이 입력된 것으로 추측됨. MCAR
3. amount '25,9800', '38,9700'의 경우 price와 quantity를 비교하였을 때 정상 값으로 확인됨 다만, '50,000,000'의 경우 price '49900.0'	amount '1'로 값 오류로 추측됨. MCAR
4. amount는 app 89건(61.4%) wep은 67건(38.6%)으로 채널에 쏠림 → MAR (다만, price, quantity 비교 amount 값이 정상인 경우를 제외하면 app 1건)

## 3. 처리 결정과 근거
amount 결측
| 이슈 : amount 51개 결측으로 확인되었음.
| 결정 : amount 결측으로 확인된 항목들은 price, quantity를 기준으로 계산된 값으로 계산 가능하지만 해당 값들은 모두 결측으로 유지하고 분석에서 제외함.
| 근거 : price * quantity로 amount가 추측 가능하오나 amount가 결측으로 확인된 order_id의 price와 quantity의 오류가 없다고 판단할 수 없음.
| 한계 : 결국 결측으로 확인되거나 입력 오류가 확인된 부분들은 보수적인 관점에서 데이터 재 조사가 필요함.

customer_age
| 이슈: 0 2건, 999 3건 이상치 확인됨.
| 결정 : 5건의 이상치는 결측 처리 및 분석 제외함.
| 한계 : 해당 이상치는 channel 'wep'에서 확인되었으며, web에서의 나이 입력 시 오류가 있는지 또는 수정이 가능한지 확인 필요하며 현 상황으로선 대체가 불가능함.
| 근거 : data 수집 당시 order_id별 생년월일 및 주문시점 날짜등이 수집되지 않아 실질적인 나이 검증이 불가능한 상태이며, web 등록 당시 나이만 확인 가능하여 대체 불가능함.

## 4. 처리 후 검증
- 결측 amount 51건, price 5건으로 동(설계상 NaN 유지가 필요한 컬럼 제외)
- customer_age 범위: 5 ~ 60 (outlier 기준 12세 미만은 이상치에 해당하오나 범위에 포함)
- amount_outlier 플래그 < -75600.0 or > 253200.0 144건 보존

## 5. 후속 권고
- (도매 가능 고객 식별을 위해 customer_id 단위 과거 이력 확보 필요 등)
- 생년월일 및 주문날짜 등을 추가하여 customer_age 및 data 관리의 편의성을 높이면 좋을 것 같습니다.
- return_amount의 경우 return된 개수가 함께 수집되어 data 추가 검증 필요할 것 같습니다.

