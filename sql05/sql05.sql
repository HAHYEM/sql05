--문제1
select first_name || ' ' || last_name "name",
       e.salary "연봉",
       d.department_name "부서 이름"
from employees e,
     departments d
where d.department_id = e.department_id
    and hire_date in (select max(hire_date)
                      from employees);

--문제2
select e.first_name,  e.last_name ,j.job_title, e.salary, avg(e.salary) 
from employees e, jobs j
where e.job_id = j.job_id
    and e.department_id in (select department_id
                            from (select department_id, avg(salary) dept_avg
                                  from employees
                                  group by department_id ) a , 
                                 (select max(dept_avg) max_dept_avg
                                  from (select department_id, avg(salary) dept_avg
                                        from employees
                                        group by department_id)) b
                            where a.dept_avg = b.max_dept_avg)
group by e.first_name,  e.last_name ,j.job_title, e.salary;


--문제3
select d.department_name
from departments d
where department_id in (select department_id
                        from (select department_id, avg(salary) dept_avg
                              from employees
                              group by department_id ) a , 
                        (select max(dept_avg) max_dept_avg
                         from (select department_id, avg(salary) dept_avg
                               from employees
                               group by department_id)) b
                         where a.dept_avg = b.max_dept_avg);

--문제4....음.......;.


--문제5
select j.job_title
from employees e, jobs j
where e.job_id = j.job_id
    and e.job_id in (select job_id
                            from (select job_id, avg(salary) job_avg
                                  from employees
                                  group by job_id ) a , 
                                 (select max(job_avg) max_job_avg
                                  from (select job_id, avg(salary) job_avg
                                        from employees
                                        group by job_id)) b
                            where a.job_avg = b.max_job_avg);