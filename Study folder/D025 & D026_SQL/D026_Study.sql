CREATE DATABASE IF NOT EXISTS DB01;

DROP TABLE IF EXISTS DB01.customers;

CREATE TABLE DB01.customers (
  customer_id VARCHAR(50),
  name VARCHAR(100),
  country VARCHAR(100),
  signup_date DATE,
  grade VARCHAR(20)
);

INSERT INTO DB01.customers VALUES
  ('C001', '김민준', 'Korea', '2023-01-05', 'Gold'),
  ('C002', '이서연', 'Korea', '2023-02-11', 'Silver'),
  ('C003', '박도윤', 'Japan', '2023-02-20', 'Bronze'),
  ('C004', '최지우', 'USA', '2023-03-03', 'Gold'),
  ('C005', '정하준', 'Korea', '2023-03-15', 'Silver'),
  ('C006', '강서윤', 'Korea', '2023-04-01', 'Bronze'),
  ('C007', '조은우', 'Japan', '2023-04-18', 'Silver'),
  ('C008', '윤지호', 'USA', '2023-05-09', 'Gold'),
  ('C009', '임하은', 'Korea', '2023-05-22', 'Bronze'),
  ('C010', '한예준', 'Korea', '2023-06-02', 'Silver'),
  ('C011', '오시우', NULL, '2023-06-19', 'Bronze'),
  ('C012', '신아린', 'Japan', '2023-07-07', 'Silver'),
  ('C013', '권준서', 'Korea', '2023-07-25', 'Gold'),
  ('C014', '황지안', 'USA', '2023-08-10', NULL),
  ('C015', '안수아', 'Korea', '2023-08-28', 'Bronze');

-- [C3]
CREATE TABLE DB01.orders (
  order_id VARCHAR(100),
  customer_id VARCHAR(100),
  order_date DATE,
  status VARCHAR(100),
  amount DECIMAL(12,2)
);

INSERT INTO DB01.orders VALUES
  ('O0001', 'C001', '2023-09-02', 'Paid', 125000),
  ('O0002', 'C002', '2023-09-05', 'Shipped', 89000),
  ('O0003', 'C001', '2023-09-11', 'Returned', 45000),
  ('O0004', 'C003', '2023-09-15', 'Paid', 230000),
  ('O0005', 'C004', '2023-09-20', 'Cancelled', NULL),
  ('O0006', 'C005', '2023-09-25', 'Shipped', 67000),
  ('O0007', 'C002', '2023-10-01', 'Paid', 158000),
  ('O0008', 'C006', '2023-10-04', 'Placed', 32000),
  ('O0009', 'C007', '2023-10-12', 'Shipped', 410000),
  ('O0010', 'C008', '2023-10-19', 'Paid', 99000),
  ('O0011', 'C001', '2023-10-23', 'Paid', 76000),
  ('O0012', 'C009', '2023-10-28', 'Cancelled', NULL),
  ('O0013', 'C010', '2023-11-02', 'Shipped', 142000),
  ('O0014', 'C004', '2023-11-08', 'Paid', 88000),
  ('O0015', 'C011', '2023-11-13', 'Placed', 53000),
  ('O0016', 'C012', '2023-11-19', 'Shipped', 175000),
  ('O0017', 'C002', '2023-11-24', 'Returned', 61000),
  ('O0018', 'C013', '2023-11-29', 'Paid', 320000),
  ('O0019', 'C005', '2023-12-03', 'Paid', 47000),
  ('O0020', 'C008', '2023-12-09', 'Shipped', 215000),
  ('O0021', 'C014', '2023-12-14', 'Placed', 38000),
  ('O0022', 'C001', '2023-12-20', 'Paid', 134000),
  ('O0023', 'C015', '2023-12-25', 'Shipped', 92000),
  ('O0024', 'C007', '2024-01-03', 'Paid', 268000),
  ('O0025', 'C010', '2024-01-09', 'Cancelled', NULL),
  ('O0026', 'C003', '2024-01-15', 'Paid', 119000),
  ('O0027', 'C013', '2024-01-22', 'Shipped', 405000),
  ('O0028', 'C006', '2024-01-28', 'Paid', 58000),
  ('O0029', 'C004', '2024-02-04', 'Returned', 73000),
  ('O0030', 'C012', '2024-02-11', 'Paid', 187000)

-- [C4]
CREATE TABLE DB01.products (
  product_id VARCHAR(100),
  product_name VARCHAR(100),
  category VARCHAR(100),
  price DECIMAL(12,2)
);

INSERT INTO DB01.products VALUES
  ('P01', '에어러너', 'Running', 89000),
  ('P02', '클래식 스니커즈', 'Sneakers', 65000),
  ('P03', '첼시 부츠', 'Boots', 145000),
  ('P04', '여름 샌들', 'Sandals', 38000),
  ('P05', '트레일 러너', 'Running', 119000),
  ('P06', '캔버스 스니커즈', 'Sneakers', 49000),
  ('P07', '워커 부츠', 'Boots', 175000),
  ('P08', '슬리퍼 샌들', 'Sandals', 25000),
  ('P09', '양말 세트', 'Accessory', 12000),
  ('P10', '운동화 끈', 'Accessory', 5000)

-- [문제] customers를 가입일(signup_date)이 최근인 순서(내림차순)로 정렬해 이름·가입일을 조회해 보세요.
select name, signup_date
from db01.customers
order by signup_date DESC

-- [문제] products에서 가격이 비싼 상품 TOP 3를 상품명·가격으로 조회해 보세요.
select product_name, price
from db01.products
order by price DESC
limit 3

-- [문제] customers에서 고객 등급(grade)에 어떤 종류가 있는지 중복 없이 조회해 보세요.
select distinct grade
from db01.customers

-- [문제] products에서 상품명에 '부츠'가 들어가는 상품을, 가격에 '가격'이라는 한글 별칭을 붙여 조회해 보세요.
select product_name, price as 가격
from db01.products
where product_name like '%부츠%'

-- [문제] orders의 각 주문에 대해, 상태가 Cancelled이거나 Returned이면 '실패', 아니면 '정상'으로 분류하는 result 열을 만들어 주문번호·상태와 함께 조회해 보세요.
select order_id, status,
case when status = 'Cancelled' then '실패' when status = 'Returned' then '실패' else '정상' end as result
from db01.orders

-- [문제] products의 가격을, 10만원 이상이면 '프리미엄', 3만원 이상이면 '스탠다드', 그 미만이면 '베이직'으로 분류한 tier 열을 만들어 상품명·가격과 함께 조회해 보세요.
select product_name, price,
case when price >= 100000 then '프리미엄' when price >= 30000 then '스탠다드' else '베이직' end as tier
from db01.products

-- [문제] customers 테이블에 고객이 총 몇 명 있는지 세어 보세요.
select count(customer_id)
from db01.customers

-- [문제] products에서 가장 비싼 가격, 가장 싼 가격, 평균 가격을 한 번에 구해 보세요.
select max(price) as '비싼 가격',
min(price),
avg(price)
from db01.products

-- [문제] customers에서 국가별 고객 수를 구하고, 고객이 많은 국가 순으로 정렬해 보세요.
select country,
count(country) as "국가별 고객 수"
from DB01.customers
group by country
order by '국가별 고객 수' DESC

/* [문제] orders에서 고객별 총 주문 금액을 구해 보세요.
- 금액(amount)이 있는 주문만 대상으로
- 총액이 20만원 이상인 고객만 보여주고
- 총액이 큰 순으로 정렬하세요. */

select order_id,
sum(amount) as '총 주문 금액'
from db01.orders
where amount is not null
group by order_id
having sum(amount) >= 200000
order by sum(amount) DESC

-- [C27] 📒 연습 문제 — 정렬·가공·집계 (1/10)
-- 문제: orders를 amount 오름차순으로 정렬하고, order_id는 '주문번호', amount는 '가격'이라는 별칭으로 조회하세요.
select order_id as '주문번호',
amount as '가격'
from db01.orders
order by amount ASC

-- [C28] 📒 연습 문제 — 정렬·가공·집계 (2/10)
-- 문제: orders의 status에서 중복을 제거하고, '상태'라는 별칭을 붙여 조회하세요.
select distinct status as '상태'
from db01.orders

-- [C29] 📒 연습 문제 — 정렬·가공·집계 (3/10)
-- 문제: customers에서 이름이 '김'으로 시작하는 고객을 조회하세요.
select name
from db01.customers
where name like '김%'

-- [C30] 📒 연습 문제 — 정렬·가공·집계 (4/10)
-- 문제: products에서 상품명에 '러너'가 포함된 상품을 조회하세요.
select product_name
from db01.products
where product_name like '%러너%'

-- [C31] 📒 연습 문제 — 정렬·가공·집계 (5/10)
-- 문제: orders에서 amount 200,000원을 기준으로 '고액'/'일반'을 나눈 열(등급)을 함께 조회하세요. (amount가 NULL이면'미확정')
select amount,
case when amount >= 200000 then '고액' when amount is null then '미확정' else '일반' end as '등급'
from db01.orders


-- [C32] 📒 연습 문제 — 정렬·가공·집계 (6/10)
-- 문제: orders에서 order_date의 '연도'만 뽑아 order_id·order_date와 함께 조회하세요.
select order_id, order_date,
left(order_date, 4) as '연도'
from db01.orders


-- [C33] 📒 연습 문제 — 정렬·가공·집계 (7/10)
-- 문제: status별로 주문 건수와 amount 합계를 구하세요.
select status,
sum(amount) as '합계'
from db01.orders
group by status

-- [C34] 📒 연습 문제 — 정렬·가공·집계 (8/10)
-- 문제: status별 amount 합계가 500,000원 이상인 상태만 남기고, 합계가 큰 순으로 정렬하세요.
select status,
sum(amount)
from db01.orders
group by status
having sum(amount) >= 500000
order by sum(amount) DESC

-- [C35] 📒 연습 문제 — 정렬·가공·집계 (9/10)
-- 문제: orders에서 금액이 가장 큰 주문 3건만 조회하세요. (정렬 + 개수 제한)
select amount
from db01.orders
order by amount DESC
limit 3

-- [C36] 📒 연습 문제 — 정렬·가공·집계 (10/10)
-- 문제: orders의 전체 주문 건수와 '금액이 있는' 주문 건수를 한 줄에 함께 구하세요.
select count(order_id) as '주문 건수',
count(amount) as '금액이 있는 주문 건수'
from db01.orders

/* [문제] 모두몰 리포트에 넣을 "카테고리별 상품 요약"을 만들어 보세요.
- products를 카테고리별로 묶어
- 카테고리명, 상품 수(COUNT), 평균 가격(AVG), 최고 가격(MAX)을 구하고
- 상품이 2개 이상인 카테고리만 남겨(HAVING)
- 평균 가격이 높은 순으로 정렬하세요. */

select category,
count(product_name),
avg(price),
max(price)
from db01.products
group by category
having count(product_name) >= 2
order by avg(price) DESC

-- 문제: orders에서 상태별 평균 주문 금액을 구하되(금액 있는 것만), 평균이 높은 순으로 정렬하세요. (상태·평균금액)
select status,
avg(amount)
from db01.orders
where amount is not null
group by status
order by avg(amount) DESC