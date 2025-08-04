-- tbl_buy 와 tbl_customer , tbl_buy와 tbl_product  각각 참조관계 일때
-- 3개의 테이블 join 가능합니다.

select tb.BUY_SEQ , 
tc.CUSTOMER_ID, 
tc.NAME,
tp.PCODE,
tp.PNAME,
tp.PRICE *tb.QUANTITY as "구매금액"
from TBL_BUY tb    -- 자식테이블을 from 뒤에 작성하기
JOIN TBL_CUSTOMER# tc ON tb.CUSTOMER_ID = tc.CUSTOMER_ID
JOIN TBL_PRODUCT tp ON tb.PCODE = tp.PCODE;

-- 3개 이상의 조인은 쿼리 성능을 떨어뜨릴 수 있습니다.
-- 대부분은 2개 테이블의 조인으로 요구사항을 처리할 수 있습니다.