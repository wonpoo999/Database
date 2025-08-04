-- 조인 : 테이블의 컬럼을 합치는 작업
-- 행연산 : 행단위를 대상으로 하는 작업
--   UNION(합집합) ,INTERSECT(교집합) ,MINUS(차집합)

-- ✅ 데이터의 특징 : 'wonder' 고객은 tbl_buy 에 없음.
select CUSTOMER_ID
from TBL_CUSTOMER#
UNION
select CUSTOMER_ID      -- 자동으로 중복제거 하고 연산
from TBL_BUY;

-- 구매 이력이 있는 고객
select CUSTOMER_ID
from TBL_CUSTOMER#
INTERSECT
select CUSTOMER_ID      -- 자동으로 중복제거 하고 연산
from TBL_BUY;

-- 구매 이력이 없는 고객
select CUSTOMER_ID
from TBL_CUSTOMER#      -- 4명 고객
MINUS
select CUSTOMER_ID      -- 자동으로 중복제거 하고 연산. 3명 고객
from TBL_BUY;