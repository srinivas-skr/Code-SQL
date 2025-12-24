/* =============================================================
   PART 1: DDL (Data Definition Language) - The Structure
   * Auto-Committed (Cannot Rollback)
   * Commands: CREATE, ALTER, DROP, TRUNCATE, RENAME
   ============================================================= */

-- 1. Create a Table (The Blueprint)
CREATE TABLE emp (
    empno    NUMBER(4) PRIMARY KEY, -- Constraint: Unique + Not Null
    ename    VARCHAR2(10),
    job      VARCHAR2(9),
    mgr      NUMBER(4),
    hiredate DATE,
    sal      NUMBER(7,2),
    comm     NUMBER(7,2),
    deptno   NUMBER(2)
);

-- 2. Alter Table (The Renovation)
-- A. Add a new column
ALTER TABLE emp ADD gender VARCHAR2(1);

-- B. Modify an existing column (Change data type or size)
-- Warning: Can only shrink size if column is empty!
ALTER TABLE emp MODIFY ename VARCHAR2(20);

-- C. Rename a column
ALTER TABLE emp RENAME COLUMN gender TO sex;

-- D. Drop a column (Deletes data in that column forever)
ALTER TABLE emp DROP COLUMN sex;

-- 3. Truncate (The Factory Reset)
-- * Removes ALL rows.
-- * Resets High Water Mark (Storage).
-- * Faster than DELETE.
-- * Cannot be Rolled Back (DDL).
-- TRUNCATE TABLE emp; 

-- 4. Drop (The Demolition)
-- * Removes table structure AND data.
-- * Moves to Recycle Bin (in Oracle).
-- DROP TABLE emp;
-- DROP TABLE emp PURGE; (Skips Recycle Bin - Gone Forever)

/* =============================================================
   PART 2: DML (Data Manipulation Language) - The Data
   * Not Auto-Committed (Can Rollback)
   * Commands: INSERT, UPDATE, DELETE
   ============================================================= */

-- 1. Insert Data (Adding Rows)
-- Best Practice: List columns explicitly to avoid errors if schema changes.
INSERT INTO emp (empno, ename, sal, deptno) VALUES (7839, 'KING', 5000, 10);
INSERT INTO emp VALUES (7698, 'BLAKE', 'MANAGER', 7839, '01-MAY-81', 2850, NULL, 30);

-- 2. Update Data (Modifying Rows)
-- Critical: Always use WHERE clause, or you update EVERY row!
UPDATE emp SET sal = sal * 1.10 WHERE deptno = 10; -- 10% Hike

-- 3. Delete Data (Removing Rows)
-- Critical: Always use WHERE clause!
-- Slower than Truncate because it logs every row.
DELETE FROM emp WHERE empno = 7698;

/* =============================================================
   PART 3: TCL (Transaction Control Language) - The Save Game
   * Controls DML operations only.
   ============================================================= */

-- 1. Commit (Save Game)
-- Saves all changes made since the last commit permanently.
COMMIT;

-- 2. Rollback (Undo)
-- Undoes all changes made since the last commit.
-- Good for error handling (e.g., if Java code crashes).
ROLLBACK;

-- 3. Savepoint (Checkpoint)
-- Allows partial rollback.
INSERT INTO emp VALUES (1, 'A', ...);
SAVEPOINT s1;
INSERT INTO emp VALUES (2, 'B', ...);
ROLLBACK TO s1; -- Undoes 'B', but keeps 'A'.
COMMIT; -- Saves 'A'.
