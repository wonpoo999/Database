-- dual table : 수식, 함수 연산 테스트할 때 사용하는 임시 테이블 (oracle에만 있는 임시 테이블)

select 2+3 from dual;

-- 날짜 함수
SELECT sysdate from dual;
SELECT to_char(sysdate , 'yyyy-mm-dd hh24:mi:ss') from dual;  --24 기준
SELECT to_char(sysdate , 'yyyy-mm-dd hh24:mi:am') from dual;  --12 기준
-- to_char() 함수 패턴은 위의 포맷에서 년도, 월, 일, 시, 분, 초 각각을 출력도 가능합니다.
-- extract ( year from sysdate) , extract (month from sysdate) , extract (day from sysdate)

-- decimal 3자리까지 초를 표시해줘 (millisecond)
SELECT SYSTIMESTAMP from dual;

-- 날짜 타입의 연산이 가능 : 특히 날짜 사이의 차이를 알 수 있지만 날짜 타입으로 해야한다. 문자열로하면 안돼.
-- 문자열을 날짜 타입으로 변환 : to_date 함수를 통해서 

-- 날짜 사이의 차이를 구할 때 : 일일 수
-- '2025-08-04' 과 '2025-12-25' 의 차이
-- 시간이 0시 기준이니라.
select to_date('2025-12-25', 'yyyy-mm-dd') - to_date('2025-08-04', 'yyyy-mm-dd') from dual;
select to_date('2025-12-25', 'yyyy-mm-dd') - trunc(sysdate) from dual;
select to_date('2025-12-25', 'yyyy-mm-dd') - sysdate from dual;
select trunc(to_date('2025-12-25', 'yyyy-mm-dd') - sysdate+1) from dual;
select trunc(to_date('2025-08-06', 'yyyy-mm-dd') - sysdate+1) from dual;
-- +1 넣은 이유는 반올림 때문에 하루 이하를 하루로 치지 않는 문제를 해결하기 위해서다. 그러지 않으면 하루 차이나 마찬가지인 12시간 남은 것도 0으로 처버려서 오해가 생길 수 있다.ALTER

-- 뺄셈 대신에 DATEDIFF 함수 : 아... 이거 MYSQL 함수지 오라클 함수는 아니기에 참고만 하게나

-- 날짜 사이의 차이를 구할 때 : 개월 수 단위 (월 값만 가지고 뺄셈으로 못함.)
SELECT MONTHS_BETWEEN(sysdate , to_date('2026-02-01', 'yyyy-mm-dd')) from dual;   -- MONTHS-BETWEEN은 이미 차이를 찾는 식이라 뺄셈을 넣을 필요가 없다

-- 날짜 더하기 연사
select sysdate + 3 from dual;
select ADD_MONTHS(sysdate, 15)
from dual;