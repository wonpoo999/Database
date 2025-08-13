DROP TABLE tbl_customer# CASCADE CONSTRAINTS;
DROP TABLE tbl_product CASCADE CONSTRAINTS;
DROP TABLE tbl_buy CASCADE CONSTRAINTS;

-- 기존에 남아 있을 수 있는 시퀀스 충돌 방지
DROP SEQUENCE tbl_buy#_seq;

-- 1. 테이블 이름 : TBL_CUSTOMER# , TBL_PRODUCT , TBL_BUY  으로 테이블을 생성하는 SQL 작성하세요.

CREATE TABLE tbl_customer# (
	customer_id varchar2(20) PRIMARY KEY ,    
	name varchar2(20) NOT NULL,		   
	email varchar2(30),
	age number(3) default 0 ,		
	reg_date date 
);

-- 상품 테이블 
CREATE TABLE tbl_product(
	pcode varchar2(20) PRIMARY KEY ,
	category char(2) NOT NULL,
	pname varchar2(50), 
	price number NOT NULL
);

-- 구매테이블
CREATE TABLE tbl_buy(
	buy_seq number PRIMARY KEY ,		
	customer_id varchar2(20) NOT NULL ,			
	pcode varchar2(20) NOT NULL ,
	quantity number NOT NULL ,		
	buy_date timestamp NOT NULL
);


-- 외래키 추가
ALTER TABLE tbl_buy ADD 
CONSTRAINT fk_buy_customer
FOREIGN KEY (customer_id)				
			REFERENCES tbl_customer#(customer_id);	
		
ALTER TABLE tbl_buy ADD 	
CONSTRAINT fk_buy_pcode
	FOREIGN KEY (pcode)
			REFERENCES tbl_product(pcode);


-- 2. TBL_BUY 테이블의 BUY_SEQ 컬럼을 자동증가 되도록 sequence를 생성하는 DDL 명령을 작성하세요.
--     -  값은 2001부터 시작하고 시퀀스 이름은  tbl_buy#_seq 로 합니다.
CREATE SEQUENCE tbl_buy#_seq
START WITH 2001;

-- insert data
-- 고객 테이블 데이터 추가
INSERT INTO 
	TBL_CUSTOMER# 
VALUES
	('mina012', 
	 '김미나', 
	 'kimm@gmail.com', 
	 20, to_date('2025-03-10 14:23:25','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_CUSTOMER# 
VALUES ('hongGD', '홍길동', 'gil@korea.com', 32, to_date('2023-10-21 11:12:23','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_CUSTOMER# 
VALUES ( 'twice', '박모모', 'momo@daum.net', 29, to_date('2024-12-25 19:23:45','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_CUSTOMER# (customer_id,name,email,reg_date)
VALUES ('wonder', 
		'이나나', 
		'lee@naver.com',
		to_date('2024-12-31 23:58:59','yyyy-mm-dd hh24:mi:ss'));
 /*   
		또는 
    VALUES ('wonder', 
		'이나나', 
		'lee@naver.com',
    null,
    to_date('2024-12-31 23:58:59', 'yyyy-mm-dd hh24:mi:ss'));
*/
SELECT * FROM TBL_CUSTOMER# tc ;
	
-- 상품 테이블 데이터 추가
INSERT INTO TBL_PRODUCT  
VALUES ('DOWON123a', 'B2', '동원참치선물세트', 54000);
INSERT INTO TBL_PRODUCT  
VALUES ('CJBAb12g', 'B1', '햇반 12개입', 14500);
INSERT INTO TBL_PRODUCT  
VALUES ('JINRMn5', 'B1', '진라면 5개입', 6350);
INSERT INTO TBL_PRODUCT  
VALUES ('APLE5kg', 'A1', '청송사과 5kg', 66000);
INSERT INTO TBL_PRODUCT  
VALUES ('MANGOTK4r', 'A2', '애플망고 1kg', 32000);

SELECT * FROM TBL_PRODUCT ;

-- 구매 테이블 데이터 추가
INSERT INTO TBL_BUY VALUES 
(tbl_buy#_seq.NEXTVAL, 
'mina012' , 'CJBAb12g' , 5,to_date('2024-07-15 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_BUY VALUES 
(tbl_buy#_seq.NEXTVAL, 
'mina012' , 'APLE5kg' , 2,to_date('2024-11-10 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_BUY VALUES 
(tbl_buy#_seq.NEXTVAL, 
'mina012' , 'JINRMn5' , 2,to_date('2025-02-09 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_BUY VALUES 
(tbl_buy#_seq.NEXTVAL, 
'twice' , 'JINRMn5' , 3 ,to_date('2023-12-21 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_BUY VALUES 
(tbl_buy#_seq.NEXTVAL, 
'twice' , 'MANGOTK4r' , 2 ,to_date('2025-01-10 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_BUY VALUES 
(tbl_buy#_seq.NEXTVAL, 
'hongGD' , 'DOWON123a' , 1 ,to_date('2025-01-13 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_BUY VALUES 
(tbl_buy#_seq.NEXTVAL,  
'hongGD' , 'APLE5kg' , 1 ,to_date('2024-09-09 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_BUY VALUES 
(tbl_buy#_seq.NEXTVAL, 
'hongGD' , 'DOWON123a' , 1 ,to_date('2025-01-13 09:33:15','yyyy-mm-dd hh24:mi:ss'));
SELECT * FROM TBL_BUY tb ;


-- 3. TBL_BUY 테이블에서 2025년의 구매 내역 모든 컬럼 조회하기

SELECT * FROM TBL_BUY
WHERE EXTRACT(YEAR FROM buy_date) = 2025;

-- 4. TBL_PRODUCT 테이블에서 category 가 ‘B1’ 인 상품명과 가격 조회

SELECT PNAME, PRICE from TBL_PRODUCT
WHERE CATEGORY = 'B1';

-- 5. TBL_CUSTOMER# 테이블에서 email 을  'gmail'  사용하는 고객 이름, 이메일 조회

SELECT name, email FROM TBL_CUSTOMER#
WHERE email like '%gmail.%';

-- ※ 그룹화 함수를 사용하여 SQL 명령을 작성하세요.
-- 8. 상품별 구매건수를  상품코드, 구매건수 출력하여 조회하세요.

SELECT pcode, COUNT(*) AS 구매건수 FROM TBL_BUY
GROUP BY pcode
ORDER BY pcode;


-- 9. 카테고리별 상품의 평균 가격을 카테고리, 평균가격 출력하여 조회하세요.

SELECT category, ROUND(AVG(price), 0) AS 평균가격 FROM TBL_PRODUCT
GROUP BY CATEGORY 
ORDER BY CATEGORY;