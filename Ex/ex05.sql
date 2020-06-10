/* [ SubQuery ] */

/* 단일행 SubQuery */
-- Den보다 급여가 많은 사원의 이름과 급여는?
select employee_id,
        first_name,
        salary
from employees
where salary > ( select salary
                 from employees
                 where first_name = 'Den' );
             
-- 급여가 가장 적은 사원의 이름과 급여, 사원번호 출력                 
select first_name,
       salary,
       employee_id
from employees       
where salary = ( select min(salary)
                 from employees );

-- 급여 평균보다 적게 받는 사원의 이름, 급여, 사원번호 출력                
select first_name,
        salary,
        employee_id
from employees      
where salary < ( select avg(salary)
                 from employees );

/* 다중행 SubQuery */
-- 부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여 출력
select employee_id, first_name, salary
from employees
where salary in ( select salary
                  from employees
                  where department_id = 110 );
                  
-- 각 부서별로 최고 급여를 받는 사원 출력
select department_id "부서번호", first_name "이름", salary "급여"
from employees
where ( department_id, salary ) in ( select department_id,
                                            max(salary)
                                     from employees
                                     group by department_id )
order by department_id asc;

-- 부서번호가 110인 직원의 급여보다 큰 모든 직원의 사번, 이름, 급여 출력
-- (or 연산 --> 급여가 8300보다 큰)
select employee_id, first_name, salary
from employees
where salary > any ( select salary
                     from employees
                     where department_id = 110 );

-- 부서번호가 110인 직원의 급여보다 큰 모든 직원의 사번, 이름, 급여 출력
-- (or 연산 --> 급여가 12008보다 큰)
select employee_id, first_name, salary
from employees
where salary > all ( select salary
                     from employees
                     where department_id = 110 );      
                     
-- 각 부서별로 최고 급여를 받는 사원 출력
select  department_id "부서번호",
        employee_id "사원번호",
        first_name "이름",
        salary "급여"
from employees
where ( department_id, salary ) in ( select department_id,
                                            max(salary)
                                     from employees
                                     group by department_id );

select  e.department_id "부서번호",
        e.employee_id "사원번호",
        e.first_name "이름",
        e.salary "급여"
from employees e, ( select department_id, max(salary) salary
                    from employees
                    group by department_id ) s
where e.department_id = s.department_id
and e.salary = s.salary;

/* [ rownum ] */
-- 급여를 가장 많이 받는 직원 5명을 출력
select  w.rn,
        w.first_name,
        w.salary 
from ( select rownum rn,
              e.first_name,
              e.salary
        from ( select first_name,
                      salary
               from employees
               order by salary desc
              ) e
      ) w
where rn >= 11 and rn <=20;

-- 07년에 입사한 직원 중 3 ~ 7번째로 급여가 많은 사원의 이름, 급여, 입사일
select w.rn,
       w.first_name,
       w.salary,
       w.hire_date
from ( select  rownum rn,
               e.first_name,
               e.salary,
               e.hire_date
       from ( select first_name,
                     salary,
                     hire_date
              from employees
              where hire_date like '07%'
              order by salary desc
             ) e
       ) w
where rn >= 3 and rn <=7;