# 🚀 SQL Zero to Hero (Fresher Bootcamp)

Welcome to my complete SQL Learning Repository! 
This collection covers the entire **Oracle SQL Syllabus** required for a **Java Full Stack Fresher**, ranging from basic queries to advanced analytical logic.

---

## 📂 Repository Structure

### 🔹 1. Foundation & Structure
*   **`01_Structure_and_Objects.sql`**: 
    *   DDL (Create, Alter, Drop, Truncate)
    *   DML (Insert, Update, Delete)
    *   Constraints (PK, FK, Unique, Check)
    *   TCL (Commit, Rollback, Savepoint)

### 🔹 2. Filtering & Operators
*   **`02_Filtering_and_Operators.sql`**:
    *   `WHERE` clause logic
    *   Handling `NULL` (IS NULL vs = NULL)
    *   Pattern Matching (`LIKE`, `ESCAPE`)
    *   Range Checks (`BETWEEN`, `IN`)

### 🔹 3. Logic & Functions
*   **`03_Functions_and_Logic.sql`**:
    *   String Manipulation (`SUBSTR`, `INSTR`, `LENGTH`, `REPLACE`)
    *   Date Logic (`MONTHS_BETWEEN`, `ADD_MONTHS`, `LAST_DAY`)
    *   Handling Nulls in Math (`NVL`, `COALESCE`)

### 🔹 4. Aggregation & Grouping
*   **`04_Grouping_and_Aggregation.sql`**:
    *   `GROUP BY` vs `HAVING`
    *   Multi-Row Functions (`COUNT`, `MAX`, `SUM`)
    *   Filtering Grouped Data

### 🔹 5. The Art of Joins
*   **`05_Joins.sql`**:
    *   `INNER JOIN` (Matching Records)
    *   `LEFT / RIGHT JOIN` (Finding Unmatched Records)
    *   `SELF JOIN` (Employee-Manager Logic)
    *   `CROSS JOIN` vs `FULL JOIN`

### 🔹 6. Advanced Subqueries
*   **`06_Subqueries.sql`**:
    *   Single Row vs Multi Row Subqueries
    *   Co-Related Subqueries (Row-by-Row Execution)
    *   The `N-1` Logic for Ranking

### 🔹 7. Interview Logic & Window Functions
*   **`07_Tricky_Interview_Questions.sql`**:
    *   `ROW_NUMBER`, `RANK`, `DENSE_RANK`
    *   Solving Logic Puzzles (Delete Duplicates, Weekend Hires)

---

## 🔥 The Final Boss: Interview Cheat Sheet

### 📄 **`08_Top_20_Fresher_Questions.sql`**
A curated list of the **20 Most Frequently Asked SQL Questions** for freshers.
*   *2nd Highest Salary*
*   *Delete Duplicates*
*   *Self Joins*
*   *Complex Pattern Matching*

---

## 💡 Quick Logic Rules (My Notes)

1.  **Order of Execution:** `FROM` -> `WHERE` -> `GROUP BY` -> `HAVING` -> `SELECT` -> `ORDER BY`.
2.  **The Join Rule:** Use `ON` for connecting tables, `WHERE` for filtering data.
3.  **The NULL Rule:** Never use `=`, always use `IS NULL`.
4.  **The Count Rule:** `COUNT(*)` counts rows. `COUNT(col)` counts non-null values.

---

## 🛠️ Technology Stack
*   **Database:** Oracle SQL (Primary)
*   **Concepts:** ANSI SQL Standards (Compatible with MySQL/PostgreSQL)

---
*Created by Srinivasa K. Mastery achieved through rigorous logical practice.*
