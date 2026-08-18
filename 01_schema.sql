DROP VIEW IF EXISTS patient_360;
DROP TABLE IF EXISTS allergies;
DROP TABLE IF EXISTS claims;
DROP TABLE IF EXISTS burn_registry;
DROP TABLE IF EXISTS trauma_registry;
DROP TABLE IF EXISTS encounters;
DROP TABLE IF EXISTS patients;

CREATE TABLE patients (
    patient_id INTEGER PRIMARY KEY,
    medical_record_number VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    sex VARCHAR(10),
    city VARCHAR(50),
    state CHAR(2)
);

CREATE TABLE encounters (
    encounter_id INTEGER PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES patients(patient_id),
    admit_date DATE NOT NULL,
    discharge_date DATE,
    facility VARCHAR(100),
    encounter_type VARCHAR(50),
    disposition VARCHAR(50)
);

CREATE TABLE trauma_registry (
    trauma_id INTEGER PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES patients(patient_id),
    encounter_id INTEGER REFERENCES encounters(encounter_id),
    injury_date DATE,
    injury_type VARCHAR(100),
    injury_severity_score INTEGER,
    trauma_level VARCHAR(20)
);

CREATE TABLE burn_registry (
    burn_id INTEGER PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES patients(patient_id),
    encounter_id INTEGER REFERENCES encounters(encounter_id),
    burn_date DATE,
    burn_type VARCHAR(50),
    burn_percentage NUMERIC(5,2),
    severity VARCHAR(20)
);

CREATE TABLE claims (
    claim_id INTEGER PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES patients(patient_id),
    encounter_id INTEGER REFERENCES encounters(encounter_id),
    claim_status VARCHAR(30),
    billed_amount NUMERIC(12,2),
    paid_amount NUMERIC(12,2)
);

CREATE TABLE allergies (
    allergy_id INTEGER PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES patients(patient_id),
    allergy_name VARCHAR(100),
    reaction VARCHAR(100)
);

CREATE INDEX idx_encounters_patient_id ON encounters(patient_id);
CREATE INDEX idx_trauma_patient_id ON trauma_registry(patient_id);
CREATE INDEX idx_burn_patient_id ON burn_registry(patient_id);
CREATE INDEX idx_claims_patient_id ON claims(patient_id);
CREATE INDEX idx_allergies_patient_id ON allergies(patient_id);
