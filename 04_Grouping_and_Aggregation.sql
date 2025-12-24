/* =============================================================
   PART 1: Basic Aggregation (Multi-Row Functions)
   * COUNT, SUM, AVG, MAX, MIN
   ============================================================= */

-- 1. Count All Rows (The Head Counter)
SELECT COUNT(*) FROM emp;

-- 2. Count Non-Null Values (The Column Checker)
-- This counts only employees who have a Commission
SELECT COUNT(comm) FROM emp;

-- 3. Max Salary
SELECT MAX(sal) FROM emp;

/* =============================================================
   PART 2: The GROUP BY Clause (The "Laundry Baskets")
   Rule: SELECT list must match GROUP BY list (or be an aggregate).
   ============================================================= */

-- 1. Simple Grouping
-- "Count employees in each department"
SELECT deptno, COUNT(*) 
FROM emp 
GROUP BY deptno;

-- 2. Grouping by Multiple Columns
-- "Count employees by Job within each Department"
SELECT deptno, job, COUNT(*) 
FROM emp 
GROUP BY deptno, job;

-- 3. Invalid Query (Common Mistake)
-- SELECT ename, COUNT(*) FROM emp GROUP BY deptno; 
-- Error: 'ename' is not in the GROUP BY list.

/* =============================================================
   PART 3: Filtering Groups (The HAVING Clause)
   Rule: WHERE filters Rows. HAVING filters Groups.
   ============================================================= */

-- 1. The "Two-Filter" Problem
-- "Find departments with > 3 employees"
SELECT deptno, COUNT(*) 
FROM emp 
GROUP BY deptno 
HAVING COUNT(*) > 3;

-- 2. Combining WHERE and HAVING
-- "Find departments with > 2 CLERKS"
SELECT deptno, COUNT(*) 
FROM emp 
WHERE job = 'CLERK'    -- Filter Rows first (Only Clerks)
GROUP BY deptno        -- Group the Clerks
HAVING COUNT(*) > 2;   -- Filter the Groups

/* =============================================================
   PART 4: Tricky Grouping Questions
   ============================================================= */

-- 1. Find Duplicate Names
-- Logic: Group by name, keep count > 1
SELECT ename, COUNT(*)
FROM emp
GROUP BY ename
HAVING COUNT(*) > 1;

-- 2. Find Jobs in Multiple Departments
-- Logic: Count DISTINCT departments per job
SELECT job
FROM emp
GROUP BY job
HAVING COUNT(DISTINCT deptno) > 1;

-- 3. Can HAVING exist without GROUP BY?
-- Yes, it treats the whole table as one group.
SELECT COUNT(*) FROM emp HAVING COUNT(*) > 5;
