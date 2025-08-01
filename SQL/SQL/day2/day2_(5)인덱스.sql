/*
📌 인덱스(Index)란?
검색 속도 향상을 위한 자료구조
테이블의 특정 컬럼 값을 정렬하고, 해당 값의 물리적 위치(포인터)를 저장
마치 책의 목차처럼, 원하는 데이터를 빠르게 찾을 수 있게 해줌
일반적으로 B-Tree(이진트리)나 Hash Table 구조로 구현됨
인덱스가 없으면 전체 테이블 스캔이 발생해 성능 저하 가능

🔐 기본키(Primary Key)란?
테이블에서 각 행을 고유하게 식별하는 컬럼(또는 컬럼 조합)
자동으로 NOT NULL + UNIQUE 제약 조건이 적용됨
테이블당 하나만 설정 가능
✅기본키를 설정하면 DBMS가 자동으로 고유 인덱스(UNIQUE INDEX)를 생성함
✅ ORACLE은 UNIQUE 컬럼도 자동으로 인덱스를 만들어 준다.

*/
SELECT * FROM tbl_javadict WHERE idx = 4;

-- 기본키 없는 테이블에 기본키 설정
SELECT * FROM TBL_CARDATA;

SELECT * FROM tbl_javadict
where english = 'order';    -- 인덱스가 없는 컬럼. 데이터가 많으면 검색 속도 저하

-- 새로운 연습. 기본키가 없는 테이블에 기본키 설정하기
-- PK의 자격 : Null 값이 없음 + UNIQUE(고유성)
--             ㄴ model 컬럼이 있으나 충분하지 않다. (미래의 값이 고유성 예측이 안됨)
--             ㄴ 해결책 1 : 새로운 컬럼 idx를 만든다. -> PK (다음 진도 sequence)
--             ㄴ 해결책 2 : 기존 컬럼만으로 한다면 (car, model) 복합 컬럼으로 PK를 만든다.

ALTER TABLE TBL_CARDATA ADD CONSTRAINT pk_cardata PRIMARY KEY (car, model);

-- (car, model) 그룹으로 묶었을 때 같은 값이 있으면 기본키 설정할 수 없다.

-- 정렬 : ORDER BY 컬럼명1, 컬럼명2, ...

SELECT * FROM TBL_CARDATA;

SELECT * FROM TBL_CARDATA
ORDER BY car, model;

SELECT * FROM TBL_CARDATA WHERE CAR='Mercedes' AND model='CLA';

-- 컬럼 = column
-- 인덱스를 기본키 컬럼 외에 추가적인 생성을 하고 싶다면?
-- unique 컬럼이 대상이 될 수 있다. - UNIQUE 컬럼이 자동으로 만들어졌는데 중복된 값이 최소인 컬럼, 그리고 검색이 많은 컬럼, 이런 것들의 추가적인 인덱스를 만들 수 있어.
-- 실제 검색할 때 korean 컬럼이 더 많이 쓰일 수 있지만 unique 컬럼은 아니다.
SELECT * FROM TBL_CARDATA;
SELECT * FROM tbl_javadict
where KOREAN = '순서'; 

CREATE INDEX idx_javadict_kor ON tbl_javadict (korean); -- 작명은 우리가 하는겨.

-- Oracle table user_indexes 조회 해볼 수 있어
SELECT * FROM user_indexes WHERE TABLE_NAME = 'TBL_JAVADICT';
