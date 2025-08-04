-- ✅ 0. 기존 객체 제거
DROP TABLE tbl_buy CASCADE CONSTRAINTS;
DROP TABLE tbl_product CASCADE CONSTRAINTS;
DROP TABLE tbl_customer# CASCADE CONSTRAINTS;
DROP SEQUENCE seq_tblbuy;

-- ✅ 1. 고객 테이블 생성
CREATE TABLE tbl_customer# (
  customer_id VARCHAR2(20) NOT NULL,
  name        VARCHAR2(20),
  email       VARCHAR2(30) NOT NULL,
  age         NUMBER(3,0) DEFAULT 0,
  reg_date    DATE DEFAULT SYSDATE,
  PRIMARY KEY (customer_id),
  CONSTRAINT UQ_email UNIQUE (email)
);

-- ✅ 2. 상품 테이블 생성
CREATE TABLE tbl_product (
  pcode    VARCHAR2(20) NOT NULL,
  category CHAR(2)      NOT NULL,
  pname    VARCHAR2(50),
  price    NUMBER,
  PRIMARY KEY (pcode)
);

-- ✅ 3. 구매 테이블 생성 (✅ 컬럼명 수정: quantity)
CREATE TABLE tbl_buy (
  buy_seq     NUMBER       NOT NULL,
  customer_id VARCHAR2(20) NOT NULL,
  pcode       VARCHAR2(20) NOT NULL,
  quantity    NUMBER       NOT NULL,
  buy_date    TIMESTAMP    NOT NULL,
  PRIMARY KEY (buy_seq),
  CONSTRAINT FK_tbl_customer#_TO_tbl_buy FOREIGN KEY (customer_id)
    REFERENCES tbl_customer# (customer_id),
  CONSTRAINT FK_tbl_product_TO_tbl_buy FOREIGN KEY (pcode)
    REFERENCES tbl_product (pcode)
);

-- ✅ 4. 시퀀스 생성
CREATE SEQUENCE seq_tblbuy
  START WITH 2001
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- ✅ 5. COMMENT 주석 추가
COMMENT ON TABLE tbl_customer# IS '고객';
COMMENT ON COLUMN tbl_customer#.reg_date IS '등록날짜';

COMMENT ON TABLE tbl_product IS '상품';
COMMENT ON COLUMN tbl_product.pcode IS '상품코드';
COMMENT ON COLUMN tbl_product.category IS '카테고리';
COMMENT ON COLUMN tbl_product.pname IS '상품명';
COMMENT ON COLUMN tbl_product.price IS '가격';

COMMENT ON TABLE tbl_buy IS '구매';
COMMENT ON COLUMN tbl_buy.buy_seq IS '구매번호';
COMMENT ON COLUMN tbl_buy.customer_id IS '고객_ID';
COMMENT ON COLUMN tbl_buy.pcode IS '상품코드';
COMMENT ON COLUMN tbl_buy.quantity IS '구매수량';
COMMENT ON COLUMN tbl_buy.buy_date IS '구매날짜';

-- ✅ 6. 고객 데이터 입력
INSERT INTO tbl_customer# VALUES ('mina012', '김민아', 'kimm@gmail.com', 20, TO_DATE('2025-03-10 14:23:25', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tbl_customer# VALUES ('hongGD', '홍길동', 'gil@korea.com', 32, TO_DATE('2023-10-21 11:12:23', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tbl_customer# VALUES ('twice', '박모모', 'momo@daum.net', 29, TO_DATE('2024-12-25 19:23:45', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tbl_customer# VALUES ('wonder', '이나나', 'lee@naver.com', NULL, TO_DATE('2024-12-31 23:58:59', 'YYYY-MM-DD HH24:MI:SS'));

-- ✅ 7. 상품 데이터 입력
INSERT INTO tbl_product VALUES ('DOWON123a', 'B2', '동언참치선물세트', 54000);
INSERT INTO tbl_product VALUES ('CJBAb12g', 'B1', '햇반 12개입', 14500);
INSERT INTO tbl_product VALUES ('JINRMn5', 'B1', '진라면 5개입', 6350);
INSERT INTO tbl_product VALUES ('APLE5kg', 'A1', '청송사과 5kg', 28500);
INSERT INTO tbl_product VALUES ('MANGOTK4r', 'A2', '애플망고 1kg', 32000);

-- ✅ 8. 구매 데이터 입력 (시퀀스 사용)
INSERT INTO tbl_buy (buy_seq, customer_id, pcode, quantity, buy_date)
VALUES (seq_tblbuy.NEXTVAL, 'mina012', 'CJBAb12g', 2, TO_TIMESTAMP('2025-01-15 14:33:15', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO tbl_buy (buy_seq, customer_id, pcode, quantity, buy_date)
VALUES (seq_tblbuy.NEXTVAL, 'mina012', 'APLE5kg', 2, TO_TIMESTAMP('2024-11-04 14:33:15', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO tbl_buy (buy_seq, customer_id, pcode, quantity, buy_date)
VALUES (seq_tblbuy.NEXTVAL, 'mina012', 'JINRMn5', 3, TO_TIMESTAMP('2025-01-10 14:33:15', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO tbl_buy (buy_seq, customer_id, pcode, quantity, buy_date)
VALUES (seq_tblbuy.NEXTVAL, 'twice', 'JINRMn5', 2, TO_TIMESTAMP('2025-01-21 14:33:15', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO tbl_buy (buy_seq, customer_id, pcode, quantity, buy_date)
VALUES (seq_tblbuy.NEXTVAL, 'twice', 'MANGOTK4r', 2, TO_TIMESTAMP('2025-01-26 14:33:15', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO tbl_buy (buy_seq, customer_id, pcode, quantity, buy_date)
VALUES (seq_tblbuy.NEXTVAL, 'hongGD', 'DOWON123a', 1, TO_TIMESTAMP('2025-01-13 14:33:15', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO tbl_buy (buy_seq, customer_id, pcode, quantity, buy_date)
VALUES (seq_tblbuy.NEXTVAL, 'hongGD', 'APLE5kg', 1, TO_TIMESTAMP('2024-09-09 14:33:15', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO tbl_buy (buy_seq, customer_id, pcode, quantity, buy_date)
VALUES (seq_tblbuy.NEXTVAL, 'hongGD', 'DOWON123a', 1, TO_TIMESTAMP('2025-01-13 09:33:15', 'YYYY-MM-DD HH24:MI:SS'));

------------------------------------------------------------
-- 문제 1
------------------------------------------------------------
SELECT '📌 문제 1) age >= 30 인 고객 전체 조회 (조건: WHERE age >= 30)' AS 문제 FROM dual;

SELECT '💡 입력 코드: SELECT * FROM tbl_customer# WHERE age >= 30;' AS 입력코드 FROM dual;

-- ✅ 출력 결과
SELECT * FROM tbl_customer# WHERE age >= 30;


------------------------------------------------------------
-- 문제 2
------------------------------------------------------------
SELECT '📌 문제 2) customer_id = ''twice'' 인 고객 이메일 조회 (조건: WHERE)' AS 문제 FROM dual;

SELECT '💡 입력 코드: SELECT email FROM tbl_customer# WHERE customer_id = ''twice'';' AS 입력코드 FROM dual;

-- ✅ 출력 결과
SELECT email FROM tbl_customer# WHERE customer_id = 'twice';


------------------------------------------------------------
-- 문제 3
------------------------------------------------------------
SELECT '📌 문제 3) category = ''A2'' 인 상품명 조회 (조건: WHERE category)' AS 문제 FROM dual;

SELECT '💡 입력 코드: SELECT pname FROM tbl_product WHERE category = ''A2'';' AS 입력코드 FROM dual;

-- ✅ 출력 결과
SELECT pname FROM tbl_product WHERE category = 'A2';


------------------------------------------------------------
-- 문제 4
------------------------------------------------------------
SELECT '📌 문제 4) 상품 가격의 최대값 조회 (MAX 함수 사용)' AS 문제 FROM dual;

SELECT '💡 입력 코드: SELECT MAX(price) AS 최고가격 FROM tbl_product;' AS 입력코드 FROM dual;

-- ✅ 출력 결과
SELECT MAX(price) AS 최고가격 FROM tbl_product;


------------------------------------------------------------
-- 문제 5
------------------------------------------------------------
SELECT '📌 문제 5) ''JINRMn5'' 상품의 총 구매수량 조회 (SUM 함수 + WHERE)' AS 문제 FROM dual;

SELECT '💡 입력 코드: SELECT SUM(quantity) AS 총구매수량 FROM tbl_buy WHERE pcode = ''JINRMn5'';' AS 입력코드 FROM dual;

-- ✅ 출력 결과
SELECT SUM(quantity) AS 총구매수량 FROM tbl_buy WHERE pcode = 'JINRMn5';


------------------------------------------------------------
-- 문제 6
------------------------------------------------------------
SELECT '📌 문제 6) ''mina012'' 고객의 구매기록 전체 조회 (tbl_buy에서 WHERE 조건)' AS 문제 FROM dual;

SELECT '💡 입력 코드: SELECT * FROM tbl_buy WHERE customer_id = ''mina012'';' AS 입력코드 FROM dual;

-- ✅ 출력 결과
SELECT * FROM tbl_buy WHERE customer_id = 'mina012';


------------------------------------------------------------
-- 문제 7
------------------------------------------------------------
SELECT '📌 문제 7) pcode에 ''0'' 포함된 구매상품 조회 (LIKE ''%0%'')' AS 문제 FROM dual;

SELECT '💡 입력 코드: SELECT * FROM tbl_buy WHERE pcode LIKE ''%0%'';' AS 입력코드 FROM dual;

-- ✅ 출력 결과
SELECT * FROM tbl_buy WHERE pcode LIKE '%0%';


------------------------------------------------------------
-- 문제 8
------------------------------------------------------------
SELECT '📌 문제 8) pcode에 ''on'' 포함된 구매상품 조회 (LOWER + LIKE)' AS 문제 FROM dual;

SELECT '💡 입력 코드: SELECT * FROM tbl_buy WHERE LOWER(pcode) LIKE ''%on%'';' AS 입력코드 FROM dual;

-- ✅ 출력 결과
SELECT * FROM tbl_buy WHERE LOWER(pcode) LIKE '%on%';


------------------------------------------------------------
-- 문제 9
------------------------------------------------------------
SELECT '📌 문제 9) 2024년 구매 고객 ID, 이름, 날짜 조회 (JOIN + TO_CHAR)' AS 문제 FROM dual;

SELECT '💡 입력 코드: SELECT c.customer_id, c.name, b.buy_date FROM tbl_customer# c JOIN tbl_buy b ON c.customer_id = b.customer_id WHERE TO_CHAR(b.buy_date, ''YYYY'') = ''2024'';' AS 입력코드 FROM dual;

-- ✅ 출력 결과
SELECT c.customer_id, c.name, b.buy_date
FROM tbl_customer# c
JOIN tbl_buy b ON c.customer_id = b.customer_id
WHERE TO_CHAR(b.buy_date, 'YYYY') = '2024';


------------------------------------------------------------
-- 문제 10
------------------------------------------------------------
SELECT '📌 문제 10) ''twice''의 구매 상품명, 단가, 구매금액 조회 (JOIN + 계산식)' AS 문제 FROM dual;

SELECT '💡 입력 코드: SELECT p.pname, p.price, (p.price * b.quantity) AS 구매금액 FROM tbl_buy b JOIN tbl_product p ON b.pcode = p.pcode WHERE b.customer_id = ''twice'';' AS 입력코드 FROM dual;

SELECT 
    p.pname AS "상품명",
    TO_CHAR(p.price, '999,999') AS "단가",
    TO_CHAR(p.price * b.quantity, '999,999,999') AS "구매금액"
FROM tbl_buy b
JOIN tbl_product p ON b.pcode = p.pcode
WHERE b.customer_id = 'twice';

------------------------------------------------------------
-- 문제 11
------------------------------------------------------------
SELECT '📌 문제 11) 상품코드 별 총 구매수량, 순위 출력 (RANK + GROUP BY)' AS 문제 FROM dual;

SELECT '💡 입력 코드: SELECT pcode, SUM(quantity), RANK() OVER (ORDER BY SUM(quantity) DESC) FROM tbl_buy GROUP BY pcode;' AS 입력코드 FROM dual;

-- ✅ 출력 결과
SELECT 
  pcode AS "상품코드",
  SUM(quantity) AS "총구매수량",
  RANK() OVER (ORDER BY SUM(quantity) DESC) AS "순위"
FROM tbl_buy
GROUP BY pcode
ORDER BY "순위";


------------------------------------------------------------
-- 문제 12
------------------------------------------------------------
SELECT '📌 문제 12) 년도별 구매 건수 집계 (EXTRACT 사용)' AS 문제 FROM dual;

SELECT '💡 입력 코드: SELECT EXTRACT(YEAR FROM buy_date) AS 구매년도, COUNT(*) AS 건수 FROM tbl_buy GROUP BY EXTRACT(YEAR FROM buy_date) ORDER BY 구매년도;' AS 입력코드 FROM dual;

-- ✅ 출력 결과
SELECT 
  EXTRACT(YEAR FROM buy_date) AS "구매년도",
  COUNT(*) AS "건수"
FROM tbl_buy
GROUP BY EXTRACT(YEAR FROM buy_date)
ORDER BY "구매년도";


------------------------------------------------------------
-- 문제 13
------------------------------------------------------------
SELECT '📌 문제 13) 년도별 + 상품코드별 구매 건수 집계 (EXTRACT + GROUP BY 2개)' AS 문제 FROM dual;

SELECT '💡 입력 코드: SELECT EXTRACT(YEAR FROM buy_date) AS 구매년도, pcode, COUNT(*) AS 건수 FROM tbl_buy GROUP BY EXTRACT(YEAR FROM buy_date), pcode ORDER BY 구매년도, pcode;' AS 입력코드 FROM dual;

-- ✅ 출력 결과
SELECT 
  EXTRACT(YEAR FROM buy_date) AS "구매년도",
  pcode AS "상품코드",
  COUNT(*) AS "건수"
FROM tbl_buy
GROUP BY EXTRACT(YEAR FROM buy_date), pcode
ORDER BY "구매년도", "상품코드";

------------------------------------------------------------
-- Extra
------------------------------------------------------------

-- 구매 행(건수) 중에서 구매 금액이 가장 높은 것을 찾아보자. 10번 문제에 customer_id 컬럼 추가 조회
-- 오라클 FETCH 명령이 있습니다.(12c 버전 이상)
-- FETCH 는 결과 행 집합을 커서로 접근 할 수 있습니다.(first, last 등....)
select tp.PCODE,tp.PNAME, tp.PRICE , tp.PRICE*tb.QUANTITY as "구매금액"
from TBL_PRODUCT tp
join TBL_BUY tb
on tp.PCODE = tb.PCODE
order by "구매금액" desc  -- 정렬 필수
FETCH FIRST 1 ROWS ONLY;
