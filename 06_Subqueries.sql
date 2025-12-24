/* =============================================================
   PART 1: Single Row Subquery (Standard)
   * Returns ONE value. Use operators: =, >, <
   ============================================================= */

-- 1. Same Table Logic
-- "Find employees earning more than SCOTT"
SELECT * FROM emp
WHERE sal > (SELECT sal FROM emp WHERE ename = 'SCOTT');

-- 2. Cross Table Logic
-- "Find employees working in ACCOUNTING" (Unknown Deptno)
SELECT * FROM emp
WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'ACCOUNTING');

/* =============================================================
   PART 2: Multi Row Subquery (Standard)
   * Returns a LIST of values. Use operators: IN, ANY, ALL
   ============================================================= */

-- 1. Using IN (Or Logic)
-- "Find employees in Sales or Operations"
SELECT * FROM emp
WHERE deptno IN (SELECT deptno FROM dept WHERE dname IN ('SALES', 'OPERATIONS'));

-- 2. Using ALL (Strict Logic)
-- "Earn more than ALL Managers" (Greater than the max manager salary)
SELECT * FROM emp
WHERE sal > ALL (SELECT sal FROM emp WHERE job = 'MANAGER');

-- 3. Using ANY (Easy-going Logic)
-- "Earn more than ANY Manager" (Greater than the min manager salary)
SELECT * FROM emp
WHERE sal > ANY (SELECT sal FROM emp WHERE job = 'MANAGER');

/* =============================================================
   PART 3: Co-Related Subquery (Row-by-Row)
   * Inner query runs once for EVERY row of Outer query.
   ============================================================= */

-- 1. The "Personal Shopper"
-- "Find employees earning more than the AVG of THEIR OWN dept"
SELECT e1.ename, e1.sal
FROM emp e1
WHERE sal > (SELECT AVG(sal) 
             FROM emp e2 
             WHERE e2.deptno = e1.deptno); -- The Co-Relation Link

-- 2. The N-th Max Salary (Classic N-1 Rule)
-- "Find the 5th Highest Salary"
SELECT DISTINCT sal
FROM emp e1
WHERE (SELECT COUNT(DISTINCT sal) 
       FROM emp e2 
       WHERE e2.sal > e1.sal) = 4; -- (N-1)

/* =============================================================
   PART 4: Subquery vs. Join
   ============================================================= */

-- Subquery: Good for filtering, but can usually only select columns from outer table.
-- Join: Good for displaying columns from BOTH tables.
