-- ✅ 구매 이력 테이블이 참조하는 테이블은 먼저 삭제해야 외래키 제약 오류 방지
DROP TABLE purchase CASCADE CONSTRAINTS;

-- ✅ 고객 테이블 삭제 (특수문자 포함 테이블명은 반드시 큰따옴표 필요)
DROP TABLE tbl_customer# CASCADE CONSTRAINTS;

-- DROP TABLE tbl_customer CASCADE CONSTRAINTS;

DROP TABLE tbl_product CASCADE CONSTRAINTS;

CREATE TABLE tbl_product (
  pcode    VARCHAR2(20) PRIMARY KEY,   -- 상품 코드
  pname    VARCHAR2(100) NOT NULL,     -- 상품명
  category VARCHAR2(30),               -- 카테고리
  maker    VARCHAR2(50),               -- 제조사 ✅ 추가
  price    NUMBER(10)                  -- 가격 ✅ 추가
);


-- ✅ 고객 정보 저장 테이블 생성
CREATE TABLE tbl_customer# (
  customer_id VARCHAR2(20) PRIMARY KEY,     -- 고객 ID (고유식별자, NOT NULL)
  name        VARCHAR2(100) NOT NULL,       -- 고객 성명
  email       VARCHAR2(100),                -- 이메일 (선택 입력 가능)
  age         NUMBER(3),                    -- 나이 (0~999까지 가능, 제약 조건 없음)
  reg_date    DATE DEFAULT SYSDATE          -- 가입일 (기본값: 현재 날짜)
);

-- CREATE TABLE tbl_customer (
--   customer_id VARCHAR2(20) PRIMARY KEY,     -- 고객 ID (고유식별자, NOT NULL)
--   name        VARCHAR2(100) NOT NULL,       -- 고객 성명
--   email       VARCHAR2(100),                -- 이메일 (선택 입력 가능)
--   age         NUMBER(3),                    -- 나이 (0~999까지 가능, 제약 조건 없음)
--   reg_date    DATE DEFAULT SYSDATE          -- 가입일 (기본값: 현재 날짜)
-- );

-- ⚠️ 주의: "tbl_customer#" 는 반드시 큰따옴표 포함 (소문자+특수문자 포함이므로)
--        → 자바/SQL 코드에서도 반드시 "tbl_customer#" 이렇게 표기해야 인식됨

-- ✅ 구매 이력 테이블 생성
CREATE TABLE purchase (
  customer_id   VARCHAR2(20),                         -- 어떤 고객이
  pcode         VARCHAR2(20),                         -- 어떤 상품을
  quantity      NUMBER(3),                            -- 몇 개 샀는지
  purchase_date DATE DEFAULT SYSDATE,                 -- 언제 샀는지

  PRIMARY KEY (customer_id, pcode, purchase_date),    -- 복합 기본키 (중복 구매 가능하도록 날짜 포함)
  FOREIGN KEY (customer_id) REFERENCES "tbl_customer#"(customer_id), -- 고객 FK
  FOREIGN KEY (pcode) REFERENCES tbl_product(pcode)    -- 상품 FK
);

-- ALTER TABLE tbl_product ADD maker VARCHAR2(50);
