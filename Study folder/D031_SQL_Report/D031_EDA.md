# Amazon Sales Dataset 데이터 정제 보고서

## 1. 데이터 개요
- 행/열: 1,465 × 16
- 주요 컬럼: product_id, product_name, category, discounted_price, actual_price, discount_percentage, rating, rating_count, about_product, user_id, user_name, review_id, review_title, review_content, img_link, product_link

- column 별 data type
1. product_id TEXT
2. product_name TEXT
3. category TEXT
4. discounted_price TEXT
5. actual_price TEXT
6. discount_percentage TEXT
7. rating TEXT
8. rating_count TEXT
9. about_product TEXT
10. user_id TEXT
11. user_name TEXT
12. review_id TEXT
13. review_title TEXT
14. review_content TEXT
15. img_link TEXT
16. product_link TEXT

## 2. 진단 결과
- 결측: product_id B0B94JPY2N, B0BQRJ3C47의 rating_count 결측
- 이상치: product_id B08L12N5H1의 rating | 로 오기
- 중복: 일부 product_id에서 img_link가 달라 중복 확인됨.
- 특이사항: category의 값에 ‘|’를 기준으로 최대 6개까지 분류가 나눠지는 것으로 확인.

## 3. 처리 결정과 근거
### (1)discounted_price, actual_price 루피 기호(₹) 삭제 및 type 변경
| 이슈 : discounted_price, actual_price에 루피 기호(₹)로 인하여 계산식 설정이 불가함.
| 결정 : 루피 기호(₹) 삭제 및 TEXT Type을 DECIMAL(10,2)로 변경함.
| 근거 : 해당 데이터 기준 지표 및 분석을 위하여 변경함.
| 한계 : 루피 기호(₹)의 경우 데이터에 직접 수집하지 않고 컬럼명에 명시하는 방법으로 추후 수정하여 분석 및 리뷰에 용이하도록 조치가 필요함.

### (2)discount_percentage % 기호 삭제 및 type 변경
| 이슈: % 기호로 인하여 계산식 설정이 불가함.
| 결정 : % 기호 삭제 및 TEXT Type을 Int로 변경함.
| 근거 : 해당 데이터 기준 지표 및 분석을 위하여 변경함.
| 한계 : % 기호의 경우 데이터에 직접 수집하지 않고 컬럼명에 명시하는 방법으로 추후 수정하여 분석 및 리뷰에 용이하도록 조치가 필요함.

### (3)rating "|" 값 Null 변경
| 이슈: product_id B08L12N5H1의 rating '|' 로 오기 확인됨.
| 결정 : type 변경 및 분석을 위해 '|' Null로 변경.
| 근거 : 해당 데이터 기준 지표 및 분석을 위하여 변경함.
| 한계 : '|' 데이터의 수집 경위를 파악하고 추가적으로 이상 값이 수집될 수 있는지 점검 필요하며 추후 분석 시에도 해당 전처리 작업 필수.

### (4)rating_count "" 값 Null 변경
| 이슈: product_id B0B94JPY2N, B0BQRJ3C47의 rating_count ""로 결측 확인됨.
| 결정 : ""의 경우 SQL상 Null로 집계되지 않고 Type 변경 시 에러가 발생하여 Null로 변경.
| 근거 : 해당 데이터 기준 지표 및 분석을 위하여 변경함.
| 한계 : "" 데이터의 수집 경위를 파악하고 추가적으로 이상 값이 수집될 수 있는지 점검 필요하며 추후 분석 시에도 해당 전처리 작업 필수.

### (5) product_id 중복 행 처리
| 이슈: product_id 기준 img_link의 값이 달라 중복된 행이 생성된 것으로 확인됨.
| 결정 : product_id 기준 img_link가 달라 중복으로 확인된 행은 삭제 처리함.
| 근거 : img_link의 경우 지표 및 분석에 활용되지 않으며, 값 부풀림이 예상되어 중복 행 삭제함.
| 한계 : 다른 컬럼과 동일하게 |와 같이 하나의 행에 데이터가 수집되어 있지 않아 전체적인 데이터 형식의 통일이 필요함.

### (6) last_category column 생성
| 이슈: category의 값에 ‘|’를 기준으로 최대 6개까지 분류가 나눠짐.
| 결정: 제품을 유추할 수 있는 가장 마지막 분류 값만 last_category로 생성함.
| 근거: 대분류 기준으로 보았을 때 분석 시 정확하게 어떤 제품군인지 알 수 없어 파악하기 용이한 마지막 분류로 생성함. 
| 한계: 분석 시 해당 전처리 작업이 필수 작업에 해당하여 추후 DB상에서부터 각 분류마다 column이 나눠질 수 있는지 점검 필요.


## 4. 처리 후 검증
- product_id B0B94JPY2N, B0BQRJ3C47의 rating_count 2건 Null
- product_id B08L12N5H1의 rating 1건 Null
- 중복 행 삭제하여 전체 행 1,465 -> 1,351로 수정됨

## 5. 후속 권고
- category의 경우 대분류부터 시작하여 세부 6개 분류까지 나눠지는데 추후 정확한 데이터 관리 및 분석을 위해 컬럼 분리 필요. 
- rating의 '|' 데이터의 수집 경위를 파악하고 추가적으로 이상 값이 수집될 수 있는지 점검 필요.
- rating_count의 "" 데이터의 수집 경위를 파악하고 추가적으로 이상 값이 수집될 수 있는지 점검 필요.
- product 관련 테이블만 수집되어 customer 테이블을 추가 수집하여 성별, 나이 등에 대한 정보로 연령별 또는 성별에 따른 구매 분석도 진행 필요함.