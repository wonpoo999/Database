-- 지금까지 했던 join 은 아래와 같이 tc.CUSTOMER_ID = tb.CUSTOMER_ID 행만
-- 컬럼을 합치는 '동등 조인'
select tc.CUSTOMER_ID, tc.NAME, tb.BUY_DATE
from TBL_CUSTOMER# tc   -- 4개 행
join TBL_BUY tb   -- 8개 행
on tc.CUSTOMER_ID = tb.CUSTOMER_ID;


-- 예시로 고객 'wonder'는 구매가 없으므로 tbl_buy 에 없어요.
-- 이럴 때 tbl_buy는 null 상태로 합치는 것이 외부 조인(left outer join 또는 right outer join)
select  *                    --  tc.CUSTOMER_ID, tc.NAME, tb.BUY_DATE
from TBL_CUSTOMER# tc   
left join TBL_BUY tb   -- left 에 있는 테이블(대체로 부모테이블)의 모든 행을 포함.
on tc.CUSTOMER_ID = tb.CUSTOMER_ID;

select  *                    --  tc.CUSTOMER_ID, tc.NAME, tb.BUY_DATE
from TBL_CUSTOMER# tc   
right join TBL_BUY tb   -- right 에 있는 테이블의 모든 행을 포함. 부모테이블이 아니므로 동등조인 결과
on tc.CUSTOMER_ID = tb.CUSTOMER_ID;

select  *                    --  tc.CUSTOMER_ID, tc.NAME, tb.BUY_DATE
from TBL_BUY tb      
right join TBL_CUSTOMER# tc
on tc.CUSTOMER_ID = tb.CUSTOMER_ID;

-- 구매 건수가 없는 고객을 조회하기.
select tc.CUSTOMER_ID,tc.name, tc.REG_DATE
from TBL_CUSTOMER# tc
left join TBL_BUY tb
on tc.CUSTOMER_ID = tb.CUSTOMER_ID
where tb.BUY_SEQ is NULL;    
-- ✅ 외부 조인일 때에는 추가 조건은 where 로 합니다. 외부 조인 후에 실행하도록 하기 위함.

-- 문제 요구사항이 구매 이력이 있는 모든 고객을 조회하기
--   이럴 때는 조건만 where tb.BUY_SEQ is NOT NULL;    
--   JOIN 없이 구매 이력이 있는 고객 찾기
select DISTINCT CUSTOMER_ID
from tbl_buy;