/* =============================================================
   PART 1: The JOIN Syntax
   * ANSI Style (Recommended): JOIN ... ON ...
   * Oracle Style (Old): FROM A, B WHERE ...
   ============================================================= */

-- 1. INNER JOIN (The "Couples Only" Party)
-- Keeps only rows that match in BOTH tables.
SELECT e.ename, d.dname
FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno;

-- 2. LEFT JOIN (The "Loyal Friend" - Keep Left)
-- Keeps all EMP rows. Unmatched DEPT info is NULL.
SELECT e.ename, d.dname
FROM emp e
LEFT JOIN dept d ON e.deptno = d.deptno;

-- 3. RIGHT JOIN (The "Loyal Friend" - Keep Right)
-- Keeps all DEPT rows. Unmatched EMP info is NULL.
SELECT e.ename, d.dname
FROM emp e
RIGHT JOIN dept d ON e.deptno = d.deptno;

-- 4. FULL JOIN (The "Everyone Dances" Party)
-- Keeps everything from both sides.
SELECT e.ename, d.dname
FROM emp e
FULL OUTER JOIN dept d ON e.deptno = d.deptno;

/* =============================================================
   PART 2: SELF JOIN (Joining a table to itself)
   * Must use Aliases (e1, e2)
   ============================================================= */

-- 1. Find Employee Name and their Manager Name
SELECT worker.ename AS Employee, boss.ename AS Manager
FROM emp worker
INNER JOIN emp boss ON worker.mgr = boss.empno;

-- 2. Find Employees earning MORE than their Manager
SELECT worker.ename
FROM emp worker
INNER JOIN emp boss ON worker.mgr = boss.empno
WHERE worker.sal > boss.sal;

/* =============================================================
   PART 3: Advanced Join Tricks
   ============================================================= */

-- 1. Anti-Join (Finding "Orphans")
-- "Find Departments with NO Employees"
-- Logic: Left Join Dept to Emp -> Filter where Emp ID is NULL
SELECT d.dname
FROM dept d
LEFT JOIN emp e ON d.deptno = e.deptno
WHERE e.empno IS NULL;

-- 2. Cross Join (Cartesian Product)
-- Multiplies every row by every row. (Usually a mistake!)
SELECT * FROM emp CROSS JOIN dept;

/* =============================================================
   PART 4: The Golden Rule (ON vs WHERE)
   * IN
