/* =============================================================
   PART 1: Window Functions (Modern SQL)
   * The "Big 3": ROW_NUMBER, RANK, DENSE_RANK
   ============================================================= */

-- 1. Finding the N-th Highest Salary (The Best Way)
-- Use DENSE_RANK() because it handles duplicates without gaps.
SELECT * FROM (
    SELECT ename, sal,
           DENSE_RANK() OVER (ORDER BY sal DESC) as rnk
    FROM   emp
)
WHERE rnk = 2; -- Change to 3, 4, 5 for any rank.

-- 2. Ranking within Departments
-- "Who is the top earner in EACH department?"
SELECT * FROM (
    SELECT ename, deptno, sal,
           DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) as rnk
    FROM   emp
)
WHERE rnk = 1;

/* =============================================================
   PART 2: Deleting Duplicates (The #1 Data Cleaning Question)
   ============================================================= */

-- 1. Standard SQL Method (Using ROW_NUMBER)
-- "Keep the row with the lowest ID, delete the rest."
DELETE FROM emp
WHERE rowid IN (
    SELECT rid FROM (
        SELECT rowid as rid,
               ROW_NUMBER() OVER (PARTITION BY ename, email ORDER BY empno ASC) as rn
        FROM   emp
    )
    WHERE rn > 1 -- These are the duplicates
);

/* =============================================================
   PART 3: Set Operators (Combining Result Sets)
   ============================================================= */

-- 1. UNION vs UNION ALL
-- UNION removes duplicates (Slower).
-- UNION ALL keeps duplicates (Faster).
SELECT ename FROM emp
UNION ALL
SELECT ename FROM retired_emp;

-- 2. MINUS (Finding differences)
-- "Find IDs present in Table A but NOT in Table B"
SELECT empno FROM emp
MINUS
SELECT empno FROM new_emp;

/* =============================================================
   PART 4: Logic Puzzles (Noob vs Pro)
   ============================================================= */

-- 1. Find Employees Hired on Weekends
-- Logic: Use TO_CHAR with 'DY' (Day abbreviation)
SELECT * FROM emp
WHERE TO_CHAR(hiredate, 'DY') IN ('SAT', 'SUN');

-- 2. Find "Orphans" (Depts with No Employees)
-- Pro Method: Left Join + IS NULL
SELECT d.dname
FROM dept d
LEFT JOIN emp e ON d.deptno = e.deptno
WHERE e.empno IS NULL;

-- 3. Extract Email Domain ('gmail.com')
-- Logic: Substr from (Position of @) + 1
SELECT SUBSTR(email, INSTR(email, '@') + 1) 
FROM users;

-- 4. Count Words in a Sentence
-- Logic: (Length of String) - (Length of String without Spaces) + 1
SELECT LENGTH(desc) - LENGTH(REPLACE(desc, ' ', '')) + 1
FROM products;
