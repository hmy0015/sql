/* [ 문제1 ]
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건) */
select first_name "이름",
        manager_id "매니저아이디",
        commission_pct "커미션 비율",
        salary "월급"
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000;        

/* [ 문제2 ]
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary),
입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요
 - 조건절비교 방법으로 작성하세요
 - 급여의 내림차순으로 정렬하세요
 - 입사일은 2001-01-13 토요일 형식으로 출력합니다.
 - 전화번호는 515-123-4567 형식으로 출력합니다.
(11건) */
select employee_id "사번",
        first_name "이름",
        salary "급여",
        to_char(hire_date, 'YYYY-MM-DD DAY') "입사일",
        replace(phone_number, '.', '-') "전화번호",
        department_id "부서번호"
from employees
where (department_id, salary ) in ( select department_id, max(salary)
                                    from employees
                                    group by department_id )
order by salary desc;

/* [ 문제3 ]
매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다.
 - 통계대상(직원)은 2005년 이후의 입사자입니다.
 - 매니저별 평균급여가 5000 이상만 출력합니다.
 - 매니저별 평균급여의 내림차순으로 출력합니다.
 - 매니저별 평균급여는 소수점 첫째자리에서 반올림합니다.
 - 출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여,
   매니저별최소급여, 매니저별최대급여입니다.
(9건) */

/* [ 문제4 ]
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name),
매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명) */
select e.employee_id "사번",
       e.first_name "이름",
       d.department_name "부서명",
       m.first_name "매니저 이름"
from employees e,
     employees m,
     departments d
where e.manager_id = m.employee_id
and e.department_id = d.department_id(+);

/* [ 문제5 ]
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요 */
select r.rn,
       r.employee_id "사번",
       r.first_name "이름",
       r.department_name "부서명",
       r.salary "급여",
       r.hire_date "입사일"
from ( select rownum rn,
              h.employee_id,
              h.first_name,
              h.department_name,
              h.salary,
              h.hire_date
       from ( select e.hire_date,
                     e.employee_id,
                     e.first_name,
                     d.department_name,
                     e.salary
              from employees e, departments d
              where hire_date like '05%'
              and e.department_id = d.department_id
            ) h
      ) r 
where rn >= 11 and rn <= 20;

/* [ 문제6 ]
가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary), 근무하는 부서명(department_name)은? */
select e.first_name || ' ' || e.last_name "이름",
        e.salary "연봉",
        d.department_name "부서명",
        e.hire_date "입사일"
from employees e, departments d
where e.department_id = d.department_id
and hire_date = ( select max(hire_date)
                  from employees );

/* [ 문제7 ]
평균연봉(salary)이 가장 높은 부서 직원들의
사번(employee_id), 이름(firt_name), 성(last_name)과
급여(salary), 업무(job_title)를 조회하시오. */   
select e.employee_id "사번",
        e.first_name "이름",
        e.last_name "성",
        e.salary "급여",
        j.job_title "업무"
from employees e, jobs j
where e.job_id = j.job_id
and e.department_id = ( select d.department_id
                           from departments d,
                                employees e
                           where d.department_id = e.department_id
                           group by d.department_id
                           having avg(salary) = ( select max(avg(salary))
                                                  from employees
                                                  group by department_id
                                                 )
                          );

-----------------------------------------------------

select e.employee_id "사번",
        e.first_name "이름",
        e.last_name "성",
        e.salary "급여",
        j.job_title "업무"
from employees e,
     jobs j,
     ( select avg(salary) salary,
              department_id
       from employees
       group by department_id
     ) es,
     ( select max(avg(salary)) salary
       from employees
       group by department_id
     ) s
where e.department_id = es.department_id
and e.job_id = j.job_id
and es.salary = s.salary;
                          
/* [ 문제8 ]
평균 급여(salary)가 가장 높은 부서는? */
select department_name
from departments dn
where dn.department_id = ( select d.department_id
                           from departments d,
                                employees e
                           where d.department_id = e.department_id
                           group by d.department_id
                           having avg(salary) = ( select max(avg(salary))
                                                  from employees
                                                  group by department_id
                                                 )
                          );

---------------------------------------------------

select d.department_name "부서명"
from departments d,
     ( select avg(salary) salary,
              department_id
       from employees
       group by department_id
     ) e,
     ( select max(avg(salary)) salary
       from employees
       group by department_id
     ) s
where d.department_id = e.department_id
and e.salary = s.salary;    

/* [ 문제9 ]
평균 급여(salary)가 가장 높은 지역은? */
select region_name
from ( select rownum rn,
              region_name
       from ( select region_name,
                     avg(e.salary) salary
              from employees e,
                   departments d,
                   locations l,
                   countries c,
                   regions r
              where e.department_id = d.department_id
              and d.location_id = l.location_id
              and l.country_id = c.country_id
              and c.region_id = r.region_id
              group by r.region_name
              order by avg(e.salary) desc
            )
      )
where rn = 1;

/* [ 문제10 ]
평균 급여(salary)가 가장 높은 업무는? */
select j.job_title "업무명"
from employees e,
     jobs j
where e.job_id = j.job_id
group by job_title
having avg(salary) = ( select max(avg(salary))
                       from employees
                       group by job_id
                     );