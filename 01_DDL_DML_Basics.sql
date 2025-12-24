/* =============================================================
   PART 1: DDL - Creating Tables & Constraints
   The Rules of the House
   ============================================================= */

-- 1. Create Table with Inline Constraints (Simple Method)
CREATE TABLE dept (
    deptno NUMBER(2) PRIMARY KEY, -- Primary Key (Unique + Not Null)
    dname  VARCHAR2(14) NOT NULL, -- Not Null (Must have value)
    loc    VARCHAR2(13)
);

-- 2. Create Table with Out-of-Line Constraints (Professional Method)
CREATE TABLE emp (
    empno    NUMBER(4),
    ename    VARCHAR2(10),
    job      VARCHAR2(9),
    deptno   NUMBER(2),
    
    -- Defining Primary Key
    CONSTRAINT pk_emp PRIMARY KEY (empno),
    
    -- Defining Foreign Key (Links to DEPT table)
    -- "ON DELETE CASCADE" means if Dept is deleted, Employee is deleted too.
    CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) 
        REFERENCES dept(deptno) ON DELETE CASCADE,
        
    -- Defining Unique Key (No duplicates allowed)
    CONSTRAINT uk_ename UNIQUE (ename),
    
    -- Defining Check Constraint (Business Rule)
    CONSTRAINT chk_job CHECK (job IN ('CLERK', 'MANAGER', 'SALESMAN'))
);

-- 3. Adding Constraints LATER (Using ALTER)
-- "I forgot to make empno the Primary Key!"
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
-- "I want to link deptno to the dept table now!"
ALTER TABLE emp ADD CONSTRAINT fk_dept FOREIGN KEY (deptno) REFERENCES dept(deptno);

/* =============================================================
   PART 2: Database Objects (Views & Indexes)
   Performance & Shortcuts
   ============================================================= */

-- 1. Views (Virtual Table / Saved Query)
-- Simple View (One table, no functions) - Can Update data through it.
CREATE VIEW v_emp_dept10 AS
SELECT * FROM emp WHERE deptno = 10;

-- Complex View (Joins/Group By) - Read Only.
CREATE VIEW v_dept_stats AS
SELECT deptno, COUNT(*) as cnt, MAX(sal) as max_sal
FROM emp
GROUP BY deptno;

-- 2. Indexes (Performance Booster)
-- Automatically created for Primary Key & Unique Key.
-- Create manually for columns used in WHERE clauses often.
CREATE INDEX idx_emp_ename ON emp(ename);
-- Drop Index
DROP INDEX idx_emp_ename;

/* =============================================================
   PART 3: DML & TCL (Managing Data)
   ============================================================= */

-- 1. Insert
INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');

-- 2. Update
UPDATE dept SET loc = 'BOSTON' WHERE deptno = 10;

-- 3. Delete
DELETE FROM dept WHERE deptno = 10;

-- 4. Truncate (DDL - No Undo!)
-- TRUNCATE TABLE emp;

-- 5. Transactions
COMMIT;    -- Save
ROLLBACK;  -- Undo
SAVEPOINT s1; -- Checkpoint
