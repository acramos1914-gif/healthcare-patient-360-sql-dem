# Before vs. After

## Before: raw one-to-many join

A direct join can multiply rows when the same patient has several related records.

Example for one patient:

```text
patient_id | encounter_id | burn_id | claim_id
1001       | 5001         | 8001    | 9001
1001       | 5001         | 8001    | 9002
1001       | 5001         | 8002    | 9001
1001       | 5002         | 8001    | 9001
...
```

## After: controlled grain

Each child table is first aggregated to one row per patient, then the summaries are joined back to `patients`.

```text
patient_id | encounters | trauma | burns | claims | allergies
1001       | 3          | 2      | 2     | 3      | 2
```

The result keeps one row per patient without losing the summarized information.
