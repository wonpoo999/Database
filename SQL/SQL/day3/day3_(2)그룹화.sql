-- 그룹화 연습을 위해 tbl_car_co2 에 행 데이터 변경(최종 31개)  👇 아래 쪽에 있음.
/*
    그룹화 : 지정된 컬럼값이 같은 행들을 하나의 그룹으로 묶고
             집계 함수를 그룹 단위로 적용.
    지정된 컬럼은 그룹화 컬럼 : 대체로 같은 값이(중복) 많은 컬럼들이 대상이 됩니다.
            그룹화 컬럼에 대해 집계 함수를 적용.

            SELECT 그룹화컬럼, 함수(Number컬럼)
            FROM 테이블명
            [WHERE] 조건식(테이블의 모든 행/컬럼 대상으로 필터링)
            [ORDER BY] 정렬 컬럼(그룹화 하기전에 정렬.- 의미없음)
            GROUP BY 그룹화 컬럼 🔥
            [HAVING] 조건식(그룹화 결과 행/컬럼만 대상으로 합니다.)
            [ORDER BY] 정렬 컬럼(그룹화 후에 정렬);
*/
-- 그룹화 컬럼을 탐색하기위한 정렬
SELECT *
FROM TBL_CAR_CO2
ORDER BY car;

-- CAR 컬럼으로 그룹화 : 조회는 그룹화 컬럼 car, 함수를 적용한 결과 입니다.
SELECT car, COUNT(*)
FROM TBL_CAR_CO2
GROUP BY car;

-- avg 함수 실행이 가능한 모든 컬럼 사용
SELECT car, round(avg(VOLUME)),round(avg(WEIGHT)),round(avg(CO2))
FROM TBL_CAR_CO2
GROUP BY car;

-- 그룹화 하기 전에 조건식 (그룹화 대상이 되는 행)
SELECT car, round(avg(VOLUME)),round(avg(WEIGHT)),round(avg(CO2))
FROM TBL_CAR_CO2
WHERE WEIGHT > 1200     -- 그룹화 대상 필터링
GROUP BY car;

-- 요구사항 : 자동차 브랜드별로 CO2 평균을 구하고 평균값이 100 미만 조회
SELECT car, round(avg(CO2)) as "CO2평균"
FROM TBL_CAR_CO2
GROUP BY car
HAVING round(avg(CO2)) < 100   -- HAVING 조건식에는 별칭 사용 못합니다.
ORDER BY "CO2평균";

-- 2개 이상 컬럼으로 그룹화
SELECT CAR, MODEL, COUNT(*) AS "개수", ROUND(AVG(CO2)) AS "CO2 평균" 
FROM TBL_CAR_CO2 
GROUP BY CAR, MODEL;   -- car 컬럼에 동일한 값이 많고, model 컬럼도 동일한 값이 많을 때
-- (CAR, MODEL) 페어. 1차 그룹화 car 컬럼, 1차 그룹 안에서 2차 그룹화 model 컬럼


-- ✅ 복습 : 그룹화 연습을 위해 tbl_car_co2 에 행 데이터 변경(최종 31개)  
CREATE SEQUENCE seq_carco2
START WITH 10001;
-- 시퀀스 다음 값 가져오기 : seq_carco2.nextval
-- 테이블의 기존 데이터 삭제하기 
TRUNCATE TABLE tbl_car_co2;
-- 데이터 모두 insert
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Toyota', 'Aygo', 1000, 790, 99);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Mitsubishi', 'Space Star', 1200, 1160, 95);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Skoda', 'Citigo', 1000, 929, 95);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Mini', 'Cooper', 1500, 1140, 105);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'VW', 'Up!', 1000, 929, 105);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Skoda', 'Fabia', 1400, 1109, 90);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Mercedes', 'A-Class', 1500, 1365, 92);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Ford', 'Fiesta', 1500, 1112, 98);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Audi', 'A1', 1600, 1150, 99);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Hyundai', 'I20', 1100, 980, 99);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Suzuki', 'Swift', 1300, 990, 101);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Ford', 'Fiesta', 1000, 1112, 99);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Honda', 'Civic', 1600, 1252, 94);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Hundai', 'I30', 1600, 1326, 97);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Opel', 'Astra', 1600, 1330, 97);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Skoda', 'Rapid', 1600, 1119, 104);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Ford', 'Focus', 2000, 1328, 105);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Ford', 'Mondeo', 1600, 1584, 94);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Opel', 'Insignia', 2000, 1428, 99);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Mercedes', 'C-Class', 2100, 1365, 99);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Skoda', 'Octavia', 1600, 1415, 99);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Volvo', 'S60', 2000, 1415, 99);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Mercedes', 'CLA', 1500, 1465, 102);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Audi', 'A4', 2000, 1490, 104);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Audi', 'A6', 2000, 1725, 114);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Volvo', 'V70', 1600, 1523, 101);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Mercedes', 'E-Class', 2100, 1605, 115);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Volvo', 'XC70', 2000, 1746, 100);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Ford', 'B-Max', 1600, 1235, 104);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
 VALUES (seq_carco2.nextval,'Opel', 'Zafira', 1600, 1405, 109);
INSERT INTO TBL_CAR_CO2(IDX,CAR,MODEL,VOLUME,WEIGHT,CO2) 
VALUES (seq_carco2.nextval, 'Mercedes', 'SLK', 2500, 1395, 120);