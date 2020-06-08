/* [ 그룹함수 ] */
/* 1. avg() : 평균값 반환 */
select avg(salary), avg(commission_pct)
from employees;

select round(avg(salary), 0)
from employees;

select  count(*),
        sum(salary),
        avg(salary)
from employees;
        
select  count(*),
        sum(salary),
        avg(nvl(salary,0)) --> null 데이터를 0으로 변경
from employees;     

/* 2. count() : 데이터의 총 건수를 구하는 함수
    - count(*) : 전체 컬럼 중 제일 수가 많은 row의 개수를 반환 (null이 포함됨)
    - count(컬럼명) : 해당 컬럼의 row 개수를 반환 (null 제외) */
select  count(*), -- null 포함
        count(commission_pct), -- null 제외
        count(first_name), -- null 제외
        avg(salary)
from employees;

-- 급여가 16000을 초과하는 모든 row 출력
select *
from employees
where salary > 16000;

-- 16000을 초과하는 급여와 해당 관리자아이디 개수 출력
select count(*), count(manager_id)
from employees
where salary > 16000;

/* 3. sum() : 데이터들의 합계 값을 구하는 함수 */
select  sum(salary)
from employees;

select  to_char(sum(salary), '999,999')
from employees;

/* max()/min() : 입력된 값들 중 가장 큰 값/작은 값을 구하는 함수 */
select  count(*),
        max(salary),
        min(salary)
from employees;

/* [ GROUP BY절 ] */
-- 부서별 오름차순 정렬
select department_id
from employees
group by department_id -- 부서별
order by department_id asc; -- 부서번호 오름차순

-- 부서별 급여 평균 출력
select  department_id,
        round(avg(salary), 0) -- 반올림
from employees
group by department_id -- 부서별
order by department_id asc; -- 부서번호 오름차순

select department_id,
        job_id,
        count(*),
        sum(salary)
from employees
group by department_id, job_id
order by department_id asc;

/* 예제 */
select  department_id "부서번호",
        count(*) "인원수",
        sum(salary) "급여합계"
from employees
group by department_id
having sum(salary) > 20000
and department_id >= 100;

/* [ CASE ~ END문 ] */
select  employee_id,
        job_id,
        salary,
        case when job_id = 'AC_ACCOUNT' then salary + salary * 0.1
             when job_id = 'SA_REP' then salary + salary * 0.2
             when job_id = 'ST_CLERK' then salary + salary * 0.3
        end realSalary       
from employees
where job_id in ('AC_ACCOUNT', 'SA_REP', 'ST_CLERK');

/* 예제 */
select  first_name "이름",
        department_id "부서",
        case when department_id between 10 and 50 then 'A-TEAM'
             when department_id between 60 and 100 then 'B-TEAM'
             when department_id between 110 and 150 then 'C-TEAM'
             else '팀 없음'
        end team
from employees;        