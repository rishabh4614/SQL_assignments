


use ZensarDB;

create table DEPT
(
	deptno int primary key, 
	dname varchar(20), 
	loc varchar(20)
); 

create table EMP
(
	empno int,
	ename varchar(20),
	job   char(20),
	mgr   int,
	hiredate  varchar(20),
	sal  decimal(10,2),
	comm int,
	deptno int
);



--sp_help DEPT;


insert into EMP
values (7499,   'ALLEN',      'SALESMAN',     7698,    '20-FEB-81',    	 1600,     300,    30),
       (7521,    'WARD',	  'SALESMAN',      7698,    '22-FEB-81',  	 1250,     500,    30),
	   (7654,    'MARTIN',    'SALESMAN',      7698,    '28-SEP-81',  	 1250,    1400,   30),
	   (7844,    'TURNER',    'SALESMAN',      7698,    '08-SEP-81',     1500,      0,     30);

insert into EMP(empno,ename,job,mgr,hiredate,sal,deptno)
values (7369,'SMITH','CLERK',7902,'17-DEC-80',800,20),
       (7566,    'JONES',     'MANAGER',       7839,    '02-APR-81',   	 2975,            20),
       (7698,	'BLAKE', 	  'MANAGER', 	7839, 	'01-MAY-81',    	 2850,            30),
	   (7782,  	'CLARK',     'MANAGER',       7839,    '09-JUN-81',   	 2450,            10),
	   (7788,  	'SCOTT',     'ANALYST',       7566,    '19-APR-87',        3000,            20),
	   (7876,    'ADAMS',     'CLERK',         7788,    '23-MAY-87',        1100,            20),
	   (7900,    'JAMES',     'CLERK',         7698,    '03-DEC-81',  	  950,            30),
	   (7902,    'FORD',      'ANALYST',       7566,    '03-DEC-81',   	 3000,            20),
	   (7934,    'MILLER',    'CLERK',         7782,    '23-JAN-82',	 1300,            10);

insert into EMP(empno,ename,job,hiredate,sal,deptno)
values (7839,    'KING',      'PRESIDENT',             '17-NOV-81',        5000,            10);

insert into DEPT
values(10,     'ACCOUNTING',   'NEW YORK'),
	(20,     'RESEARCH',      'DALLAS' ),
	(30,     'SALES',         'CHICAGO'),
	(40,     'OPERATIONS',   'BOSTON');


-- Assignment 1

--1. List all employees whose name begins with 'A'. 
SELECT * FROM EMP WHERE ENAME LIKE 'A%';
--2. Select all those employees who don't have a manager. 
SELECT * FROM EMP WHERE MGR IS NULL;
--3. List employee name, number and salary for those employees who earn in the range 1200 to 1400.
select ename,empno,sal from EMP where sal between 1200 and 1400;
--4. Give all the employees in the RESEARCH department a 10% pay rise. Verify that this has been done by listing all their details before and after the rise. 
update EMP set sal = case deptno 
	when 20 then sal+(sal*0.10) 
	else sal 
	end
	where deptno in (10,20,30,40)
	select * from  EMP;
--5. Find the number of CLERKS employed. Give it a descriptive heading. 
select  COUNT(job) from EMP where job = 'CLERK' 
--6. Find the average salary for each job type and the number of people employed in each job.
select COUNT(job),AVG(sal) from EMP where job = 'SALESMAN' 
select COUNT(job),AVG(sal) from EMP where job = 'ANALYST' 
select COUNT(job),AVG(sal) from EMP where job = 'CLERK' 
select COUNT(job),AVG(sal) from EMP where job = 'MANAGER' 
select COUNT(job),AVG(sal) from EMP where job = 'PRESIDENT' 
--7. List the employees with the lowest and highest salary. 
SELECT MAX(sal), MIN(sal) 
     FROM EMP;
--8. List full details of departments that don't have any employees. 
select * from DEPT where deptno not in (select deptno from EMP)
--9. Get the names and salaries of all the analysts earning more than 1200 who are based in department 20. Sort the answer by ascending order of name. 
select ename, sal from EMP where sal > 1200 and job = 'ANALYST' order by ename
--10. For each department, list its name and number together with the total salary paid to employees in that department. 
select dname, deptno , sum(e.sal) from DEPT as d ,EMP as e where deptno = deptno
--11. Find out salary of both MILLER and SMITH.
select * from EMP where  ename in ('MILLER','SMITH')
--12. Find out the names of the employees whose name begin with ‘A’ or ‘M’. 
select * from EMP where ename like 'a%' or ename like 'm%'
--13. Compute yearly salary of SMITH. 
 select ename,sal*12 from EMP where ename = 'SMITH'
--14. List the name and salary for all employees whose salary is not in the range of 1500 and 2850. 
select ename, sal from EMP where sal not between 1500 and 2850


-- Assignment 2


--1. Retrieve a list of MANAGERS. 
select * from EMP where job = 'MANAGER'
--2. Find out salary of both MILLER and SMITH. 
select ename, sal from EMP where ename in ('MILLER', 'SMITH')
--3. Find out the names and salaries of all employees earning more than 1000 per month. 
select ename, sal from EMP where sal > 1000
--4. Display the names and salaries of all employees except JAMES. 
select ename, sal from EMP where ename not in ('JAMES') 
--5. Find out the details of employees whose names begin with ‘S’. 
select * from EMP where ename like 'S%'
--6. Find out the names of all employees that have ‘A’ anywhere in their name. 
select * from EMP where ename like '%A%'
--7. Find out the names of all employees that have ‘L’ as their third character in their name. 
select * from EMP where ename like '__L%'
--8. Find out the names of the employees whose name begin with ‘A’ or ‘M’. 
select * from EMP where ename like 'A%' or ename like 'M%'
--9. Compute yearly salary of SMITH. 
select ename, sal*12 from EMP where ename = 'SMITH'
--10. Compute daily salary of JONES. 
select ename,sal/30 from EMP where ename = 'JONES'
--11. Calculate the total monthly salary of all employees. 
select ename, sal*12 from EMP
--12. Print the average annual salary. 
select AVG(sal) from EMP
--13. Select the name, job, salary, department number of all employees except SALESMAN from department number 30. 
select ename,job,sal,deptno from EMP where job not in ('SALESMAN') and deptno not in (30)
--14. List unique departments of the EMP table. 
select distinct deptno from EMP
--15. List the name and salary of employees who earn more than 1500 and are in department 10 or 30. Label the columns Employee and Monthly Salary respectively.
select ename, sal from EMP where sal > 1500 and (deptno = 10 or deptno = 30)


