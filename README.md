# Healthcare Patient 360 SQL Demo

A PostgreSQL portfolio project showing how to consolidate multiple one-to-many healthcare data sources into **one row per patient**.

## Problem
A patient can have multiple encounters, trauma records, burn records, claims, and allergies. A direct multi-table join can multiply rows.

## Solution
Aggregate each child table to **one row per patient first**, then `LEFT JOIN` those summaries back to the patient table.

This preserves:
- one row per patient
- all relevant source information
- `NULL` when no related record exists
- correct counts and totals

## Files
- `01_schema.sql` - tables and indexes
- `02_seed_data.sql` - fictional sample data
- `03_problem_query.sql` - demonstrates row multiplication
- `04_solution_query.sql` - produces one Patient 360 row
- `05_validation_queries.sql` - checks duplicate source IDs
- `06_patient_360_view.sql` - reusable PostgreSQL view
- `docs/architecture.md` - design explanation

## Quick test in DB Fiddle
Use PostgreSQL.

Paste `01_schema.sql` and `02_seed_data.sql` into **Schema SQL**.

Run `03_problem_query.sql` first to see the duplicate-row problem.

Then run `04_solution_query.sql` to see the one-row-per-patient solution.

## Interview explanation
> The challenge is not just joining the tables. The challenge is preserving the target grain when each source contains multiple rows for the same patient. I aggregate each one-to-many dataset to the patient grain first, then left join the summaries back to the patient table. That prevents row multiplication while preserving NULLs when a patient has no related record.

## Disclaimer
All data is fictional and created for portfolio/interview demonstration only.
