/*
- OVER는 함수 자체는 아니며 분석(통계) 함수와 함께 쓰이는 절(Clause)
- RANK(), ROW_NUMBER(), SUM(), AVG() 같은 함수들이 어떻게 계산될지 범위를 지정해주는 역할
- PARTITION BY를 이용하여 OVER 절 안에서 그룹화 역할
- '원래 행을 유지하면서' 추가 정보(함수결과) 표시
-  각 행에 대해 그룹 내 집계 결과를 보고 싶을 때
*/
SELECT 
  car,
  model,
  co2,
  avg(co2) OVER(ORDER BY car) AS "co2평균"   -- car 컬럼 정렬 후 같은값끼리 묶어서 co2 평균 구하기
FROM tbl_car_co2;

SELECT 
  distinct car,
  avg(co2) OVER(ORDER BY car) AS "co2평균"   -- car 컬럼 정렬 후 같은값끼리 묶어서 co2 평균 구하기
FROM tbl_car_co2;

-- OVER 는 순위(RANK 함수)를 구할 때
-- co2 기준. 값이 작은 것이 순위를 1부터
-- 1) rank() 같은 값은 같은 순위
SELECT 
  car,
  model,
  co2,
  rank() OVER(ORDER BY co2) AS "co2순위"   -- co2 로 정렬(내림차순) 후에 순위를 매김
FROM tbl_car_co2;

-- 2) row_number() 같은 값도 다른 순위(임의)
SELECT 
  car,
  model,
  co2,
  row_number() OVER(ORDER BY co2) AS "co2순위"   -- co2 로 정렬(내림차순) 후에 순위를 매김
FROM tbl_car_co2;

-- 3) rank() : 특정 컬럼(car) 그룹안에서 순위
SELECT 
  car,
  model,
  co2,
  rank() OVER(PARTITION BY car ORDER BY co2) AS "co2rank"   -- co2 로 정렬(내림차순) 후에 순위를 매김
FROM tbl_car_co2;

-- rank 결과에 조건을 이용한 검색을 하려면 '서브쿼리' 사용
-- 서브쿼리 : select 안에서 from 또는 where 에서 사용되는 다른 select
-- 요구사항 : 동일한 car 그룹안에서 co2가 제일 적은(min) 1등 모델을 조회하기
select * 
from  -- 테이블명 대신에 다른 select 결과를 사용
  (SELECT 
    car,
    model,
    co2,
    rank() OVER(PARTITION BY car ORDER BY co2) AS "co2rank"   
  FROM tbl_car_co2)
where "co2rank"=1;   -- "co2rank" 컬럼 인식

-- 오류 : "co2rank": invalid identifier 
SELECT 
    car,
    model,
    co2,
    rank() OVER(PARTITION BY car ORDER BY co2) AS "co2rank"   -- 새로 생긴 컬럼
FROM tbl_car_co2
where "co2rank"=1;   -- 새로 생긴 rank 컬럼은 여기 where에 바로 사용 못함.

-- 요구사항 : 동일한 car 그룹안에서 co2가 제일 많은(max) 1등 모델을 조회하기
select * 
from  
  (SELECT 
    car,
    model,
    co2,
    rank() OVER(PARTITION BY car ORDER BY co2 desc) AS "co2rank"  
     --car 가 같은 행들끼리 co2로 정렬하여 순위매김 
  FROM tbl_car_co2)
where "co2rank"=1;
-- desc 는 오름 차순 : 큰값 -> 작은값

-- 직접 테이블에서 확인해보세요.
select *
FROM TBL_CAR_CO2
ORDER BY car, co2 desc;   -- car는 오름차순 , 같은 car 값 행은 co2 내림차순 정렬