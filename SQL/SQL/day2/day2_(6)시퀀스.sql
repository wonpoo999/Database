/*
시퀀스 sequence : 연달아 일어남 / 일련의 연속 / 연쇄
    자동으로 값을 생성해 줍니다. 정수값을 일정간격으로 생성해줌. (대부분 1 단위씩 증가시키면서 생성해줌)
*/

CREATE SEQUENCE test_sequence;
CREATE SEQUENCE test2_sequence
START WITH 1001;

CREATE SEQUENCE test3_sequence
START WITH 1001
INCREMENT BY 10;

-- 시퀀스에서 사용하는 속성
-- '현재' 시퀀스의 값 currval
-- ' 다음 차례에 오는 sequence의 값 nextval

-- dual table : oracle의 임시 테이블. 함수, 시퀀스 테스트에 사용
-- 값의 나열 : 1, 2, 3, 4....
SELECT test_sequence.nextval FROM dual;
-- 값의 나열 : 1001, 1002, 1003, 1004....
SELECT test2_sequence.nextval FROM dual;
--값의 나열 : 1001, 1011, 1021, 1031..
SELECT test3_sequence.nextval FROM dual;

-- 시퀀스

CREATE TABLE tbl_cardata (
    idx number(8),
    car varchar2(20),
    model varchar2(20),
    volume number(8),
    weight number(8),
    CO2 number(8)
);

INSERT INTO TBL_CARDATA(IDX, CAR, MODEL, VOLUME, WEIGHT, CO2) VALUES ( TEST2_SEQUENCE.NEXTVAL,
    21,
    'Skoda',
    'Octavia',
    1600,
    1415,
    99
);

INSERT INTO TBL_CARDATA(IDX, CAR, MODEL, VOLUME, WEIGHT, CO2) VALUES ( TEST2_SEQUENCE.NEXTVAL,
    22,
    'Volvo',
    'S60',
    2000,
    1415,
    99
);

INSERT INTO TBL_CARDATA(IDX, CAR, MODEL, VOLUME, WEIGHT, CO2) VALUES ( TEST2_SEQUENCE.NEXTVAL,
    23,
    'Mercedes',
    'CLA',
    1500,
    1465,
    102
);

INSERT INTO TBL_CARDATA(IDX, CAR, MODEL, VOLUME, WEIGHT, CO2) VALUES ( TEST2_SEQUENCE.NEXTVAL,
    24,
    'Audi',
    'A4',
    2000,
    1490,
    104
);

INSERT INTO TBL_CARDATA(IDX, CAR, MODEL, VOLUME, WEIGHT, CO2) VALUES ( TEST2_SEQUENCE.NEXTVAL,
    25,
    'Audi',
    'A6',
    2000,
    1725,
    114
);

INSERT INTO TBL_CARDATA(IDX, CAR, MODEL, VOLUME, WEIGHT, CO2) VALUES ( TEST2_SEQUENCE.NEXTVAL,
    26,
    'Volvo',
    'V70',
    1600,
    1523,
    109
);

INSERT INTO TBL_CARDATA(IDX, CAR, MODEL, VOLUME, WEIGHT, CO2) VALUES ( TEST2_SEQUENCE.NEXTVAL,
    27,
    'Mercedes',
    'E-Class',
    2100,
    1605,
    115
);

INSERT INTO TBL_CARDATA(IDX, CAR, MODEL, VOLUME, WEIGHT, CO2) VALUES ( TEST2_SEQUENCE.NEXTVAL,
    28,
    'Volvo',
    'XC70',
    2000,
    1746,
    117
);

INSERT INTO TBL_CARDATA(IDX, CAR, MODEL, VOLUME, WEIGHT, CO2) VALUES ( TEST2_SEQUENCE.NEXTVAL,
    29,
    'Ford',
    'B-Max',
    1600,
    1235,
    104
);

INSERT INTO TBL_CARDATA(IDX, CAR, MODEL, VOLUME, WEIGHT, CO2) VALUES ( TEST2_SEQUENCE.NEXTVAL,
    30,
    'Opel',
    'Zafira',
    1600,
    1405,
    109
);

INSERT INTO TBL_CARDATA(IDX, CAR, MODEL, VOLUME, WEIGHT, CO2) VALUES ( TEST2_SEQUENCE.NEXTVAL,
    31,
    'Mercedes',
    'SLK',
    2500,
    1395,
    120
);

SELECT * FROM TBL_CAR_CO2;

-- 다시 초기화 테스트
TRUNCATE TABLE TBL_CARDATA; --테이블 데이터 모두 삭제
SELECT * FROM TBL_CARDATA;
DROP SEQUENCE TEST2_SEQUENCE; -- 시퀀스 삭제

-- create sequence
-- insert 실행