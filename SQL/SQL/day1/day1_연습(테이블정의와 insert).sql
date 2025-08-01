CREATE TABLE tbl_cardata (
    idx number(8),
    car varchar2(20),
    model varchar2(20),
    volume number(8),
    weight number(8),
    CO2 number(8)
);

INSERT INTO TBL_CARDATA VALUES (
    21,
    'Skoda',
    'Octavia',
    1600,
    1415,
    99
);

INSERT INTO TBL_CARDATA VALUES(
    22,
    'Volvo',
    'S60',
    2000,
    1415,
    99
);

INSERT INTO TBL_CARDATA VALUES(
    23,
    'Mercedes',
    'CLA',
    1500,
    1465,
    102
);

INSERT INTO TBL_CARDATA VALUES(
    24,
    'Audi',
    'A4',
    2000,
    1490,
    104
);

INSERT INTO TBL_CARDATA VALUES(
    25,
    'Audi',
    'A6',
    2000,
    1725,
    114
);

INSERT INTO TBL_CARDATA VALUES(
    26,
    'Volvo',
    'V70',
    1600,
    1523,
    109
);

INSERT INTO TBL_CARDATA VALUES(
    27,
    'Mercedes',
    'E-Class',
    2100,
    1605,
    115
);

INSERT INTO TBL_CARDATA VALUES(
    28,
    'Volvo',
    'XC70',
    2000,
    1746,
    117
);

INSERT INTO TBL_CARDATA VALUES(
    29,
    'Ford',
    'B-Max',
    1600,
    1235,
    104
);

INSERT INTO TBL_CARDATA VALUES(
    30,
    'Opel',
    'Zafira',
    1600,
    1405,
    109
);

INSERT INTO TBL_CARDATA VALUES(
    31,
    'Mercedes',
    'SLK',
    2500,
    1395,
    120
);

commit;

-- 어떤 종류의 차량이 있는지... 굳이 인덱스 대로 다 가져오지 않고 중복을 제거한 결과 값이니라
select distinct car from TBL_CARDATA;

-- 모든 차량 정보를 조회해오게
SELECT * FROM TBL_CARDATA;

-- 모든 차량의 제조사만 긁어오시게
SELECT car FROM TBL_CARDATA;

-- 차량 제조사와 모델명을 함께 출력하시게
SELECT car, model FROM TBL_CARDATA;

-- 인덱스값이 21인 차량의 정보를 출력해오게
SELECT * FROM TBL_CARDATA WHERE idx = 21;

-- 제조사가 Ford인 차량 정보를 조회해오시게
SELECT * FROM TBL_CARDATA WHERE car = 'Ford';

-- 제조사가 'Mercedes'인 차량을 부분 문자열로 포함한 차량들을 찾아보시게
SELECT * FROM TBL_CARDATA WHERE car LIKE '%Mercedes%';

-- 제조사가 A로 시작하는 차량을 골라오시게
SELECT * FROM TBL_CARDATA WHERE car LIKE 'A%';

-- 인덱스 번호가 23 이상 30 이하인 차량들을 출력하시게
SELECT * FROM TBL_CARDATA WHERE idx BETWEEN 23 AND 30;

-- 인덱스가 24, 26, 31인 차량들만 따로 모아서 보시게
SELECT * FROM TBL_CARDATA WHERE idx IN (24, 26, 31);

-- 인덱스가 27~29가 아닌 차량들을 조회해오게
SELECT * FROM TBL_CARDATA WHERE idx NOT BETWEEN 27 AND 29;

-- 인덱스가 23, 29, 31이 아닌 차량들만 확인하시게
SELECT * FROM TBL_CARDATA WHERE idx NOT IN (23, 29, 31);

-- 인덱스가 NULL이 아닌, 즉 값이 있는 차량만 보시게
SELECT * FROM TBL_CARDATA WHERE idx IS NOT NULL;

-- 제조사 이름을 대문자로 바꾸고, 모델명의 길이도 같이 확인하시게
SELECT UPPER(car) AS "대문자", LENGTH(model) AS "길이" FROM TBL_CARDATA;

-- 배기량이 1800 이상인 차량을 데이터표에서 가져오시오
SELECT * FROM TBL_CARDATA WHERE volume >= 1800;

-- 중량이 1500 이상인 차량의 정보를 출력해오시게
SELECT * FROM TBL_CARDATA WHERE weight >= 1500;

-- 이산화탄소 배출량이 110 이하인 차량을 조회하시게
SELECT * FROM TBL_CARDATA WHERE CO2 <= 110;

-- 제조사가 Volvo이면서 배기량이 1800 이상인 차량을 조회해보시게
SELECT * FROM TBL_CARDATA WHERE car = 'Volvo' AND volume >= 1800;

-- 차량 모델명이 'A'로 시작하는 차량만 골라오시게
SELECT * FROM TBL_CARDATA WHERE model LIKE 'A%';

-- 제조사명이 'e'를 포함하는 차량 정보를 조회하시오
SELECT * FROM TBL_CARDATA WHERE car LIKE '%e%';

-- 배기량이 1600, 2000, 2500인 차량만 추려보시게
SELECT * FROM TBL_CARDATA WHERE volume IN (1600, 2000, 2500);

-- 배기량이 1600에서 2100 사이인 차량을 조회해오게
SELECT * FROM TBL_CARDATA WHERE volume BETWEEN 1600 AND 2100;

-- 차량 목록 중 CO2 배출량이 가장 많은 차량을 찾아보시게
SELECT * FROM TBL_CARDATA WHERE CO2 = (SELECT MAX(CO2) FROM TBL_CARDATA);

-- 제조사명을 대문자로 변환해서 출력해보시게
SELECT UPPER(car) AS "대문자제조사" FROM TBL_CARDATA;

-- 모델명이 5자 이상인 차량의 제조사와 모델을 출력하시게
SELECT car, model FROM TBL_CARDATA WHERE LENGTH(model) >= 5;
