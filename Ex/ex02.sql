/* 단일행 함수 */

/* 문자함수 */

/* 1. INITCAP(컬럼명) : 영어의 첫 글자만 대문자, 나머지는 모두 소문자로 출력해주는 함수
[ 문제 ] 부서아이디가 100인 사원의 기존 이메일, 이메일2, 부서아이디 출력.
( 조건 - 이메일2에 출력될 이메일들은 첫 글자만 대문자, 나머지는 소문자로 출력하며 이메일 아이디 뒤에 gmail.com을 붙일 것 ) */
select email "E-Mail",
       initcap(email) || '@gmail.com' as "E-Mail 2",
       department_id "부서아이디"
from employees
where department_id = 100;

/* 2. LOWER(컬럼명) / UPPER(컬럼명) : 입력되는 값을 전부 소문자/대문자로 변경하는 함수
[ 문제 ] 부서아이디가 100인 사원의 이름을 모두 소문자/대문자로 출력 */
select first_name, lower(first_name), upper(first_name)
from employees
where department_id = 100;

/* 3. SUBSTR(컬럼명, 시작위치, 글자수) : 주어진 문자열에서 특정길이의 문자열을 구하는 함수
[ 문제 ] 부서아이디가 100인 사원의 이름을 첫 글자부터 3번째까지 출력, 뒤에서 3번째 글자부터 2번째까지 출력 */
select first_name, 
       substr(first_name, 1, 3), 
       substr(first_name, -3, 2)
from employees
where department_id = 100;

/* 4. LPAD/RPAD(컬럼명, 글자수, '채울문자') : 출력할 글자수를 지정하고, 공백인 부분의 왼쪽 또는 오른쪽을 지정한 문자로 채우기 */
select first_name,
       lpad(first_name, 10, '*'),
       rpad(first_name, 10, '*')
from employees;

/* 5. REPLACE(컬럼명, 문자1, 문자2) : 컬럼명에서 문자1을 문자2로 바꾸는 함수 */
select first_name,
       replace(first_name, 'a', '*'),
       replace(first_name, substr(first_name, 2, 3), '***')
from employees
where department_id = 100;

/* 6. TRIM/RTRIM/LTRIM : 문자열의 공백을 없애주는 함수 */
select ltrim('    aaaa    ') || '-',
       rtrim('    aaaa    ') || '-',
       trim('    aaaa    ') || '-'
from employees;


/* 숫자함수 */
/* 1. ROUND(숫자, 출력을 원하는 자리수) : 주어진 숫자의 반올림을 하는 함수 */
select round(123.346, 2) "r02",
       round(123.346, 0) "r0",
       round(123.346, -1) "r-1"
from dual;

/* 2. TRUNC(숫자, 출력을 원하는 자리수) : 주어진 숫자의 버림을 하는 함수 */
select trunc(123.346, 2) "r02",
       trunc(123.346, 0) "r0",
       trunc(123.346, -1) "r-1"
from dual;      

/* 날짜함수 */
/* 1. SYSDATE : 현재날짜와 시간을 출력해주는 함수 */
select sysdate
from dual;

/* 2. MONTHS_BETWEEN(d1, d2) : d1 날짜와 d2 날짜의 개월수를 출력하는 함수 */
select sysdate "현재 날짜",
       hire_date "입사일",
       months_between(sysdate, hire_date) "입사 후 개월수",
       trunc(months_between(sysdate, hire_date), 0) "소수점 버림"
from employees
where department_id = 10;

/* 변환함수 */
/* 1. TO_CHAR(n, fmt) : 숫자를 문자로 */
select first_name,
       salary * 12,
       to_char(salary * 12, '99999'), -- 다섯자리까지만 표시
       to_char(salary * 12, '099999'), -- 빈자리를 0으로 채우기
       to_char(salary * 12, '$99999'), -- $붙여서 표시
       to_char(salary * 12, '99999.99'), -- 소수점 이하 표시
       to_char(salary * 12, '99,999') -- 천 단위 구분 기호 표시
from employees
where department_id = 110;

/* 2. TO_CHAR(d, fmt) : 날짜를 문자로 */
select sysdate,
       to_char(sysdate, 'YYYY-MM-DD') "YYYY-MM-DD", -- 년-월-일
       to_char(sysdate, 'MON') "MON", -- 월을 뜻하는 이름 표현
       to_char(sysdate, 'DAY') "DAY", -- 요일을 표현
       to_char(sysdate, 'DDTH') "DDHT", -- 몇 번째 날인지 표현
       to_char(sysdate, 'HH24 : MI : SS') "HH24 : MI : SS" -- 시 : 분 : 초 (HH24 => 하루를 24시간으로 표현, HH => 하루를 12시간으로 표현)
from employees;       

/* 3. NVL(컬럼명, NULL일 때 값) / NVL2(컬럼명, NULL이 아닐 때 값, NULL일 때 값) */
select  first_name,
        commission_pct,
        nvl(commission_pct, 0),
        nvl2(commission_pct, 100, 0),
        salary * commission_pct "연봉 * 수당",
        salary * nvl(commission_pct, 0) "연봉 * 수당2"
from employees;        