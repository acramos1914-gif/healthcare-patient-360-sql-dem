SELECT COUNT(*) AS total_patients FROM patients;

SELECT patient_id, COUNT(*) AS encounter_rows
FROM encounters GROUP BY patient_id HAVING COUNT(*) > 1 ORDER BY patient_id;

SELECT patient_id, COUNT(*) AS trauma_rows
FROM trauma_registry GROUP BY patient_id HAVING COUNT(*) > 1 ORDER BY patient_id;

SELECT patient_id, COUNT(*) AS burn_rows
FROM burn_registry GROUP BY patient_id HAVING COUNT(*) > 1 ORDER BY patient_id;

SELECT patient_id, COUNT(*) AS claim_rows
FROM claims GROUP BY patient_id HAVING COUNT(*) > 1 ORDER BY patient_id;

SELECT patient_id, COUNT(*) AS allergy_rows
FROM allergies GROUP BY patient_id HAVING COUNT(*) > 1 ORDER BY patient_id;
