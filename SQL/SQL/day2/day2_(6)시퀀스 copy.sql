/*
시퀀스 sequence : 연달아 일어남, 일련의 연속
     자동으로 값을 생성해 줍니다. 정수값을 일정간격(대부분 1)으로 증가시키면서 생성.
     ✅ 시퀀스를 이용하여 기본키의 값을 자동 생성합니다.
*/

-- 기존 객체 삭제 (기존에 있던 것들로 충돌나는 오류 방지)
DROP SEQUENCE test_seq;
DROP SEQUENCE test2_seq;
DROP SEQUENCE test3_seq;
DROP TABLE tbl_car_co2;

-- 시퀀스 생성
CREATE SEQUENCE test_seq;

CREATE SEQUENCE test2_seq
START WITH 1001;

CREATE SEQUENCE test3_seq
START WITH 1001
INCREMENT BY 10;

-- 시퀀스에서 사용하는 속성
--  '현재' 시퀀스의 값 currval
--  '다음차례' 시퀀스의 값 nextval

-- dual 테이블 : 오라클의 임시 테이블. 함수, 시퀀스 테스트에 사용

-- 값의 나열 : 1,2,3,4....
SELECT test_seq.nextval FROM dual;

-- 값의 나열 : 1001,1002,1003,1004....
SELECT test2_seq.nextval FROM dual;

-- 값의 나열 : 1001,1011,1021,1031....
SELECT test3_seq.nextval FROM dual;

-- 시퀀스를 기본키에 사용하기

CREATE TABLE tbl_car_co2 (
  idx NUMBER PRIMARY KEY,
  car VARCHAR2(20),
  model VARCHAR2(20),
  volume NUMBER(8),
  weight NUMBER(8),
  co2 NUMBER(8)
);

-- 유일한 값을 가져야하는 idx PK 컬럼 값을 시퀀스로 주겠습니다.
INSERT INTO tbl_car_co2(idx, car, model, volume, weight, co2) 
VALUES (test2_seq.nextval, 'Toyota', 'Aygo', 1000, 790, 99);

INSERT INTO tbl_car_co2(idx, car, model, volume, weight, co2)
VALUES (test2_seq.nextval, 'Mitsubishi', 'Space Star', 1200, 1160, 95);

INSERT INTO tbl_car_co2(idx, car, model, volume, weight, co2) 
VALUES (test2_seq.nextval, 'Skoda', 'Citigo', 1000, 929, 95);

INSERT INTO tbl_car_co2(idx, car, model, volume, weight, co2) 
VALUES (test2_seq.nextval, 'Mini', 'Cooper', 1500, 1140, 105);

INSERT INTO tbl_car_co2(idx, car, model, volume, weight, co2) 
VALUES (test2_seq.nextval, 'VW', 'Up!', 1000, 929, 105);

INSERT INTO tbl_car_co2(idx, car, model, volume, weight, co2) 
VALUES (test2_seq.nextval, 'Skoda', 'Fabia', 1400, 1109, 90);

INSERT INTO tbl_car_co2(idx, car, model, volume, weight, co2) 
VALUES (test2_seq.nextval, 'Ford', 'Fiesta', 1500, 1112, 98);

INSERT INTO tbl_car_co2(idx, car, model, volume, weight, co2) 
VALUES (test2_seq.nextval, 'Ford', 'Fiesta', 1000, 1112, 99);

-- 데이터 확인
SELECT * FROM tbl_car_co2;

-- 다시 초기화 테스트
TRUNCATE TABLE tbl_car_co2;  -- 테이블 데이터 모두 삭제
SELECT * FROM tbl_car_co2;
DROP SEQUENCE test2_seq;     -- 시퀀스 삭제

-- 다시 시퀀스 생성
CREATE SEQUENCE test2_seq
START WITH 1001;
