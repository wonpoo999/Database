/*
 table join : 2개 이상의 table column을 합치기
        specific column의 값이 같은 것들을 join 하는 것이 의미가 있다.
        참조관계의 테이블을 join하는 것이 일반적이니라. (FK 필수는 아님)
*/
-- ✅ 두 개 이상의 테이블을 "같은 기준 컬럼"을 중심으로 연결해서 하나의 결과로 출력하는 게 JOIN이야.
-- ✅ 테이블이 외래키(FK)로 연결돼 있으면 더 자연스럽지만, 꼭 외래키가 없어도 JOIN은 가능해.
-- ✅ 예: 학생 정보 테이블(tbl_student) + 점수 테이블(tbl_score)을 학번(stuno) 기준으로 연결한다.

----------------------------------------------------

-- // 1. 크로스 조인 (데카르트 곱)
SELECT *
FROM tbl_student, tbl_score; 
-- tbl_student : 5행, tbl_score: 9행 데이터 있음. 
-- tbl_student : 5행, tbl_score: 9행 데이터 있음. 5*9 = 45 행이 만들어짐. (모든 경우의 수)
-- ✅ 크로스 조인은 모든 행을 서로 곱하는 방식. 조건 없이 테이블 2개를 그냥 나란히 놓으면 이렇게 됨.
-- ✅ 조인 조건을 안 썼기 때문에 모든 경우의 조합이 출력됨. 실제로는 거의 안 쓰임. (45행 출력)

----------------------------------------------------

-- 중복 컬럼 stuno : 위의 크로스 조인 결과 중에서 stuno 값이 같은 것만 조회
-- 예상되는 행의 갯수는?
SELECT *
FROM tbl_student stu, tbl_score sco   -- stu, sco 각 테이블의 별칭
WHERE stu.STUNO = sco.STUNO;
-- tbl_student.STUNO = tbl_score.STUNO -- : 2개의 테이블을 합쳤을 때 stuno 값은 같아야 함.
-- ✅ 이건 실제 조인(join)이다. 두 테이블에서 stuno(학번)가 같은 데이터만 보여줘.
-- ✅ tbl_student와 tbl_score 모두 stuno가 있기 때문에, 조건을 줘야 '1:N 관계'가 맞게 연결된다.
-- ✅ 결과는 9행 → tbl_score의 각 점수가 어느 학생(stuno)의 것인지 연결된 상태로 출력됨.

----------------------------------------------------

-- 특정 과목 "국어"만 대상, 이름(stu.Name)과 점수(sco.JUMSU)만 보고 싶을 때
-- ⛔ 오류가 있었던 부분 수정 필요
SELECT sco.SUBJECT, stu.STUNO, stu.Name, sco.JUMSU
FROM TBL_STUDENT stu, TBL_SCORE sco
WHERE stu.STUNO = sco.STUNO 
  AND sco.SUBJECT = '국어'
ORDER BY sco.SUBJECT;

-- ✅ 잘못된 부분: `SYS_CONNECT_BY_PATH`와 `SBUJECT` 오타 수정함.
-- ✅ 조건: 학생과 점수 테이블을 stuno로 연결한 후, 점수에서 '국어' 과목만 선택함.
-- ✅ 출력: 과목명, 학번, 이름, 점수
-- ✅ ORDER BY로 국어만 모아서 정렬됨.

----------------------------------------------------

-- 모든 과목 대상으로 점수가 90 이상인 학생 이름 출력
SELECT stu.name, sco.subject, sco.jumsu
FROM tbl_student stu, tbl_score sco
WHERE stu.stuno = sco.stuno 
  AND sco.jumsu >= 90;

-- ✅ 점수 테이블에서 jumsu(점수)가 90 이상인 데이터만 골라서
-- ✅ 해당 학생 이름(tbl_student.name)과 함께 출력
-- ✅ 학생 이름 + 과목 + 점수가 출력됨
