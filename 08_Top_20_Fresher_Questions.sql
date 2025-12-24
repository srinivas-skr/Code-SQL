/* =============================================================
   THE TOP 20 SQL INTERVIEW QUESTIONS (FRESHER LEVEL)
   Master these, and you pass the SQL round.
   ============================================================= */

/* --- CATEGORY 1: RANKING & DUPLICATES (The Big 3) --- */

-- Q1. Find the 2nd Highest Salary.
-- Trick: Use DENSE_RANK() to handle ties without skipping numbers.
SELECT MAX(sal) FROM (
    SELECT sal, DENSE_RANK() OVER (ORDER BY sal DESC) as rnk FROM emp
) WHERE rnk = 2;

-- Q2. How do you find Duplicate Records in a table?
-- Trick: Group by the columns and check COUNT > 1.
SELECT ename, email, COUNT(*)
FROM users
GROUP BY ename, email
HAVING COUNT(*) > 1;

-- Q3. How do you DELETE Duplicate Records but keep one?
-- Trick: Use ROWID (Oracle) or DELETE JOIN (MySQL).
-- Logic: Delete rows where ROWID is NOT the Minimum ROWID for that group.
DELETE FROM emp
WHERE rowid NOT IN (
    SELECT MIN(rowid) FROM emp GROUP BY ename
);

/* --- CATEGORY 2: JOINS & RELATIONS (The Logic Check) --- */

-- Q4. Find Employees who are also Managers.
-- Trick: Employee ID exists in the Manager ID column.
SELECT * FROM emp WHERE empno IN (SELECT mgr FROM emp);

-- Q5. Find Employees earning MORE than their Managers.
-- Trick: Self Join. Compare E1.Sal > E2.Sal.
SELECT e1.ename 
FROM emp e1 
JOIN emp e2 ON e1.mgr = e2.empno 
WHERE e1.sal > e2.sal;

-- Q6. Find Departments that have NO Employees.
-- Trick: Left Join Dept -> Emp. Filter where Emp ID is NULL.
SELECT d.dname 
FROM dept d 
LEFT JOIN emp e ON d.deptno = e.deptno 
WHERE e.empno IS NULL;

-- Q7. Find Employees who do NOT have a Manager.
-- Trick: Use IS NULL on the mgr column.
SELECT * FROM emp WHERE mgr IS NULL;

/* --- CATEGORY 3: AGGREGATION & GROUPING (The Summary) --- */

-- Q8. Count the number of Employees in each Department.
-- Trick: Group By Deptno.
SELECT deptno, COUNT(*) FROM emp GROUP BY deptno;

-- Q9. Find Departments with more than 3 Employees.
-- Trick: WHERE filters rows, HAVING filters groups.
SELECT deptno, COUNT(*) 
FROM emp 
GROUP BY deptno 
HAVING COUNT(*) > 3;

-- Q10. Find the Maximum Salary in EACH Department.
-- Trick: Simple Max with Group By.
SELECT deptno, MAX(sal) FROM emp GROUP BY deptno;

/* --- CATEGORY 4: PATTERN MATCHING & DATE LOGIC (The Details) --- */

-- Q11. Find Employees whose name starts with 'S'.
-- Trick: LIKE 'S%' (Wildcard).
SELECT * FROM emp WHERE ename LIKE 'S%';

-- Q12. Find Employees whose name ends with 'R'.
-- Trick: LIKE '%R'.
SELECT * FROM emp WHERE ename LIKE '%R';

-- Q13. Find Employees hired in the current year (or a specific year).
-- Trick: Use TO_CHAR to extract the year.
SELECT * FROM emp WHERE TO_CHAR(hiredate, 'YYYY') = '2025';

-- Q14. Find Employees hired on a Weekend.
-- Trick: Use TO_CHAR with 'DY' or 'D'.
SELECT * FROM emp WHERE TO_CHAR(hiredate, 'DY') IN ('SAT', 'SUN');

-- Q15. Calculate the total experience (in years) of an employee.
-- Trick: (Months Between Today and Hiredate) / 12.
SELECT ename, ROUND(MONTHS_BETWEEN(SYSDATE, hiredate)/12, 1) FROM emp;

/* --- CATEGORY 5: TRICKY LOGIC (The "Gotchas") --- */

-- Q16. Find the first 5 records from a table.
-- Trick: Oracle = ROWNUM <= 5. MySQL = LIMIT 5.
SELECT * FROM emp WHERE ROWNUM <= 5;

-- Q17. Find the LAST record from a table.
-- Trick: Order by ID Descending and take the top 1.
SELECT * FROM (SELECT * FROM emp ORDER BY empno DESC) WHERE ROWNUM = 1;

-- Q18. Display odd/even rows.
-- Trick: Use MOD(column, 2).
SELECT * FROM emp WHERE MOD(empno, 2) = 1; -- Odd

-- Q19. How to get distinct records without using DISTINCT keyword?
-- Trick: Use GROUP BY (it implicitly removes duplicates).
SELECT ename FROM emp GROUP BY ename;

-- Q20. Find employees with NULL commission (Correct Syntax).
-- Trick: Never use = NULL.
SELECT * FROM emp WHERE comm IS NULL;
