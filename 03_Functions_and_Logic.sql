/* =============================================================
   PART 1: The NULL Problem in Math (NVL)
   ============================================================= */

-- 1. The Broken Calculation
-- If 'comm' is NULL, this returns NULL.
SELECT ename, sal + comm FROM emp;

-- 2. The Correct Calculation (Oracle)
-- NVL(col, 0) replaces NULL with 0.
SELECT ename, sal + NVL(comm, 0) AS total_pay FROM emp;

-- 3. The Modern Calculation (PostgreSQL / Universal)
-- COALESCE returns the first non-null value.
SELECT ename, sal + COALESCE(comm, 0) AS total_pay FROM emp;

/* =============================================================
   PART 2: Date Functions (Oracle Logic)
   ============================================================= */

-- 1. Current Date
SELECT SYSDATE FROM DUAL; -- Postgres: NOW()

-- 2. Date Math (Add Days/Months)
-- "7 Days from now"
SELECT SYSDATE + 7 FROM DUAL;
-- "6 Months ago"
SELECT ADD_MONTHS(SYSDATE, -6) FROM DUAL;

-- 3. Experience Calculation (Months Between)
-- "Years of experience"
SELECT ename, ROUND(MONTHS_BETWEEN(SYSDATE, hiredate)/12, 1) AS exp_years
FROM emp;

-- 4. Last Day of Month
-- "Find employees hired on the last day of their month"
SELECT * FROM emp WHERE hiredate = LAST_DAY(hiredate);

-- 5. Converting Date to Text (TO_CHAR)
-- "Find employees hired in 1981"
SELECT * FROM emp WHERE TO_CHAR(hiredate, 'YYYY') = '1981';
-- "Find employees hired in December"
SELECT * FROM emp WHERE TO_CHAR(hiredate, 'MM') = '12';

/* =============================================================
   PART 3: String Logic Tricks (SUBSTR + INSTR)
   ============================================================= */

-- 1. Extract First Name (Before the space)
-- Logic: Find space position, cut from 1 up to (position - 1)
SELECT SUBSTR(ename, 1, INSTR(ename, ' ') - 1) FROM emp;

-- 2. Extract Last Name (After the space)
-- Logic: Find space position, cut from (position + 1) to end
SELECT SUBSTR(ename, INSTR(ename, ' ') + 1) FROM emp;

-- 3. Count Occurrences of a Character
-- Logic: Original Length - Length without 'A'
SELECT LENGTH('BANANA') - LENGTH(REPLACE('BANANA', 'A', '')) FROM DUAL;

/* =============================================================
   PART 4: Math Logic (The "Money Pieces" Method)
   ============================================================= */

-- 1. Hike on Annual Salary (Permanent Change)
-- "Annual salary WITH a 10% hike" -> Multiplier Method
SELECT (sal * 12) * 1.10 FROM emp;

-- 2. Annual Salary + Bonus (One-Time)
-- "Annual salary PLUS a 10% monthly bonus" -> Addition Method
SELECT (sal * 12) + (sal * 0.10) FROM emp;

-- 3. Odd/Even Logic (MOD)
-- "Find employees with Odd Empno"
SELECT * FROM emp WHERE MOD(empno, 2) = 1;
