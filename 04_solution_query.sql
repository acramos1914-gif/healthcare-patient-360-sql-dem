WITH encounter_summary AS (
    SELECT patient_id,
           COUNT(*) AS encounter_count,
           MIN(admit_date) AS first_admit_date,
           MAX(admit_date) AS latest_admit_date,
           STRING_AGG(DISTINCT facility, ', ' ORDER BY facility) AS facilities,
           STRING_AGG(DISTINCT encounter_type, ', ' ORDER BY encounter_type) AS encounter_types
    FROM encounters GROUP BY patient_id
),
trauma_summary AS (
    SELECT patient_id,
           COUNT(*) AS trauma_record_count,
           MIN(injury_date) AS first_trauma_date,
           MAX(injury_date) AS latest_trauma_date,
           MAX(injury_severity_score) AS max_injury_severity_score,
           STRING_AGG(DISTINCT injury_type, ', ' ORDER BY injury_type) AS injury_types,
           STRING_AGG(DISTINCT trauma_level, ', ' ORDER BY trauma_level) AS trauma_levels
    FROM trauma_registry GROUP BY patient_id
),
burn_summary AS (
    SELECT patient_id,
           COUNT(*) AS burn_record_count,
           MIN(burn_date) AS first_burn_date,
           MAX(burn_date) AS latest_burn_date,
           MAX(burn_percentage) AS max_burn_percentage,
           STRING_AGG(DISTINCT burn_type, ', ' ORDER BY burn_type) AS burn_types,
           STRING_AGG(DISTINCT severity, ', ' ORDER BY severity) AS burn_severities
    FROM burn_registry GROUP BY patient_id
),
claim_summary AS (
    SELECT patient_id,
           COUNT(*) AS claim_count,
           SUM(billed_amount) AS total_billed,
           SUM(paid_amount) AS total_paid,
           SUM(billed_amount - paid_amount) AS total_outstanding,
           STRING_AGG(DISTINCT claim_status, ', ' ORDER BY claim_status) AS claim_statuses
    FROM claims GROUP BY patient_id
),
allergy_summary AS (
    SELECT patient_id,
           COUNT(*) AS allergy_count,
           STRING_AGG(DISTINCT allergy_name, ', ' ORDER BY allergy_name) AS allergies,
           STRING_AGG(DISTINCT reaction, ', ' ORDER BY reaction) AS allergy_reactions
    FROM allergies GROUP BY patient_id
)
SELECT
    p.patient_id,
    p.medical_record_number,
    p.first_name,
    p.last_name,
    p.date_of_birth,
    p.sex,
    p.city,
    p.state,
    e.encounter_count,
    e.first_admit_date,
    e.latest_admit_date,
    e.facilities,
    e.encounter_types,
    t.trauma_record_count,
    t.first_trauma_date,
    t.latest_trauma_date,
    t.max_injury_severity_score,
    t.injury_types,
    t.trauma_levels,
    b.burn_record_count,
    b.first_burn_date,
    b.latest_burn_date,
    b.max_burn_percentage,
    b.burn_types,
    b.burn_severities,
    c.claim_count,
    c.total_billed,
    c.total_paid,
    c.total_outstanding,
    c.claim_statuses,
    a.allergy_count,
    a.allergies,
    a.allergy_reactions
FROM patients p
LEFT JOIN encounter_summary e ON p.patient_id = e.patient_id
LEFT JOIN trauma_summary t ON p.patient_id = t.patient_id
LEFT JOIN burn_summary b ON p.patient_id = b.patient_id
LEFT JOIN claim_summary c ON p.patient_id = c.patient_id
LEFT JOIN allergy_summary a ON p.patient_id = a.patient_id
ORDER BY p.patient_id;
