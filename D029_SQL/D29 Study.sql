customers (
  customer_id STRING,
  name STRING,
  country STRING,
  signup_date DATE,
  grade STRING
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
  ('C015', '안수아', 'Korea', '2023-08-28', 'Bronze')

  orders (
  order_id STRING,
  customer_id STRING,
  order_date DATE,
  status STRING,
  amount DECIMAL(12,2)
);
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
CREATE TABLE db01.events (
  event_id INT,
  customer_id VARCHAR(100),
  event_type VARCHAR(100),
  page VARCHAR(100),
  event_at TIMESTAMP
);

INSERT INTO DB01.events VALUES
  (1, 'C001', 'visit', 'home', TIMESTAMP '2023-09-02 10:02:11'),
  (2, 'C001', 'view', 'product_detail', TIMESTAMP '2023-09-02 10:04:35'),
  (3, 'C001', 'view', 'product_detail', TIMESTAMP '2023-09-02 10:07:20'),
  (4, 'C001', 'add_to_cart', 'cart', TIMESTAMP '2023-09-02 10:11:02'),
  (5, 'C001', 'purchase', 'checkout', TIMESTAMP '2023-09-02 10:14:47'),
  (6, 'C001', 'visit', 'home', TIMESTAMP '2023-10-18 09:31:04'),
  (7, 'C001', 'view', 'product_detail', TIMESTAMP '2023-10-18 09:33:50'),
  (8, 'C001', 'visit', 'home', TIMESTAMP '2023-11-14 20:12:33'),
  (9, 'C002', 'visit', 'home', TIMESTAMP '2023-09-05 14:20:05'),
  (10, 'C002', 'view', 'product_detail', TIMESTAMP '2023-09-05 14:22:41'),
  (11, 'C002', 'add_to_cart', 'cart', TIMESTAMP '2023-09-05 14:27:19'),
  (12, 'C002', 'purchase', 'checkout', TIMESTAMP '2023-09-05 14:31:58'),
  (13, 'C002', 'visit', 'home', TIMESTAMP '2023-10-09 11:05:22'),
  (14, 'C002', 'view', 'product_detail', TIMESTAMP '2023-10-09 11:08:44'),
  (15, 'C003', 'visit', 'home', TIMESTAMP '2023-09-15 09:14:30'),
  (16, 'C003', 'view', 'product_detail', TIMESTAMP '2023-09-15 09:17:12'),
  (17, 'C003', 'add_to_cart', 'cart', TIMESTAMP '2023-09-15 09:21:40'),
  (18, 'C003', 'purchase', 'checkout', TIMESTAMP '2023-09-15 09:26:03'),
  (19, 'C003', 'visit', 'home', TIMESTAMP '2023-11-07 21:40:15'),
  (20, 'C003', 'view', 'product_detail', TIMESTAMP '2023-11-07 21:43:02'),
  (21, 'C004', 'visit', 'home', TIMESTAMP '2023-09-18 16:03:11'),
  (22, 'C004', 'view', 'product_detail', TIMESTAMP '2023-09-18 16:06:29'),
  (23, 'C004', 'visit', 'home', TIMESTAMP '2023-11-05 10:55:07'),
  (24, 'C004', 'view', 'product_detail', TIMESTAMP '2023-11-05 10:58:33'),
  (25, 'C005', 'visit', 'home', TIMESTAMP '2023-09-22 08:40:19'),
  (26, 'C006', 'visit', 'home', TIMESTAMP '2023-10-04 13:11:02'),
  (27, 'C006', 'view', 'product_detail', TIMESTAMP '2023-10-04 13:13:47'),
  (28, 'C006', 'add_to_cart', 'cart', TIMESTAMP '2023-10-04 13:18:20'),
  (29, 'C006', 'purchase', 'checkout', TIMESTAMP '2023-10-04 13:22:55'),
  (30, 'C006', 'visit', 'home', TIMESTAMP '2023-11-16 19:02:41'),
  (31, 'C006', 'visit', 'home', TIMESTAMP '2023-12-05 12:30:18'),
  (32, 'C006', 'view', 'product_detail', TIMESTAMP '2023-12-05 12:33:04'),
  (33, 'C007', 'visit', 'home', TIMESTAMP '2023-10-12 10:45:33'),
  (34, 'C007', 'view', 'product_detail', TIMESTAMP '2023-10-12 10:48:09'),
  (35, 'C007', 'view', 'product_detail', TIMESTAMP '2023-10-12 10:52:41'),
  (36, 'C007', 'add_to_cart', 'cart', TIMESTAMP '2023-10-12 10:57:12'),
  (37, 'C007', 'purchase', 'checkout', TIMESTAMP '2023-10-12 11:02:38'),
  (38, 'C007', 'visit', 'home', TIMESTAMP '2023-11-21 15:20:07'),
  (39, 'C007', 'view', 'product_detail', TIMESTAMP '2023-11-21 15:23:55'),
  (40, 'C008', 'visit', 'home', TIMESTAMP '2023-10-16 17:30:44'),
  (41, 'C008', 'view', 'product_detail', TIMESTAMP '2023-10-16 17:33:21'),
  (42, 'C008', 'visit', 'home', TIMESTAMP '2023-12-13 11:15:02'),
  (43, 'C008', 'view', 'product_detail', TIMESTAMP '2023-12-13 11:18:39'),
  (44, 'C009', 'visit', 'home', TIMESTAMP '2023-10-25 20:05:13'),
  (45, 'C009', 'view', 'product_detail', TIMESTAMP '2023-10-25 20:08:47'),
  (46, 'C009', 'add_to_cart', 'cart', TIMESTAMP '2023-10-25 20:14:22'),
  (47, 'C010', 'visit', 'home', TIMESTAMP '2023-11-24 09:50:11'),
  (48, 'C010', 'view', 'product_detail', TIMESTAMP '2023-11-24 09:52:48'),
  (49, 'C010', 'add_to_cart', 'cart', TIMESTAMP '2023-11-24 09:58:30'),
  (50, 'C010', 'visit', 'home', TIMESTAMP '2023-12-18 18:22:05'),
  (51, 'C011', 'visit', 'home', TIMESTAMP '2023-11-10 14:08:26'),
  (52, 'C011', 'view', 'product_detail', TIMESTAMP '2023-11-10 14:11:03'),
  (53, 'C012', 'visit', 'home', TIMESTAMP '2023-11-19 11:40:15'),
  (54, 'C012', 'view', 'product_detail', TIMESTAMP '2023-11-19 11:42:58'),
  (55, 'C012', 'add_to_cart', 'cart', TIMESTAMP '2023-11-19 11:47:33'),
  (56, 'C012', 'purchase', 'checkout', TIMESTAMP '2023-11-19 11:52:10'),
  (57, 'C012', 'visit', 'home', TIMESTAMP '2023-12-27 16:14:40'),
  (58, 'C012', 'view', 'product_detail', TIMESTAMP '2023-12-27 16:17:22'),
  (59, 'C012', 'visit', 'home', TIMESTAMP '2024-01-08 10:20:55'),
  (60, 'C013', 'visit', 'home', TIMESTAMP '2023-11-26 13:05:30'),
  (61, 'C013', 'view', 'product_detail', TIMESTAMP '2023-11-26 13:08:12'),
  (62, 'C013', 'visit', 'home', TIMESTAMP '2024-01-19 09:44:18'),
  (63, 'C013', 'view', 'product_detail', TIMESTAMP '2024-01-19 09:47:01'),
  (64, 'C014', 'visit', 'home', TIMESTAMP '2023-12-11 19:30:22'),
  (65, 'C014', 'visit', 'home', TIMESTAMP '2024-02-06 08:15:44'),
  (66, 'C015', 'visit', 'home', TIMESTAMP '2023-12-22 10:10:05'),
  (67, 'C015', 'view', 'product_detail', TIMESTAMP '2023-12-22 10:13:40'),
  (68, 'C015', 'visit', 'home', TIMESTAMP '2024-01-11 17:55:19')


select *
from db01.events

-- [문제] events에서 전체 이벤트 수(PV 개념의 총 행동 수)와 고유 사용자 수(UV)를 구합니다. (event_type 구분 없이 전체)
select count(*) as '이벤트 수(PV)',
count(distinct customer_id) as '고유 사용자 수(UV)'
from db01.events

-- [문제] events에서 이벤트 종류(event_type)별 고유 사용자 수(UV)를 구해, 많은 순으로 보여주세요.
select event_type,
count(distinct customer_id) as '고유 사용자 수(UV)'
from db01.events
group by event_type
order by count(distinct customer_id) desc

/*[문제] 리포트의 마지막 장표로, 국가별 구매 고객 수와 ARPPU를 구합니다.
1) orders와 customers를 JOIN 합니다.
2) 국가별로 묶어 구매 고객 수(COUNT(DISTINCT customer_id))와 ARPPU(SUM(amount)/COUNT(DISTINCT customer_id))를 구합니다.
3) 국가 정보가 없는(NULL) 고객과 취소·반품 주문을 제외합니다.
4) ARPPU가 높은 순으로 정렬합니다.*/

select customers.country,
count(distinct customers.customer_id) as UV,
round(SUM(orders.amount)/COUNT(DISTINCT orders.customer_id), 0) as ARPPU
from db01.customers
join db01.orders
on customers.customer_id = orders.customer_id
where customers.country is not null
and customers.customer_id is not null
and orders.status not in ('cancelled', 'returned')
group by customers.country
order by ARPPU desc


-- [문제] 장바구니(add_to_cart)를 사용한 사람 중 구매(purchase)도 한 사람의 비율을 구합니다. 이번 문제는 두 행동의 수행 여부만 확인하고 시간 순서는 확인하지 않습니다.
with A as (
    select count(event_type) as '장바구니'
    from db01.events
    where event_type = 'add_to_cart'
),
B as (
    select count(event_type) as '구매'
    from db01.events
    where event_type = 'purchase'
)

select A.장바구니, B.구매,
ROUND(B.구매 / A.장바구니 * 100, 1) as '구매 비율'
from A, B


WITH user_steps AS (
  SELECT
    customer_id,
    MAX(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS cart,
    MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchase
  FROM DB01.events
  GROUP BY
    customer_id
),

f AS (
  SELECT
    SUM(cart) AS 장바구니사용자,
    SUM(CASE WHEN cart = 1 AND purchase = 1 THEN 1 ELSE 0 END) AS 장바구니후_구매사용자
  FROM user_steps
)

SELECT
  장바구니사용자,
  장바구니후_구매사용자,
  ROUND(장바구니후_구매사용자 * 100.0 / NULLIF(장바구니사용자, 0), 1) AS 장바구니_구매도달률
FROM f

-- [문제] 위 리텐션 매트릭스를 비율(%)로 바꿉니다. 경과 0개월(코호트 크기) 대비 경과 1개월의 리텐션율을 구하면 됩니다.

WITH first_seen AS (
  SELECT
    customer_id,
    date_format(MIN(event_at), '%Y-%m-01') AS cohort_month
  FROM db01.events
  GROUP BY
    customer_id
), activity AS (
  SELECT DISTINCT
    customer_id,
    date_format(event_at, '%Y-%m-01') AS active_month
  FROM db01.events
), joined AS (
  SELECT
    f.cohort_month,
    TIMESTAMPDIFF(month, f.cohort_month, a.active_month) AS month_offset,
    a.customer_id
  FROM first_seen AS f
  JOIN activity AS a
    ON f.customer_id = a.customer_id
)
SELECT
  cohort_month,
  COUNT(DISTINCT CASE WHEN month_offset = 0 THEN customer_id END) AS 경과0개월,
  COUNT(DISTINCT CASE WHEN month_offset = 1 THEN customer_id END) AS 경과1개월,
  COUNT(DISTINCT CASE WHEN month_offset = 2 THEN customer_id END) AS 경과2개월
FROM joined
GROUP BY
  cohort_month
ORDER BY
  cohort_month asc

WITH first_seen AS (
  SELECT
    customer_id,
    DATE_FORMAT(MIN(event_at), '%Y-%m-01') AS cohort_month
  FROM db01.events
  GROUP BY
    customer_id
), activity AS (
  SELECT DISTINCT
    customer_id,
    DATE_FORMAT(event_at, '%Y-%m-01') AS active_month
  FROM db01.events
), joined AS (
  SELECT
    f.cohort_month,
    TIMESTAMPDIFF(MONTH, f.cohort_month, a.active_month) AS month_offset,
    a.customer_id
  FROM first_seen AS f
  JOIN activity AS a
    ON f.customer_id = a.customer_id
), retention AS (
  SELECT
    cohort_month,
    COUNT(DISTINCT CASE WHEN month_offset = 0 THEN customer_id END) AS 코호트_크기,
    COUNT(DISTINCT CASE WHEN month_offset = 1 THEN customer_id END) AS 경과1개월_잔존자
  FROM joined
  GROUP BY
    cohort_month
)
SELECT
  cohort_month,
  코호트_크기,
  경과1개월_잔존자,
  ROUND(경과1개월_잔존자 * 100.0 / NULLIF(코호트_크기, 0), 1) AS 리텐션율_1개월
FROM retention
ORDER BY
  cohort_month ASC;

-- [문제] RFM에서 총 구매액(Monetary)이 큰 고객 3행을 뽑고, RANK() 윈도우 함수로 순위를 함께 보여주세요. (CTE + 윈도우)

WITH rfm AS (
  SELECT
    customer_id,
    TIMESTAMPDIFF(day, MAX(order_date), DATE '2024-03-01') AS recency,
    COUNT(*) AS frequency,
    SUM(amount) AS monetary
  FROM db01.orders
  WHERE
    status NOT IN ('Cancelled', 'Returned')
    AND amount IS NOT NULL
  GROUP BY
    customer_id
)
SELECT
  customer_id,
  recency,
  frequency,
  monetary,
  CASE
    WHEN monetary >= 300000 AND recency <= 90
    THEN '핵심 고객'
    WHEN recency > 120
    THEN '이탈 위험'
    ELSE '일반 고객'
  END AS 고객등급,
  rank() over(order by monetary desc) as 'rank'
FROM rfm
ORDER BY
  monetary DESC
limit 3

-- [C26] 📒 연습 문제 — 고객 행동 지표 (1/5)
-- 문제: 전체 이벤트 수(PV)와 고유 사용자 수(UV)를 한 번에 구합니다.
select count(event_type) as 'PV',
count(DISTINCT customer_id) as 'UV'
from db01.events
where event_type is not null

-- [C27] 📒 연습 문제 — 고객 행동 지표 (2/5)
-- 문제: event_type별 사용자 수를 구하고 많은 순으로 정렬합니다.
select event_type,
count(DISTINCT customer_id) as 'UV'
from db01.events
group by event_type
order by UV DESC

-- [C28] 📒 연습 문제 — 고객 행동 지표 (3/5)
-- 문제: 정상 주문(취소·반품 제외)만으로 ARPPU(구매 사용자 1인당 평균 매출)를 구합니다.
with TA as (
    select sum(amount) as total_amount
    from db01.orders
    where status not in('cancelled', 'returned')
),

acting as (
    select count(distinct customer_id) as actitve
    from db01.orders
),

buy as (
    select count(distinct customer_id) as 'cusmtomer'
    from db01.orders
    where status not in('cancelled', 'returned')
    and amount is not null
)

select TA.total_amount as '총매출',
ROUND(ta.total_amount * 1.0 / NULLIF(buy.cusmtomer, 0), 0) AS ARPPU
from ta
CROSS JOIN acting
CROSS JOIN buy

-- [C29] 📒 연습 문제 — 고객 행동 지표 (4/5)
-- 문제: 고객별 마지막 구매일과 그날로부터 2024-03-01까지 경과일을 구합니다.
select customer_id, order_date,
datediff('2024-03-01', order_date) as '경과일'
from db01.orders
where order_date is not null

-- [C30] 📒 연습 문제 — 고객 행동 지표 (5/5)
-- 문제: 정상 주문의 고객별 총구매액을 NTILE(3)으로 나누세요. 1은 하, 3은 상으로 해석합니다.
select customer_id, sum(amount),
NTILE(3) over(order by sum(amount) asc)
from db01.orders
where status is not null
and status not in('cancelled', 'returned')
group by customer_id
order by sum(amount) desc

-- [C31] 🧪 종합 실습 — 고객 행동 인사이트 리포트 (1/5)
-- 질문 1. 퍼널 전환율을 막대그래프로 그려, 어디서 가장 많이 이탈하는지 한눈에 봅니다.
SELECT
  'visit' AS stage,
  COUNT(DISTINCT CASE WHEN event_type = 'visit' THEN customer_id END) AS users
FROM db01.events
UNION ALL
SELECT
  'view',
  COUNT(DISTINCT CASE WHEN event_type = 'view' THEN customer_id END)
FROM db01.events
UNION ALL
SELECT
  'add_to_cart',
  COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN customer_id END)
FROM db01.events
UNION ALL
SELECT
  'purchase',
  COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN customer_id END)
FROM db01.events

-- [C32] 🧪 종합 실습 — 고객 행동 인사이트 리포트 (2/5)
-- 질문 2. 첫 활동월 코호트별로 경과 1개월 잔존율(%) 을 구합니다. 어느 코호트가 잘 남았는지 비교합니다.
WITH first_seen AS (
  SELECT
    customer_id,
    date_trunc('month', DATE(MIN(event_at))) AS cohort_month
  FROM db01.events
  GROUP BY
    customer_id
), activity AS (
  SELECT DISTINCT
    customer_id,
    date_trunc('month', DATE(event_at)) AS active_month
  FROM db01.events
), joined AS (
  SELECT
    f.cohort_month,
    date_diff('month', f.cohort_month, a.active_month) AS month_offset,
    a.customer_id
  FROM first_seen AS f
  JOIN activity AS a
    ON f.customer_id = a.customer_id
)
SELECT
  cohort_month,
  COUNT(DISTINCT CASE WHEN month_offset = 0 THEN customer_id END) AS 코호트_인원,
  COUNT(DISTINCT CASE WHEN month_offset = 1 THEN customer_id END) AS 경과1개월_잔존,
  ROUND(
    COUNT(DISTINCT CASE WHEN month_offset = 1 THEN customer_id END) * 100.0
      / NULLIF(COUNT(DISTINCT CASE WHEN month_offset = 0 THEN customer_id END), 0),
    1
  ) AS 잔존율_pct
FROM joined
GROUP BY
  cohort_month
ORDER BY
  cohort_month NULLS LAST

-- [C33] 🧪 종합 실습 — 고객 행동 인사이트 리포트 (3/5)
-- 질문 3. RFM 기준으로 고객 등급별 인원을 집계합니다
WITH rfm AS (
  SELECT
    customer_id,
    datediff('2024-03-01', MAX(order_date)) AS recency,
    SUM(amount) AS monetary
  FROM db01.orders
  WHERE
    status NOT IN ('Cancelled', 'Returned')
    AND amount IS NOT NULL
  GROUP BY
    customer_id
)
SELECT
  CASE
    WHEN monetary >= 300000 AND recency <= 90
    THEN '핵심 고객'
    WHEN recency > 120
    THEN '이탈 위험'
    ELSE '일반 고객'
  END AS 고객등급,
  COUNT(*) AS 인원
FROM rfm
GROUP BY
  1
ORDER BY
  인원 DESC

-- [C34] 🧪 종합 실습 — 고객 행동 인사이트 리포트 (4/5)
-- 질문 4. 월별 취소반품율을 구해, 특정 달에 이상이 있었는지 확인합니다.
SELECT
  date_format(min(order_date), '%Y-%m-01') AS '주문월',
  COUNT(*) AS 전체주문,
  SUM(CASE WHEN status IN ('Cancelled', 'Returned') THEN 1 ELSE 0 END) AS 취소반품,
  ROUND(
    SUM(CASE WHEN status IN ('Cancelled', 'Returned') THEN 1 ELSE 0 END) * 100.0
      / NULLIF(COUNT(*), 0),
    1
  ) AS 취소반품율_pct
FROM db01.orders
GROUP BY
  1
ORDER BY
  주문월 asc

-- [C35] 🧪 종합 실습 — 고객 행동 인사이트 리포트 (5/5)
-- 질문 5. 이탈 위험 고객을 뽑되, 총구매액이 큰 순서로 정렬합니다. 쿠폰 예산이 한정되어 있다면 누구부터 잡아야 하는지 보기 위해서입니다.
WITH cust AS (
  SELECT
    customer_id,
    COUNT(*) AS 구매횟수,
    SUM(amount) AS 총구매액,
    datediff('2024-03-01', MAX(order_date)) AS 경과일
  FROM db01.orders
  WHERE
    status NOT IN ('Cancelled', 'Returned')
    AND amount IS NOT NULL
  GROUP BY
    customer_id
)
SELECT
  customer_id,
  구매횟수,
  총구매액,
  경과일
FROM cust
WHERE
  경과일 > 90
  AND 구매횟수 >= 2
ORDER BY
  총구매액 DESC

-- [C36] 코드 퀴즈 — 정의를 바꿔 활성 사용자 세기
-- 문제: 활성 사용자를 "단순 방문(visit)을 제외한 행동을 1건 이상 남긴 고객" 으로 정의하고, 그 인원 수를 구합니다.
