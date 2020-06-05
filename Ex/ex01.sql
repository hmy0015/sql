-- employees 테이블의 모든 Column 검색
select * from employees;

-- departments 테이블의 모든 Column 검색
select * from departments;

-- employees 테이블의 사원 이름(employee_id), 성(last_name), 이름(first_name) 검색
select employee_id, last_name, first_name
from employees;

-- employees 테이블의 성(last_name), 전화번호(phone_number), 입사일(hire_date), 연봉(salary) 검색
select last_name, phone_number, hire_date, salary
from employees;

-- select문에 적은 column의 순서대로 출력됨
select first_name,      -- 성
        last_name,      -- 이름
        email,          -- 이메일
        phone_number,   -- 전화번호
        hire_date       -- 입사일
from employees;

-- 출력할 때 Column에 별명 붙이기
select employee_id as empNO,    -- sql은 대소문자 개념이 없기 때문에 이와 같이 입력시 EMPNO으로 출력 됨
       first_name "E-name",     -- 쌍따옴표 사용 시 => as 생략 가능, 쌍따옴표 안에 있는 글자는 내용 변경 없이 그대로 출력
       salary "연 봉"            -- 별명에 대소문자 구분, 공백, 특수문자 등이 필요한 경우 “ “(쌍 따옴표)로 감싸줌
from employees;

-- 사원(employees)의 이름(first_name), 전화번호(phone_number), 입사일(hire_date), 급여(salary) 검색
select first_name "이름",
       phone_number "전화번호",
       hire_date "입사일",
       salary "급여"
from employees;

-- 사원(employees)의 이름(first_name), 성(last_name), 급여(salary), 전화번호(phone_number), 이메일(email), 입사일(hire_date) 검색
select first_name "이름",
       last_name "성",
       salary "급여",
       phone_number "전화번호",
       email "이메일",
       hire_date "입사일"
from employees;

-- 연결 연산자(Concatenation)로 컬럼들 붙이기 '||' 하나 당 '+' 하나라고 생각하면 됨
select first_name, last_name
from employees;

select first_name, 
        last_name,
        first_name || last_name, -- 이름 + 성
        last_name || first_name "성 + 이름",  -- 성 + 이름 / 별명 붙이기
        first_name || '' || last_name, -- Column들 사이에 공백 추가
        first_name || ' ''의 입사일은'' ' || hire_date -- ‘ ‘(따옴표)를 사용하여 문자를 추가할 수 있음
from employees;

-- 산술 연산자 사용하기(+, -, *, / 을 사용할 수 있음)
select first_name, salary
from employees;

select first_name, salary, salary * 12
from employees;

select first_name, 
        salary,             -- 월급
        salary * 12,        -- 연봉
        (salary + 300) * 12 -- 매달 상여금 300씩
from employees;

-- 문자는 산술 연산자를 사용할 수 없음
select job_id * 12
from employees;

-- 예제문제
select first_name || '-' || last_name "성명", -- 성과 이름사이에 – 로 구분 ex) William-Gietz
        salary "급여",
        salary * 12 "연봉",
        salary * 12 + 5000 "연봉2",
        phone_number "전화번호"
from employees;       

-- [ Where절 ] 비교 연산자
-- 부서번호가 10인 사원의 이름 출력
select first_name
from employees
where department_id = 10;

-- 연봉이 15000 이상인 사원들의 이름과 연봉 출력
select first_name, salary
from employees
where salary >= 15000;

-- 07/01/01 일 이후에 입사한 사원들의 이름과 입사일 출력
select first_name, hire_date
from employees
where hire_date >= '07/01/01';

-- 이름이 Lex인 직원의 연봉 출력
select salary * 12
from employees
where first_name = 'Lex';

-- [ Where절 ] 조건이 2개 이상일 때 한꺼번에 조회
-- 연봉이 14000 이상 17000이하인 사원의 이름과 연봉 출력
select first_name, salary
from employees
where salary >= 14000
and salary <= 17000;

-- 연봉이 14000 이상이거나 17000이하인 사원의 이름과 연봉 출력
select first_name, salary
from employees
where salary >= 14000
or salary <= 17000;

-- 입사일이 04/01/01에서 05/12/31 사이의 사원 이름과 입사일 출력
select hire_date
from employees
where hire_date > '04/01/01'
and hire_date < '05/12/31';

-- [ Where절 ] Between 연산자로 특정구간 값 출력하기
-- 연봉이 14000 이상, 17000이하인 사원의 이름과 연봉 출력
select first_name "이름", salary "연봉"
from employees
where salary between 14000 and 17000;

-- [ Where절 ] IN 연산자로 여러 조건 검사하기
-- 이름이 'Neena', 'Lex', 'John'인 사원의 이름과 성, 연봉 출력
select first_name, last_name, salary
from employees
where first_name in ('Neena', 'Lex', 'John');

-- 연봉이 2100, 3100, 4100, 5100인 사원의 이름과 연봉 출력
select first_name, salary
from employees
where salary in (2100, 3100, 4100, 5100);

-- [ Where절 ] Like 연산자로 비슷한 것들 모두 찾기
-- 이름이 L로 시작하는 사원의 이름, 성, 연봉 출력
select first_name, last_name, salary
from employees
where first_name like 'L%';

-- 이름에 am을 포함한 사원의 이름과 연봉 출력
select first_name, salary
from employees
where first_name like '%am%';

-- 이름의 두 번째 글자가 a인 사원의 이름과 연봉 출력
select first_name, salary
from employees
where first_name like '_a%';

-- 이름의 네 번째 글자가 a인 사원의 이름 출력
select first_name
from employees
where first_name like '___a%';

-- 이름이 4글자인 사원 중 끝에서 두 번째 글자가 a인 사원의 이름 출력
select first_name
from employees
where first_name like '_a__';

-- [ Where절 ] NULL
select first_name, salary, commission_pct, salary * commission_pct
from employees
where salary between 13000 and 15000;

-- is null / is not null
-- 수당이 없는 사원의 이름과 연봉, 수당 출력
select first_name, salary, commission_pct
from employees
where commission_pct is null;

-- 수당이 있는 사원의 이름과 연봉, 수당 출력
select first_name, salary, commission_pct
from employees
where commission_pct is not null;

-- 담당매니저가 없고 수당이 없는 직원의 이름 출력
select first_name
from employees
where manager_id is not null
and commission_pct is not null;

-- [ order by절 ]
-- 직원의 이름과 연봉 출력. 단, 연봉을 내림차순으로 정렬
select first_name, salary
from employees
order by salary desc;

-- 직원의 이름과 연봉 출력. 단, 이름은 오름차순, 연봉은 내림차순으로 정렬
select first_name, salary
from employees
order by salary desc, first_name asc;

-- 연봉 9000 이상의 직원 이름과 연봉을 출력. 단, 연봉을 내림차순으로 정렬
select first_name, salary
from employees
where salary >= 9000
order by salary desc;

-- 부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름 출력
select department_id, salary, first_name
from employees
order by department_id asc;

-- 급여가 1000 이상인 직원의 이름과 급여 출력. 단, 급여가 큰 직원부터 출력
select first_name, salary
from employees
where salary >= 1000
order by salary desc;

-- 부서번호를 오름차순으로 정렬하고, 부서번호가 같으면 급여가 높은 사람부터 부서번호, 급여, 이름 출력
select department_id, salary, first_name
from employees
order by department_id asc, salary desc;