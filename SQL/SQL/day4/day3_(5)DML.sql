-- DML : select, insert, update, delete
--       테이블의 행을 대상으로 하는 명령어

-- insert into 테이블명(컬럼명1, 컬럼명2,...) values (값1,값2,....);

-- update 테이블 이름 set 컬럼명1=값1, 컬럼명2=값2,...where 조건식;
--            조건에 맞는 행의 컬럼명1,컬럼명2 값을 값1,값2 로 변경

-- delete from 테이블 이름 where 조건식;
-- 주의 : update 와 delete 는 where 없이 사용하면 위험.!!!

-- insert, update, delete 는 변경사항에 대해 바로 테이블에 반영(커밋) 하지않고
--        '트랜잭션' 관리차원에서 commit 명령어로 수행하는게 바람직!!!
--        rollback 은 마지막 commit 후에 실행한 DML 을 취소(되돌리기) 합니다.
--        트랜잭션 : 하나의 논리적인 업무를 수행하는 단위(여러개의 DML 명령으로 구성)

CREATE TABLE tbl_student(
  stuno CHAR(7) PRIMARY KEY ,   -- 학번
  name VARCHAR2(30) NOT NULL,   -- 이름
  age NUMBER CHECK (age BETWEEN 10 AND 30),
  address VARCHAR2(100)
);
-- null 이 허용되는 컬럼은?  age , address

INSERT INTO TBL_STUDENT(stuno, name) VALUES('2025003','김모모');
INSERT INTO TBL_STUDENT(stuno, name) VALUES('2025004','최사나');
INSERT INTO TBL_STUDENT(stuno, name) VALUES('2025005','이하니');

SELECT * FROM TBL_STUDENT;     -- 커밋 전이지만 insert 와 같은 세션이므로 조회
-- 테이블에 직접 가서 데이터 탭을 확인하면 행 추가 안되어있음.(세션이 다름.)
COMMIT;
-- 1차 커밋 후 update
UPDATE TBL_STUDENT SET age=21 WHERE STUNO='2025003';
SELECT * FROM TBL_STUDENT WHERE STUNO='2025003' ;  -- 변경 내용 확인

-- rollback 되돌리기
ROLLBACK;
SELECT * FROM TBL_STUDENT WHERE STUNO='2025003' ;

-- 2차 커밋
UPDATE TBL_STUDENT SET age=21 WHERE STUNO='2025003';
commit;

-- 2차 커밋 후에 delete
DELETE FROM TBL_STUDENT WHERE STUNO='2025004';
DELETE FROM TBL_STUDENT WHERE STUNO='2025005';
SELECT * FROM TBL_STUDENT;
ROLLBACK;