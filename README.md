[README.md](https://github.com/user-attachments/files/31200426/README.md)
# Healthcare Patient 360 SQL Demo

A PostgreSQL portfolio project that demonstrates how to turn multiple one-to-many healthcare data sources into a **single consolidated row per patient**.

## The problem

Healthcare data is often spread across multiple tables such as:

- patients
- encounters
- trauma registry records
- burn registry records
- claims
- allergies

The same patient can appear multiple times in several of these tables.

If the tables are joined directly, the result can create duplicate or multiplied rows for the same patient.

### Example

A patient may have:

- 3 encounters
- 2 burn records
- 3 claims
- 2 allergies

A direct join can produce many combinations of those records instead of one clean patient row.

## Goal

Create a reusable dataset where:

- each patient appears exactly once
- information from multiple source tables is preserved
- multiple source records are summarized into columns
- missing source data remains `NULL`
- counts, dates, totals, and descriptive values remain accurate

## Approach

The solution uses a two-step pattern.

### Step 1: Aggregate each one-to-many table

Each child table is summarized to the target grain:

**1 row per patient**

Examples:

- encounters -> encounter count, first date, latest date, facilities, visit types
- trauma -> record count, injury types, trauma levels
- burns -> record count, burn types, severity
- claims -> claim count, billed total, paid total, statuses
- allergies -> allergy count and allergy list

### Step 2: Join the summaries back to patients

Each aggregated dataset is `LEFT JOIN`ed back to the patient table.

This preserves every patient and produces `NULL` when a patient has no matching record in a source table.

## Why this works

The key idea is to control the **grain** before joining.

Instead of joining several raw one-to-many datasets together, each source is first reduced to one row per patient.

```text
encounters       many rows -> 1 patient summary
trauma_registry  many rows -> 1 patient summary
burn_registry    many rows -> 1 patient summary
claims           many rows -> 1 patient summary
allergies        many rows -> 1 patient summary
                           |
                           v
                      LEFT JOIN
                           |
                           v
                    1 row per patient
```

## SQL techniques demonstrated

- PostgreSQL
- Common Table Expressions (`WITH`)
- `LEFT JOIN`
- `GROUP BY`
- `COUNT`
- `MIN`
- `MAX`
- `SUM`
- `STRING_AGG`
- `DISTINCT`
- primary and foreign keys
- indexes
- validation queries
- reusable database views

## Project structure

```text
healthcare-patient-360-sql-demo/
├── README.md
├── sql/
│   ├── 01_schema.sql
│   ├── 02_seed_data.sql
│   ├── 03_problem_query.sql
│   ├── 04_solution_query.sql
│   ├── 05_validation_queries.sql
│   └── 06_patient_360_view.sql
├── docs/
│   └── architecture.md
└── sample_output/
    └── expected_patient_360.csv
```

## How to test

Use PostgreSQL or an online PostgreSQL environment such as DB Fiddle.

### 1. Build the sample database

Run:

- `sql/01_schema.sql`
- `sql/02_seed_data.sql`

### 2. Reproduce the problem

Run:

- `sql/03_problem_query.sql`

This intentionally joins the raw one-to-many tables and demonstrates row multiplication.

### 3. Run the solution

Run:

- `sql/04_solution_query.sql`

The final result should contain exactly one row per patient.

### 4. Validate the source data

Run:

- `sql/05_validation_queries.sql`

These queries prove that several source tables really do contain multiple records for the same patient.

### 5. Create a reusable view

Run:

- `sql/06_patient_360_view.sql`

Then query:

```sql
SELECT *
FROM patient_360
ORDER BY patient_id;
```

## What I learned

The important lesson is that a multi-table data problem is not solved simply by adding more joins.

Before combining datasets, I need to define the desired output grain and make sure each source is transformed to that same grain.

For this project, the desired grain is:

> **One row per patient**

Aggregating each child dataset first prevents row multiplication and creates a cleaner dataset for analytics, reporting, dashboards, or downstream pipelines.

## Interview-sized explanation

> The challenge was maintaining one row per patient while combining several one-to-many datasets. I first aggregated each source table to the patient level, then left joined those summaries back to the patient table. That prevented row multiplication, preserved the available information, and left NULLs where no related record existed.

## Disclaimer

All names and healthcare records in this repository are fictional and were created solely for portfolio and learning purposes. No real patient data or proprietary company information is included.


## Data model

GitHub can render the project ERD directly from Mermaid:

See [`docs/data-model.md`](docs/data-model.md).

## Before vs. after

See [`docs/before-after.md`](docs/before-after.md) for a simple illustration of how raw one-to-many joins multiply rows and how the final design restores one row per patient.

## Dashboard layer

The repository now includes a dashboard-ready Patient 360 dataset:

`dashboard/patient_360_dashboard.csv`

It can be loaded directly into Tableau Public to build:

- KPI cards for patients, encounters, trauma, burns, claims, billed, paid, and outstanding
- encounters by facility
- claims by status
- burn severity
- trauma level
- a patient-level detail table

See [`dashboard/README.md`](dashboard/README.md) for the build guide.

The complete project flow is:

```text
Raw source tables
      ↓
Duplicate-row problem
      ↓
SQL aggregation by patient
      ↓
Patient 360 dataset
      ↓
Tableau dashboard
```
