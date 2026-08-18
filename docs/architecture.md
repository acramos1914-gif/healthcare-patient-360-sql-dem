# Architecture

## Final grain
**1 row = 1 patient**

## Relationships
- patients -> encounters: 0..many
- patients -> trauma_registry: 0..many
- patients -> burn_registry: 0..many
- patients -> claims: 0..many
- patients -> allergies: 0..many

## Why direct joins duplicate rows
If one patient has 3 encounters, 2 burn records, 3 claims, and 2 allergies, a direct join can create many combinations for the same patient.

## Design pattern
1. Aggregate each child table to patient level.
2. Keep counts, first/latest dates, totals, and distinct descriptive values.
3. `LEFT JOIN` each one-row summary back to `patients`.
4. Preserve `NULL` where no source record exists.
