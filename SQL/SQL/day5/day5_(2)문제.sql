-- 테이블 생성
-- 고객 테이블
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
	category char(2) ,
	pname varchar2(50) NOT NULL,
	price number NOT NULL 
);

-- 구매테이블
CREATE TABLE tbl_buy(
	buy_seq number PRIMARY KEY ,		
	customer_id varchar2(20) NOT NULL ,			
	pcode varchar2(20) NOT NULL ,
	quantity number NOT NULL ,		
	buy_date timestamp
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


-- 시퀀스 생성
CREATE SEQUENCE seq_tblbuy
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
(seq_tblbuy.nextval, 
'mina012' , 'CJBAb12g' , 5,to_date('2024-07-15 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_BUY VALUES 
(seq_tblbuy.nextval, 
'mina012' , 'APLE5kg' , 2,to_date('2024-11-10 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_BUY VALUES 
(seq_tblbuy.nextval, 
'mina012' , 'JINRMn5' , 2,to_date('2025-02-09 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_BUY VALUES 
(seq_tblbuy.nextval, 
'twice' , 'JINRMn5' , 3 ,to_date('2023-12-21 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_BUY VALUES 
(seq_tblbuy.nextval, 
'twice' , 'MANGOTK4r' , 2 ,to_date('2025-01-10 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_BUY VALUES 
(seq_tblbuy.nextval, 
'hongGD' , 'DOWON123a' , 1 ,to_date('2025-01-13 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_BUY VALUES 
(seq_tblbuy.nextval,  
'hongGD' , 'APLE5kg' , 1 ,to_date('2024-09-09 14:33:15','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO TBL_BUY VALUES 
(seq_tblbuy.nextval, 
'hongGD' , 'DOWON123a' , 1 ,to_date('2025-01-13 09:33:15','yyyy-mm-dd hh24:mi:ss'));
SELECT * FROM TBL_BUY tb ;


commit;