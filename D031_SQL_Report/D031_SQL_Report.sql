-- DB 및 테이블 정의
CREATE DATABASE db02;
create table db02.amazon(
    product_id TEXT,
    product_name TEXT,
    category TEXT,
    discounted_price TEXT,
    actual_price TEXT,
    discount_percentage TEXT,
    rating TEXT,
    rating_count TEXT,
    about_product TEXT,
    user_id TEXT,
    user_name TEXT,
    review_id TEXT,
    review_title TEXT,
    review_content TEXT,
    img_link TEXT,
    product_link TEXT
)

-- CSV 파일 불러오기
LOAD DATA INFILE 'C:/mysql-files/amazon.csv'
INTO TABLE db02.amazon
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 결측치 확인
select COUNT(product_id), COUNT(product_name),COUNT(category),COUNT(discounted_price),COUNT(actual_price),COUNT(discount_percentage),
COUNT(rating), COUNT(rating_count), COUNT(user_id), COUNT(user_name), COUNT(review_id), COUNT(review_title), COUNT(review_content),
COUNT(img_link), COUNT(product_link)
from db02.amazon

SELECT
  SUM(CASE WHEN TRIM(product_id) = '' OR product_id IS NULL THEN 1 ELSE 0 END) AS product_id_blank,
  SUM(CASE WHEN TRIM(product_name) = '' OR product_name IS NULL THEN 1 ELSE 0 END) AS product_name_blank,
  SUM(CASE WHEN TRIM(category) = '' OR category IS NULL THEN 1 ELSE 0 END) AS category_blank,
  SUM(CASE WHEN TRIM(discounted_price) = '' OR discounted_price IS NULL THEN 1 ELSE 0 END) AS discounted_price_blank,
  SUM(CASE WHEN TRIM(actual_price) = '' OR actual_price IS NULL THEN 1 ELSE 0 END) AS actual_price_blank,
  SUM(CASE WHEN TRIM(discount_percentage) = '' OR discount_percentage IS NULL THEN 1 ELSE 0 END) AS discount_percentage_blank,
  SUM(CASE WHEN TRIM(rating) = '' OR rating IS NULL THEN 1 ELSE 0 END) AS rating_blank,
  SUM(CASE WHEN TRIM(rating_count) = '' OR rating_count IS NULL THEN 1 ELSE 0 END) AS rating_count_blank,
  SUM(CASE WHEN TRIM(about_product) = '' OR about_product IS NULL THEN 1 ELSE 0 END) AS about_product_blank,
  SUM(CASE WHEN TRIM(user_id) = '' OR user_id IS NULL THEN 1 ELSE 0 END) AS user_id_blank,
  SUM(CASE WHEN TRIM(user_name) = '' OR user_name IS NULL THEN 1 ELSE 0 END) AS user_name_blank,
  SUM(CASE WHEN TRIM(review_id) = '' OR review_id IS NULL THEN 1 ELSE 0 END) AS review_id_blank,
  SUM(CASE WHEN TRIM(review_title) = '' OR review_title IS NULL THEN 1 ELSE 0 END) AS review_title_blank,
  SUM(CASE WHEN TRIM(review_content) = '' OR review_content IS NULL THEN 1 ELSE 0 END) AS review_content_blank,
  SUM(CASE WHEN TRIM(img_link) = '' OR img_link IS NULL THEN 1 ELSE 0 END) AS img_link_blank,
  SUM(CASE WHEN TRIM(product_link) = '' OR product_link IS NULL THEN 1 ELSE 0 END) AS product_link_blank
FROM db02.amazon;

select product_id, rating, rating_count
from db02.amazon
where rating_count = ""

-- discounted_price 루피 삭제
SELECT discounted_price, REGEXP_REPLACE(discounted_price, '[^0-9.]', '') AS discounted_price_cleaned
FROM db02.amazon

-- actual_price 루피 삭제
SELECT actual_price, REGEXP_REPLACE(actual_price, '[^0-9.]', '') AS actual_price_cleaned
FROM db02.amazon

-- discount_percentage % 삭제
SELECT discount_percentage, REGEXP_REPLACE(discount_percentage, '[^0-9.]', '') AS discount_percentage_cleaned
FROM db02.amazon

-- rating 이상 값
SELECT product_id, rating
FROM db02.amazon
WHERE REGEXP_REPLACE(rating, '[^0-9.]', '') = ''
OR rating IS NULL;

SELECT product_id, product_name, rating
FROM db02.amazon
WHERE REGEXP_REPLACE(rating, '[^0-9.]', '') = ''
   OR rating IS NULL;

-- rating_count 이상 값
SELECT product_id, rating_count
FROM db02.amazon
WHERE REGEXP_REPLACE(rating_count, '[^0-9.]', '') = ''
OR rating_count IS NULL;

SELECT product_id, product_name, rating_count
FROM db02.amazon
WHERE REGEXP_REPLACE(rating_count, '[^0-9.]', '') = ''
   OR rating_count IS NULL;

-- amazon_clean 생성
CREATE TABLE db02.amazon_clean AS
SELECT
    product_id,
    product_name,
    category,
    CAST(NULLIF(REGEXP_REPLACE(discounted_price, '[^0-9.]', ''), '') AS DECIMAL(10,2)) AS discounted_price,
    CAST(NULLIF(REGEXP_REPLACE(actual_price, '[^0-9.]', ''), '') AS DECIMAL(10,2)) AS actual_price,
    CAST(NULLIF(REGEXP_REPLACE(discount_percentage, '[^0-9.]', ''), '') AS UNSIGNED) AS discount_percentage,
    CAST(NULLIF(REGEXP_REPLACE(rating, '[^0-9.]', ''), '') AS DECIMAL(2,1)) AS rating,
    CAST(NULLIF(REGEXP_REPLACE(rating_count, '[^0-9]', ''), '') AS UNSIGNED) AS rating_count,
    about_product,
    user_id,
    user_name,
    review_id,
    review_title,
    review_content,
    img_link,
    product_link
FROM db02.amazon;

-- 중복 행 제거
CREATE TABLE db02.amazon_clean_dedup AS
SELECT * FROM (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY img_link) AS rn
  FROM db02.amazon_clean
) t
WHERE rn = 1;

ALTER TABLE db02.amazon_clean_dedup DROP COLUMN rn;

DROP TABLE db02.amazon_clean;
RENAME TABLE db02.amazon_clean_dedup TO db02.amazon_clean;

SELECT COUNT(*) FROM db02.amazon_clean;

SELECT product_id, COUNT(*) AS cnt
FROM db02.amazon_clean
GROUP BY product_id
HAVING COUNT(*) > 1;

-- last_category table 생성
ALTER TABLE db02.amazon_clean ADD COLUMN last_category VARCHAR(255);
UPDATE db02.amazon_clean
SET last_category = SUBSTRING_INDEX(category, '|', -1);

SELECT last_category, COUNT(*) AS cnt
FROM db02.amazon_clean
GROUP BY last_category
ORDER BY cnt DESC;


/* 추천 시스템 1.
추천 시스템 이름: GoodPick

추천 시스템의 테마: rating의 경우 사용 전 평가를 하는 경우도 많아 review_content의 good, great, excellent, recommend, worth, best의 개수를 평가하여
고객이 좋은 상품을 선택할 수 있도록 추천을 제공

구현 로직*/
SELECT 
  product_id, 
  last_category, 
  rating, 
  rating_count,
  round((LENGTH(review_content) - LENGTH(REPLACE(review_content, 'good', ''))) / LENGTH('good')
    - (LENGTH(review_content) - LENGTH(REPLACE(review_content, 'not good', ''))) / LENGTH('not good'),0) as good_count,
  round((LENGTH(review_content) - LENGTH(REPLACE(review_content, 'great', ''))) / LENGTH('great')
    - (LENGTH(review_content) - LENGTH(REPLACE(review_content, 'not great', ''))) / LENGTH('not great'),0) as great_count,
  round((LENGTH(review_content) - LENGTH(REPLACE(review_content, 'excellent', ''))) / LENGTH('excellent')
    - (LENGTH(review_content) - LENGTH(REPLACE(review_content, 'not excellent', ''))) / LENGTH('not excellent'),0) as excellent_count,
  round((LENGTH(review_content) - LENGTH(REPLACE(review_content, 'recommend', ''))) / LENGTH('recommend')
    - (LENGTH(review_content) - LENGTH(REPLACE(review_content, '%don\'t recommend%', ''))) / LENGTH('%don\'t recommend%'),0) as recommend_count,
  round((LENGTH(review_content) - LENGTH(REPLACE(review_content, 'worth', ''))) / LENGTH('worth')
    - (LENGTH(review_content) - LENGTH(REPLACE(review_content, 'not worth', ''))) / LENGTH('not worth'),0) as worth_count,
  round((LENGTH(review_content) - LENGTH(REPLACE(review_content, 'best', ''))) / LENGTH('best')       
    - (LENGTH(review_content) - LENGTH(REPLACE(review_content, 'not best', ''))) / LENGTH('not best'),0) as best_count
FROM db02.amazon_clean
where last_category = 'in-ear'
order by rating desc

SELECT 
  product_id, 
  last_category, 
  rating, 
  rating_count,
  ROUND((LENGTH(review_content) - LENGTH(REPLACE(review_content, 'not good', ''))) / LENGTH('not good'), 0) AS not_good_count,
  ROUND((LENGTH(review_content) - LENGTH(REPLACE(review_content, 'not great', ''))) / LENGTH('not great'), 0) AS not_great_count,
  ROUND((LENGTH(review_content) - LENGTH(REPLACE(review_content, 'not excellent', ''))) / LENGTH('not excellent'), 0) AS not_excellent_count,
  ROUND((LENGTH(review_content) - LENGTH(REPLACE(review_content, 'don\'t recommend', ''))) / LENGTH('don\'t recommend'), 0) AS dont_recommend_count,
  ROUND((LENGTH(review_content) - LENGTH(REPLACE(review_content, 'not worth', ''))) / LENGTH('not worth'), 0) AS not_worth_count,
  ROUND((LENGTH(review_content) - LENGTH(REPLACE(review_content, 'worst', ''))) / LENGTH('worst'), 0) AS worst_count
FROM db02.amazon_clean
ORDER BY not_good_count DESC;


/* 추천 시스템 2.
추천 시스템 이름: PreViral

추천 시스템의 테마: rating_count를 4분위로 나눈 후 아직 리뷰가 많이 없는 4분위의 아이템 리스트와 카테고리별 평균 가격 정보를 같이 보여주어
이미 많이 알려진 아이템 보다는 숨겨진 꿀템을 찾아 추천해주는 시스템

구현 로직*/
select product_id,
last_category,
actual_price,
round(avg(actual_price) over (partition by last_category),2) as "평균 가격",
case when "평균 가격" > actual_price then "평균 이상" else "평균 이하" end as "평균 비교",
rating,
rating_count,
ntile(4) over (order by rating_count desc) as 'rating_count_ntile'
from db02.amazon_clean
order by rating_count asc


/* 추천 시스템 3.
추천 시스템 이름: Bestseller

추천 시스템의 테마: 평점 비교, 가격 비교, 리뷰 찾기 등 귀찮은 작업은 그만 자금이 여유로운데 시간이 없는 고객을 위한 카테고리별 베스트셀러 추천 시스템
(rating or rating_count로 기준 설정 가능)

구현 로직*/
select product_id,
last_category,
actual_price,
rating,
rating_count
from (select product_id, last_category, actual_price, rating, rating_count,
    row_number() over (partition by last_category order by rating_count desc, rating desc) as "인기상품",
    count(*) over (partition by last_category) as category_count
  from db02.amazon_clean
) t
where 인기상품 = 1 and category_count >= 3
order by last_category asc


/* 추천 시스템 4.
추천 시스템 이름: DeviceFit

추천 시스템의 테마: 내 스마트폰에 호환되는 악세사리 또는 전자기기들을 자동으로 추천해주는 시스템
더 이상 케이블을 잘못 구매하여 불필요한 교환 및 반품의 추가 택배비용을 줄이세요.


구현 로직*/
select product_id,
product_name,
last_category,
actual_price,
rating,
rating_count
from db02.amazon_clean
where product_name like "%apple%"
or product_name like "%iphone%"
or product_name like "%ipad%"
or product_name like "%air pods%"
or product_name like "%MacBook%"
order by last_category asc

-- 갤럭시
select product_id,
product_name,
last_category,
actual_price,
rating,
rating_count
from db02.amazon_clean
where product_name like "%samsumg%"
or product_name like "%android%"
or product_name like "%galaxy%"
order by last_category asc

-- 소니
select product_id,
product_name,
last_category,
actual_price,
rating,
rating_count
from db02.amazon_clean
where product_name like "%sony%"
or product_name like "%ps4%"
or product_name like "%ps5%"
or product_name like "%psp%"
or product_name like "%playstation%"
or product_name like "%play station%"
or product_name like "%portal%"
order by last_category asc


/* 추천 시스템 5.
추천 시스템 이름: Wonpice

추천 시스템의 테마: 망망대해같은 Amazon에서 조금이라도 더 저렴하고 좋은 상품을 위해 내수가 아닌 직구 모험을 떠나는 고객들을 위해
상품 하나하나 고객이 직접 원화와 비교하지 않고 모든 상품을 루피 가격에 대한 원화 가격으로 함께 보여주어 프로 직구러들을 위한 추천 시스템

구현 로직*/

create table db02.exchange_rate (
  inr_to_krw decimal(10,4)
);
insert into db02.exchange_rate (inr_to_krw) values (15.45);
update db02.exchange_rate set inr_to_krw = 14.4;

select product_id,
product_name,
last_category,
actual_price,
  round(actual_price * (select inr_to_krw from db02.exchange_rate),1) as actual_price_krw,
rating,
rating_count
from db02.amazon_clean
order by rating desc