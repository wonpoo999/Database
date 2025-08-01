-- 기존: 학생 테이블 생성
CREATE TABLE tbl_student(
  stuno CHAR(7) PRIMARY KEY ,        -- 학번 (고정 길이 7자리 문자형) ✅ PRIMARY KEY: 중복불가 + NOT NULL
  name VARCHAR2(30) NOT NULL,       -- 이름 (최대 30자까지 입력 가능) ✅ 반드시 입력해야 함
  age NUMBER CHECK (age BETWEEN 10 AND 30),  -- 나이 (숫자), 10~30 사이여야만 허용됨 ✅ 제약조건 CHECK
  address VARCHAR2(100)             -- 주소 (최대 100자), NULL 허용됨
);
/*
 * ❗ NULL 이 허용되는 컬럼은? 👉 age, address
 * name은 NOT NULL, stuno는 PRIMARY KEY(자동으로 NOT NULL)라서 NULL 불가
 */

-- 🔄 데이터 초기화 (기존 데이터 삭제 후 새로 삽입)
TRUNCATE TABLE tbl_student;

-- ✅ INSERT 문에서 컬럼 순서와 값 개수 반드시 일치해야 함
INSERT INTO TBL_STUDENT(stuno, name, age, address) VALUES('2025003','김모모', 23, '서울시');
INSERT INTO TBL_STUDENT(stuno, name, age, address) VALUES('2025004','최사나', 22, '수원시');
INSERT INTO TBL_STUDENT(stuno, name, age, address) VALUES('2025005','이하니', 25, '경기도');
INSERT INTO TBL_STUDENT(stuno, name, age, address) VALUES('2023001','이사나', 24, '서울시');
INSERT INTO TBL_STUDENT(stuno, name, age, address) VALUES('2024004','박다현', 21, '성남시');

-- 📋 현재 학생 테이블 전체 데이터 확인
SELECT * FROM TBL_STUDENT;

-- 💾 변경사항 저장
COMMIT;

-- ---------------------
-- 자식 테이블 생성
-- tbl_score : tbl_student 와 참조관계 (외래키 존재)
-- 요구사항: 학생 1명이 같은 과목을 여러 번 수강할 수 있음 (즉, 1:N 관계)
-- ---------------------
CREATE TABLE tbl_score(
    idx NUMBER PRIMARY KEY,             -- 기본키로 사용할 일련번호 (중복불가)
    stuno CHAR(7) NOT NULL,             -- 학생번호: 부모 테이블의 stuno를 참조
    subject VARCHAR2(20) NOT NULL,      -- 과목명 (예: 국어, 영어, 수학)
    jumsu NUMBER NOT NULL,              -- 점수
    teacher VARCHAR2(100) NOT NULL,     -- 담당교사명
    term CHAR(7) NOT NULL,              -- 수강학기 (예: 2024_02) 🔍 기존 오류 원인! CHAR(6) → CHAR(7)로 늘림

    -- 🔗 외래키 설정 (부모 테이블: TBL_STUDENT의 stuno를 참조)
    FOREIGN KEY(stuno)
        REFERENCES TBL_STUDENT(stuno)   -- 부모 테이블이 먼저 존재해야 참조 가능
);
select term from tbl_score;
alter table tbl_score modify term char(10);
-- 🔍 오류 방지 팁:
-- ⚠️ term 값이 '2024_02'처럼 7글자이므로, CHAR(6)일 경우 오류 발생 (ORA-12899)
-- ⚠️ 선생님이 오류 없이 되었던 이유는 term 컬럼 길이를 더 길게 했거나, VARCHAR2 사용했을 가능성 있음

-- ✅ 정상 실행 가능한 INSERT
INSERT INTO TBL_SCORE VALUES (2, '2023001', '국어', 88, '고길동', '2024_02');
INSERT INTO TBL_SCORE VALUES (3, '2025003', '국어', 88, '고길동', '2024_02');
INSERT INTO TBL_SCORE VALUES (4, '2025004', '국어', 95, '고길동', '2024_02');
INSERT INTO TBL_SCORE VALUES (5, '2023001', '수학', 88,   '둘리', '2024_02');
INSERT INTO TBL_SCORE VALUES (6, '2025003', '수학', 88,   '둘리', '2025_01');
INSERT INTO TBL_SCORE VALUES (7, '2024004', '수학', 93,   '둘리', '2024_02');
INSERT INTO TBL_SCORE VALUES (8, '2025004', '영어', 88, '마이클', '2024_02');
INSERT INTO TBL_SCORE VALUES (9, '2025005', '영어', 91, '마이클', '2024_02');

COMMIT;

-- 학번으로 성적 조회하기
SELECT * FROM TBL_SCORE WHERE stuno='2025004';

-- 🔍 학번 검색 빠르게 하기 위해 인덱스 추가
CREATE INDEX index_score_stuno ON tbl_score (stuno);

-- 🔍 일련번호 자동 증가를 위한 시퀀스 설정
CREATE SEQUENCE seq_score_idx START WITH 10;

-- 확인용
SELECT seq_score_idx.nextval FROM dual;
