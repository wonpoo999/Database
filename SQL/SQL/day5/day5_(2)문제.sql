-- select 쿼리
-- 아래 요구사항의 SQL 작성하세요.
--1.  age 가 30세 이상 고객의 모든 컬럼 조회
select *
from tbl_customer#
where age >=30;

--2.  customer_id 'twice' 의 email 조회
select EMAIL
from TBL_CUSTOMER#
where CUSTOMER_ID='twice';

--3.  category 'A2' 의 pname 조회
select PNAME
from TBL_PRODUCT
where CATEGORY='A2';

--4. 상품  price 의 최고값 조회
SELECT max(price)
from TBL_PRODUCT;

--5.  'JINRMn5' 총구매 수량 조회
SELECT sum(quantity)
from TBL_BUY
where pcode='JINRMn5';

-- 문제 추가 : (step 1) pcode 별로 수량합계가 (step 2)가장 높은 순서대로 rank 구하기
-- step 1
select pcode, sum(quantity)
from TBL_BUY
GROUP BY pcode;

-- step 2
select pcode, 
sum(quantity) as "sum",
rank() over (order by sum(quantity) desc) as "rnk"   -- rank 구하는 값이 sum() 함수 결과값.
from TBL_BUY
GROUP BY pcode;

--6.  customer_id 'mina012' 이 구매한 내용 조회
SELECT *
from TBL_BUY
where CUSTOMER_ID='mina012';

--7. 구매 상품 중  pcode 가 '0'이 포함된 것 조회
select *
from TBL_BUY
WHERE pcode like '%0%';

--8. 구매 상품 중  pcode 에 'on'을 포함하는 것 조회(대소문자 구분없는 조회)
select *
from TBL_BUY
WHERE LOWER(pcode) like '%on%';

-- 조회에 필요한 컬럼(조건식과 출력) 이 2개 테이블에 있습니다.
--9. 2024년에 상품을 구매한 고객ID, 이름, 구매날짜 조회
select tc.CUSTOMER_ID, tc.NAME, tb.BUY_DATE
from TBL_CUSTOMER# tc   -- 4개 행
join TBL_BUY tb   -- 8개 행
on tc.CUSTOMER_ID = tb.CUSTOMER_ID
and to_char(tb.BUY_DATE,'yyyy')='2024';   -- extract(year from tb.BUY_DATE) ='2024'

-- 문제 추가
-- 1) 년도별 구매 건수 집계하기
SELECT EXTRACT(YEAR FROM buy_date) AS "년도",  count(*) as "건수"
FROM TBL_BUY tb 
GROUP BY EXTRACT(YEAR FROM buy_date)
ORDER BY "년도";

-- 2) 년도별 and pcode 상품별(년도가 같을 때) 구매 건수 집계하기
SELECT EXTRACT(YEAR FROM buy_date) AS "년도", PCODE ,count(*) as "년도/상품건수"
FROM TBL_BUY tb 
GROUP BY EXTRACT(YEAR FROM buy_date), PCODE  -- 년도 같을 때 pcode 로 2차 그룹화
ORDER BY "년도",PCODE;

--10. twice 가 구매한 상품과 가격, 구매금액을 조회하세요.
-- 단, 구매금액 계산은 가격 * 구매 수량 수식으로 합니다.
select tp.PCODE,tp.PNAME, tp.PRICE , tp.PRICE*tb.QUANTITY as "구매금액"
from TBL_PRODUCT tp
join TBL_BUY tb
on tp.PCODE = tb.PCODE
and tb.CUSTOMER_ID='twice';

-- 구매 행(건수) 중에서 구매 금액이 가장 높은 것을 찾아보자. 10번 문제에 customer_id 컬럼 추가 조회
-- 오라클 FETCH 명령이 있습니다.(12c 버전 이상)
-- FETCH 는 결과 행 집합을 커서로 접근 할 수 있습니다.(first, last 등....)
select tp.PCODE,tp.PNAME, tp.PRICE , tp.PRICE*tb.QUANTITY as "구매금액"
from TBL_PRODUCT tp
join TBL_BUY tb
on tp.PCODE = tb.PCODE
order by "구매금액" desc  -- 정렬 필수
FETCH FIRST 1 ROWS ONLY;