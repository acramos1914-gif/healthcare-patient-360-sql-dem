SELECT
    p.patient_id,
    p.first_name || ' ' || p.last_name AS patient_name,
    e.encounter_id,
    t.trauma_id,
    b.burn_id,
    c.claim_id,
    a.allergy_id
FROM patients p
LEFT JOIN encounters e ON p.patient_id = e.patient_id
LEFT JOIN trauma_registry t ON p.patient_id = t.patient_id
LEFT JOIN burn_registry b ON p.patient_id = b.patient_id
LEFT JOIN claims c ON p.patient_id = c.patient_id
LEFT JOIN allergies a ON p.patient_id = a.patient_id
ORDER BY p.patient_id;
