/* =============================================================
   PART 1: The WHERE Clause & Basic Operators
   ============================================================= */

-- 1. Numeric Filtering
-- Standard comparison
SELECT * FROM emp WHERE sal > 2000;
-- "Not Equal" (Can use !=, <>, ^=)
SELECT * FROM emp WHERE deptno <> 10;

-- 2. Range Logic (BETWEEN)
-- Rule: BETWEEN is Inclusive. Always Low Value first, High Value second.
-- Correct:
SELECT * FROM emp WHERE sal BETWEEN 1000 AND 3000;
-- Incorrect (Will return 0 rows):
-- SELECT * FROM emp WHERE sal BETWEEN 3000 AND 1000;

-- 3. The "Strictly Between" Trick (Greater than 1000 but less than 2000)
-- Don't use BETWEEN here (because of decimals). Use logic.
SELECT * FROM emp WHERE sal > 1000 AND sal < 2000;

/* =============================================================
   PART 2: Handling NULLs (The "Golden Rule")
   ============================================================= */

-- 1. Finding Empty Values
-- WRONG: WHERE comm = NULL (Never works!)
-- RIGHT:
SELECT * FROM emp WHERE comm IS NULL;

-- 2. Finding Non-Empty Values
SELECT * FROM emp WHERE comm IS NOT NULL;

-- 3. Logic with NULLs
-- "Find employees who earn commission but have no salary"
SELECT * FROM emp WHERE comm IS NOT NULL AND sal IS NULL;

/* =============================================================
   PART 3: List Operators (IN / NOT IN)
   ============================================================= */

-- 1. Matching a list
SELECT * FROM emp WHERE job IN ('CLERK', 'MANAGER');

-- 2. The "NOT IN" Trap (Important!)
-- If the list contains a NULL, NOT IN returns NOTHING.
-- Query: "Find employees not in the list (10, 20, NULL)"
-- Result: 0 rows. (Because "Not equal to Unknown" is Unknown)
SELECT * FROM emp WHERE deptno NOT IN (10, 20, NULL); 

/* =============================================================
   PART 4: Pattern Matching (LIKE / NOT LIKE / ESCAPE)
   ============================================================= */

-- 1. Basics
-- Starts with 'S'
SELECT * FROM emp WHERE ename LIKE 'S%';
-- Ends with 'S'
SELECT * FROM emp WHERE ename LIKE '%S';
-- Contains 'A' anywhere
SELECT * FROM emp WHERE ename LIKE '%A%';

-- 2. Tricky Logic
-- "Starts with 'A' AND Ends with 'S'" (The Sandwich)
SELECT * FROM emp WHERE ename LIKE 'A%S';
-- "Contains 'A' as the 2nd letter"
SELECT * FROM emp WHERE ename LIKE '_A%';
-- "Exactly 4 characters long"
SELECT * FROM emp WHERE ename LIKE '____';

-- 3. The "Two Pattern" Rule
-- "Name contains 'D' AND 'T'" (Order doesn't matter)
-- Wrong: LIKE '%D%T%' (Enforces D before T)
-- Right:
SELECT * FROM emp WHERE ename LIKE '%D%' AND ename LIKE '%T%';

-- 4. The ESCAPE Clause (Advanced)
-- "Name contains a literal underscore (_)"
-- We define '!' as the shield. '!_' means real underscore.
SELECT * FROM emp WHERE ename LIKE '%!_%' ESCAPE '!';
-- "Name starts with % and ends with _"
-- We sandwich the wildcard % in the middle.
SELECT * FROM emp WHERE ename LIKE '!%%!_' ESCAPE '!';
