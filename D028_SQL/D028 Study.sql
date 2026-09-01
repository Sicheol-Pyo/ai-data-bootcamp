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

products (
  product_id STRING,
  product_name STRING,
  category STRING,
  price DECIMAL(12,2)
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

  order_items (
  order_id STRING,
  product_id STRING,
  quantity INT64,
  unit_price DECIMAL(12,2)
);
  ('O0001', 'P01', 1, 125000),
  ('O0002', 'P02', 2, 44500),
  ('O0003', 'P03', 1, 45000),
  ('O0004', 'P04', 2, 115000),
  ('O0006', 'P05', 1, 67000),
  ('O0007', 'P06', 2, 79000),
  ('O0008', 'P07', 1, 32000),
  ('O0009', 'P08', 2, 205000),
  ('O0010', 'P09', 1, 99000),
  ('O0011', 'P01', 2, 38000),
  ('O0013', 'P02', 1, 142000),
  ('O0014', 'P03', 2, 44000),
  ('O0015', 'P04', 1, 53000),
  ('O0016', 'P05', 2, 87500),
  ('O0017', 'P06', 1, 61000),
  ('O0018', 'P07', 2, 160000),
  ('O0019', 'P08', 1, 47000),
  ('O0020', 'P09', 2, 107500),
  ('O0021', 'P01', 1, 38000),
  ('O0022', 'P02', 2, 67000),
  ('O0023', 'P03', 1, 92000),
  ('O0024', 'P04', 2, 134000),
  ('O0026', 'P05', 1, 119000),
  ('O0027', 'P06', 2, 202500),
  ('O0028', 'P07', 1, 58000),
  ('O0029', 'P08', 2, 36500),
  ('O0030', 'P09', 1, 187000)

/* [문제]
1) CTE를 사용해, 상태별 매출 합을 구하는 단계(status_revenue)를 만듭니다. (금액이 있는 주문만)
2) 그중 매출이 50만원 이상인 상태만 조회합니다. */

with status_revenue as (
select status,
sum(amount) as revenue
from db01.orders
group by status)

select *
from status_revenue
where revenue >= 500000

/*[문제]
1) order_items와 products를 JOIN해 카테고리별 매출을 구하는 CTE(cat_rev)를 만듭니다.
2) 그 결과에서 매출이 전체 카테고리 평균보다 높은 카테고리만 조회합니다.*/

with cat_rev as (
  select products.category, sum(order_items.unit_price * order_items.quantity) as rev
  from db01.products
  join db01.order_items
  on products.product_id = order_items.product_id
  group by products.category
)

select *
from cat_rev
where rev > (select avg(rev) from cat_rev)
order by rev desc

-- [문제] 고객별 총구매액(금액 있는 것만)을 구해, RANK()로 구매액 순위를 매기고 구매액이 큰 고객 5행을 보여주세요. (CTE + 윈도우)
with amount_total as(
  select customer_id, sum(amount) as total
  from db01.orders
  group by customer_id
)

select customer_id, total,
rank() over(order by total desc) as amount_rank 
from amount_total
limit 5

/*[문제]
1) 고객별 총구매액을 구해 DENSE_RANK로 순위를 매깁니다.
2) 각 고객의 총구매액이 전체 평균 구매액보다 높은지 함께 보여주세요. (CTE + 순위 윈도우 + AVG() OVER ())*/
with customer_total as (
  select customer_id, sum(amount) as total
  from db01.orders
  where amount is not null
  group by customer_id
)

select customer_id, total,
dense_rank() over(order by total desc) as total_rank,
avg(total) over() as total_avg,
case when total >= avg(total) over() then '평균 이상' else '평균 미만' end as 평가
from customer_total

-- [문제] 월별 매출에 '전체 평균 매출'을 나란히 붙여, 각 달이 평균보다 높은지 낮은지 비교할 수 있게 합니다. (AVG(revenue) OVER ())
with order_month as (
  select month(order_date) as month, round(avg(amount), 1) as avg
  from db01.orders
  group by month(order_date)
  order by month(order_date) asc
)

select month, avg,
sum(avg) over(order by month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as 누적매출
from order_month

-- 
WITH monthly AS (
  SELECT
    month(order_date) AS month,
    SUM(amount) AS revenue
  FROM db01.orders
  WHERE
    amount IS NOT NULL
  GROUP BY
    month(order_date) /* BigQuery: DATE_TRUNC(order_date, MONTH) */
)
SELECT
  month,
  revenue,
  AVG(revenue) OVER () AS 평균월매출
FROM monthly
order by month asc

-- [문제] 위 월별 매출에서 LAG 대신 LEAD를 사용해, 각 달에 '다음 달 매출'을 나란히 붙입니다. (마지막 달은 NULL이 됩니다.)
with month as (
  select month(order_date) as month, sum(amount) as total
  from db01.orders
  group by month(order_date)
  order by month(order_date) desc
)

select month, total, 
lead(total) over(order by month IS NULL, month) as '다음 달 매출'
from month
order by month desc

