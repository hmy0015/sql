/* [ JOIN ] */
-- 카디젼 프로덕트 : WHERE 절에 조인 조건을 주지 않는 것. 두 테이블의 행들로부터 가능한 모든 쌍이 추출.
select first_name, department_name
from employees, departments;

-- EQUI Join : 두 테이블 간의 칼럼 값들이 서로 일치하는 경우. JOIN 조건으로 '=' 연산자를 사용.
select  first_name, em.department_id,
        department_name, de.department_id
from employees em, departments de
where em.department_id = de.department_id;

-- 모든 직원이름, 업무명을 출력하세요.
select  e.job_id, e.first_name,
        j.job_id, j.job_title
from employees e, jobs j
where e.job_id = j.job_id;

-- 모든 직원이름, 부서이름, 업무명을 출력하세요.
select  e.first_name,
        d.department_name,
        j.job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id;

-- left outer join
select  e.employee_id, e.first_name, e.department_id,
        d.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;

select  e.employee_id, e.first_name, e.department_id,
        d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

-- right outer join
select  e.employee_id, e.first_name, e.department_id,
        d.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

select  e.employee_id, e.first_name, e.department_id,
        d.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

-- full outer join
select  e.employee_id, e.first_name, e.department_id,
        d.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

-- Self Join
select  emp.employee_id, emp.first_name, emp.manager_id,
        man.manager_id, 
        man.first_name "manager"
from employees emp, employees man
where emp.employee_id = man.employee_id;