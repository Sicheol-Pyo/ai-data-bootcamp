-- [C5]
CREATE TABLE DB01.order_items (
  order_id VARCHAR(100),
  product_id VARCHAR(100),
  quantity INT,
  unit_price DECIMAL(12,2)
);

INSERT INTO db01.order_items VALUES
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


-- [문제] 현재 데이터에서 customer_id가 기본키 후보 자격(유일하고 NULL이 없음)을 갖추었는지 확인해보세요.
-- 전체 행 수(COUNT(*))와 고유 customer_id 수(COUNT(DISTINCT customer_id))가 같으면 중복이 없다는 뜻입니다.
select count(*),
count(distinct customer_id)
from db01.customers

-- [C7]
SELECT
  orders.order_id,
  orders.amount,
  customers.name AS 고객명,
  customers.country AS 국가
FROM db01.orders
JOIN db01.customers
  ON orders.customer_id = customers.customer_id
WHERE
  orders.amount IS NOT NULL
ORDER BY
  orders.amount DESC
LIMIT 5

-- [문제] orders와 customers를 합쳐, 각 주문의 주문번호·금액·고객 등급(grade)을 조회해보세요. (금액 있는 주문 중 금액이 큰 상위 5건)
select
orders.order_id,
orders.amount,
customers.grade
from db01.orders
join db01.customers
on orders.customer_id = customers.customer_id
where orders.amount is not null
order by orders.amount DESC
limit 5

-- [문제] order_items와 products를 합쳐, 카테고리별 총 판매수량을 구해보세요. (수량 합이 많은 순)
select products.category,
SUM(order_items.quantity)
from db01.order_items
join db01.products
on order_items.product_id = products.product_id
group by products.category
order by SUM(order_items.quantity) DESC


-- [문제] 위 결과에서 한 걸음 더 나아가, 한 번도 팔리지 않은 상품만 보여주세요.
-- [C12]
SELECT
  products.product_id,
  products.product_name,
  SUM(order_items.quantity)
FROM db01.products
LEFT JOIN db01.order_items
  ON products.product_id = order_items.product_id
GROUP BY products.product_id,
  products.product_name
ORDER BY SUM(order_items.quantity) is null,
SUM(order_items.quantity) asc

SELECT
  products.product_id,
  products.product_name
FROM db01.products
LEFT JOIN db01.order_items
  ON products.product_id = order_items.product_id
where products.product_id is null

-- [문제] 금액이 30만원 이상인 주문의 주문번호와, 상태가 Returned인 주문의 주문번호를,
-- UNION으로 합쳐 하나의 '주의 주문' 목록을 만들어보세요. (중복 제거)
select order_id
from db01.orders
where amount >= 300000
UNION
select order_id
from db01.orders
where status = 'Returned'

-- [문제] 한국(Korea) 고객의 주문만 골라, 주문번호·금액을 금액 큰 순으로 조회해보세요.
-- (WHERE절 서브쿼리 + IN 사용)
select order_id, amount
from db01.orders
where customer_id in (
    select customer_id
    from db01.customers
    where country = 'Korea'
)
and amount is not null
order by amount DESC


-- [C25] 📒 연습 문제 — 조인과 서브쿼리 (1/5)
-- 문제: 고객의 국가(country)별 주문 건수를 구하고, 많은 순으로 정렬하세요.
select customers.country,
count(orders.amount) as '주문 건수'
from db01.customers
join db01.orders
on customers.customer_id = orders.customer_id
where customers.country is not null
group by customers.country
order by '주문 건수' DESC

-- [C26] 📒 연습 문제 — 조인과 서브쿼리 (2/5)
-- 문제: orders·order_items·products 세 테이블을 조인해 주문번호·상품명·수량·단가를 조회하세요.
select orders.order_id, products.product_name, order_items.quantity, order_items.unit_price
from db01.orders
join db01.order_items
on orders.order_id = order_items.order_id
join db01.products
on order_items.product_id = products.product_id

-- [C27] 📒 연습 문제 — 조인과 서브쿼리 (3/5)
-- 문제: 주문이 한 건도 없는 고객의 이름과 국가를 찾으세요. (LEFT JOIN 활용)
select customers.name, customers.country
from db01.customers
left join db01.orders
on customers.customer_id = orders.customer_id
where orders.order_id is null

-- [C28] 📒 연습 문제 — 조인과 서브쿼리 (4/5)
-- 문제: 카테고리별 총매출(수량 × 단가)을 구하고 매출이 큰 순으로 정렬하세요.
select products.category,
sum(order_items.quantity * order_items.unit_price) as '총 매출'
from db01.products
join db01.order_items
on products.product_id = order_items.product_id
group by products.category
order by sum(order_items.quantity * order_items.unit_price) DESC

-- [C29] 📒 연습 문제 — 조인과 서브쿼리 (5/5)
-- 문제: 전체 주문의 평균 금액보다 큰 주문만 조회하세요. (서브쿼리 활용)
select order_id, amount,
(select avg(amount) from db01.orders) as '전체 주문의 평균'
from db01.orders
where amount > (select avg(amount) from db01.orders)

--🧪 종합 실습 — 월별·카테고리별 매출 TOP 10
-- 질문 1. 카테고리별 매출(수량 × 단가의 합)을 구해, 매출이 큰 카테고리 순으로 보여주세요. (order_items + products)
select products.category,
sum(order_items.quantity * order_items.unit_price) as '매출'
from db01.products
join db01.order_items
on products.product_id = order_items.product_id
group by products.category
order by sum(order_items.quantity * order_items.unit_price) DESC

-- 질문 2. 고객 이름별 총 구매액 TOP 5를 구합니다. (orders + customers)
select customers.name,
sum(orders.amount) as '구매액'
from db01.customers
join db01.orders
on customers.customer_id = orders.customer_id
group by customers.name
order by sum(orders.amount) DESC
limit 5

-- 질문 3. 월별 × 카테고리별 매출을 구해, 매출 상위 10개 (월, 카테고리) 조합을 보여주세요. 그리고 카테고리별 매출을 그래프로 그립니다.
select month(orders.order_date) as '월별',
products.category,
sum(order_items.quantity * order_items.unit_price) as '카테고리별 매출'
from db01.orders
join db01.order_items
on orders.order_id = order_items.order_id
join db01.products
on order_items.product_id = products.product_id
group by month(orders.order_date), products.category
order by sum(order_items.quantity * order_items.unit_price) DESC
limit 10

/*[문제] 국가별 매출을 구해보세요.
1) orders와 customers를 JOIN 합니다.
2) country로 묶어 매출 합(SUM(amount))을 구합니다. (금액 있는 것만)
3) 국가 정보가 없는(NULL) 고객은 제외합니다.
4) 매출 큰 순으로 정렬합니다.*/
select customers.country,
sum(orders.amount) as '매출 합'
from db01.customers
join db01.orders
on customers.customer_id = orders.customer_id
where customers.country is not NULL
group by customers.country
order by sum(orders.amount) DESC

-- orders·customers를 합쳐 등급(grade)별 총 매출을 구하세요(금액 있는 것만). 매출 큰 순으로.
select customers.grade,
sum(orders.amount) as '총 매출'
from db01.customers
join db01.orders
on customers.customer_id = orders.customer_id
group by customers.grade
order by sum(orders.amount) DESC


